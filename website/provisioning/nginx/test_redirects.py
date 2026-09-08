"""
test_redirects.py

Tests the nginx redirect map by spinning up a temporary nginx:alpine Docker
container (no full website build needed) and verifying every redirect:

  1. Source path   → nginx returns 301 with the correct Location header
  2. Destination   → HEAD request to the target URL returns a non-4xx status
                     (pass --skip-dest-check to skip this step)

Usage:
    python website/provisioning/nginx/test_redirects.py [options]

Options:
    --port PORT          Local port for the test container  (default: 8181)
    --workers N          Parallel request workers          (default: 20)
    --skip-dest-check    Skip checking destination URLs on signalwire.com
    --keep-container     Leave the container running after tests finish
    --report FILE        Report output path (default: redirect_test_report.txt)
"""

import argparse
import concurrent.futures
import datetime
import http.client
import os
import subprocess
import sys
import time
import urllib.error
import urllib.request

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------
SCRIPT_DIR     = os.path.dirname(os.path.abspath(__file__))
MAP_FILE       = os.path.join(SCRIPT_DIR, "redirects.map")
NGINX_CONF     = os.path.join(SCRIPT_DIR, "nginx.conf")
DEFAULT_REPORT = os.path.join(SCRIPT_DIR, "redirect_test_report.txt")
CONTAINER_NAME = "sw_redirects_test"
NGINX_IMAGE    = "nginx:alpine"


# ---------------------------------------------------------------------------
# Data
# ---------------------------------------------------------------------------
class TestResult:
    __slots__ = (
        "source", "expected_dest",
        "redirect_ok", "redirect_status", "actual_location",
        "dest_status", "error",
    )

    def __init__(self, source, expected_dest,
                 redirect_ok, redirect_status, actual_location,
                 dest_status=0, error=""):
        self.source         = source
        self.expected_dest  = expected_dest
        self.redirect_ok    = redirect_ok
        self.redirect_status = redirect_status
        self.actual_location = actual_location
        self.dest_status    = dest_status   # 0 = not checked, -1 = connection error
        self.error          = error

    @property
    def dest_ok(self):
        return self.dest_status == 0 or 200 <= self.dest_status < 400


# ---------------------------------------------------------------------------
# Parsing
# ---------------------------------------------------------------------------
def parse_redirect_map(map_file: str) -> list:
    """
    Return [(source, dest), ...] for every non-comment, non-regex line
    whose source starts with '/'.
    """
    pairs = []
    with open(map_file, encoding="utf-8") as fh:
        for line in fh:
            line = line.strip()
            if not line or line.startswith("#") or line.startswith("~"):
                continue
            parts = line.split(None, 1)
            if len(parts) != 2:
                continue
            source = parts[0]
            dest   = parts[1].rstrip(";").strip()
            if source.startswith("/"):
                pairs.append((source, dest))
    return pairs


# ---------------------------------------------------------------------------
# Docker helpers
# ---------------------------------------------------------------------------
def start_container(port: int) -> None:
    """Remove any stale container with the same name, then start a fresh one."""
    subprocess.run(
        ["docker", "rm", "-f", CONTAINER_NAME],
        capture_output=True,
    )
    result = subprocess.run(
        [
            "docker", "run", "-d",
            "--name", CONTAINER_NAME,
            "-p", f"{port}:80",
            "-v", f"{NGINX_CONF}:/etc/nginx/nginx.conf:ro",
            "-v", f"{MAP_FILE}:/etc/nginx/redirects.map:ro",
            NGINX_IMAGE,
        ],
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        raise RuntimeError(
            f"docker run failed:\n{result.stderr.strip()}"
        )


def wait_for_nginx(port: int, timeout: int = 30) -> bool:
    """Poll until nginx responds or timeout (seconds) expires."""
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        try:
            conn = http.client.HTTPConnection("localhost", port, timeout=2)
            conn.request("HEAD", "/health-check-nonexistent")
            conn.getresponse()
            conn.close()
            return True
        except Exception:
            time.sleep(0.4)
    return False


def stop_container() -> None:
    subprocess.run(["docker", "rm", "-f", CONTAINER_NAME], capture_output=True)


# ---------------------------------------------------------------------------
# Testing
# ---------------------------------------------------------------------------
def test_redirect(source: str, expected_dest: str, port: int) -> TestResult:
    """
    HEAD request to localhost:{port}{source} without following redirects.
    Checks: status == 301  AND  Location == expected_dest (query params stripped).
    """
    try:
        conn = http.client.HTTPConnection("localhost", port, timeout=10)
        conn.request("HEAD", source)
        resp = conn.getresponse()
        status   = resp.status
        location = resp.getheader("Location", "")
        conn.close()

        # nginx appends $args_suffix — strip any query string before comparing
        location_base = location.split("?")[0]
        # Map value 0 bypasses the catch-all for pages without a replacement.
        if expected_dest == "0":
            redirect_ok = (status == 404 and not location)
        else:
            redirect_ok = (status == 301 and location_base == expected_dest)

        return TestResult(
            source=source,
            expected_dest=expected_dest,
            redirect_ok=redirect_ok,
            redirect_status=status,
            actual_location=location,
        )
    except Exception as exc:
        return TestResult(
            source=source,
            expected_dest=expected_dest,
            redirect_ok=False,
            redirect_status=0,
            actual_location="",
            error=str(exc),
        )


def check_destination(url: str) -> int:
    """
    HEAD request to *url* (follows redirects).
    Returns final HTTP status, or -1 on connection error.
    """
    try:
        req = urllib.request.Request(url, method="HEAD")
        req.add_header("User-Agent", "SignalWire-redirect-tester/1.0")
        with urllib.request.urlopen(req, timeout=10) as resp:
            return resp.status
    except urllib.error.HTTPError as exc:
        return exc.code
    except Exception:
        return -1


def run_parallel(fn, items, workers: int, label: str) -> list:
    """Execute fn(*item) for each item using a thread pool; return results in
    original order while printing a progress counter."""
    ordered: dict = {}
    with concurrent.futures.ThreadPoolExecutor(max_workers=workers) as ex:
        future_to_idx = {ex.submit(fn, *item): i for i, item in enumerate(items)}
        done = 0
        for future in concurrent.futures.as_completed(future_to_idx):
            ordered[future_to_idx[future]] = future.result()
            done += 1
            print(f"  {label}: {done}/{len(items)}", end="\r", flush=True)
    print()
    return [ordered[i] for i in range(len(items))]


# ---------------------------------------------------------------------------
# Report
# ---------------------------------------------------------------------------
def write_report(
    results: list,
    report_file: str,
    check_dest: bool,
) -> tuple:
    today = datetime.date.today().isoformat()

    redirect_pass = [r for r in results if r.redirect_ok]
    redirect_fail = [r for r in results if not r.redirect_ok]

    dest_checked  = [r for r in results if r.dest_status != 0]
    dest_pass     = [r for r in dest_checked if r.dest_ok]
    dest_fail     = [r for r in dest_checked if not r.dest_ok]

    lines = [
        f"Redirect Test Report - {today}",
        "=" * 54,
        f"Total pairs tested      : {len(results)}",
        f"Redirect / exclusion check    : {len(redirect_pass)} passed, {len(redirect_fail)} failed",
    ]
    if check_dest:
        lines.append(
            f"Destination reachable   : {len(dest_pass)} ok, {len(dest_fail)} unreachable"
        )
    lines.append("")

    # --- Failed redirect checks ---
    if redirect_fail:
        lines.append(f"FAILED REDIRECT CHECKS ({len(redirect_fail)})")
        lines.append("-" * 40)
        for r in redirect_fail:
            lines.append(f"  source  : {r.source}")
            if r.error:
                lines.append(f"  error   : {r.error}")
            else:
                lines.append(f"  status  : {r.redirect_status}  (expected 301)")
                lines.append(f"  expected: {r.expected_dest}")
                lines.append(f"  got     : {r.actual_location}")
            lines.append("")

    # --- Failed destination checks ---
    if check_dest and dest_fail:
        lines.append(f"UNREACHABLE DESTINATIONS ({len(dest_fail)})")
        lines.append("-" * 40)
        # Group by status code for readability
        by_status: dict = {}
        for r in dest_fail:
            by_status.setdefault(r.dest_status, []).append(r.expected_dest)
        for code in sorted(by_status):
            label = "connection error" if code == -1 else f"HTTP {code}"
            lines.append(f"  [{label}]")
            # Deduplicate destinations (multiple sources may share a dest)
            for dest in sorted(set(by_status[code])):
                lines.append(f"    {dest}")
        lines.append("")

    with open(report_file, "w", encoding="utf-8") as fh:
        fh.write("\n".join(lines) + "\n")

    return len(redirect_fail), len(dest_fail) if check_dest else 0


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
def main() -> None:
    parser = argparse.ArgumentParser(
        description="Test nginx redirects using a Docker container"
    )
    parser.add_argument("--port",            type=int, default=8181)
    parser.add_argument("--workers",         type=int, default=20)
    parser.add_argument("--skip-dest-check", action="store_true")
    parser.add_argument("--keep-container",  action="store_true")
    parser.add_argument("--report",          default=DEFAULT_REPORT)
    args = parser.parse_args()

    check_dest = not args.skip_dest_check

    # 1. Parse the map
    print(f"Parsing {MAP_FILE} ...")
    pairs = parse_redirect_map(MAP_FILE)
    print(f"  {len(pairs)} redirect entries")

    # 2. Wait for nginx (container must be started manually)
    print(f"Waiting for nginx on port {args.port} ...")
    if not wait_for_nginx(args.port):
        print(f"ERROR: nginx not reachable on localhost:{args.port}.")
        print("  Start the container manually, e.g.:")
        print(f"  docker run -d --name {CONTAINER_NAME} -p {args.port}:80 \\")
        print(f"    -v {NGINX_CONF}:/etc/nginx/nginx.conf:ro \\")
        print(f"    -v {MAP_FILE}:/etc/nginx/redirects.map:ro \\")
        print(f"    {NGINX_IMAGE}")
        sys.exit(1)
    print("  nginx is ready.")

    # 3. Test redirects
    print(f"Testing {len(pairs)} redirects ({args.workers} workers) ...")
    results = run_parallel(
        lambda s, d: test_redirect(s, d, args.port),
        pairs,
        args.workers,
        "redirect checks",
    )

    # 4. Check destinations (deduplicated)
    if check_dest:
        unique_dests = sorted({r.expected_dest for r in results if r.redirect_ok and r.expected_dest != "0"})
        print(f"Checking {len(unique_dests)} unique destination URLs ...")
        dest_items = [(d,) for d in unique_dests]
        dest_statuses_list = run_parallel(
            lambda d: (d, check_destination(d)),
            dest_items,
            args.workers,
            "destination checks",
        )
        dest_status_map = dict(dest_statuses_list)
        for r in results:
            if r.redirect_ok and r.expected_dest != "0":
                r.dest_status = dest_status_map.get(r.expected_dest, -1)

    # 5. (container cleanup is manual)

    # 6. Report
    print(f"Writing report to {args.report} ...")
    redirect_failures, dest_failures = write_report(results, args.report, check_dest)

    # Summary
    total = len(results)
    print()
    print(f"Results:")
    print(f"  Redirect checks : {total - redirect_failures}/{total} passed")
    if check_dest:
        dest_checked = len([r for r in results if r.dest_status != 0])
        print(f"  Destination checks : {dest_checked - dest_failures}/{dest_checked} ok")
    print(f"  Report : {args.report}")

    if redirect_failures > 0 or dest_failures > 0:
        sys.exit(1)


if __name__ == "__main__":
    main()
