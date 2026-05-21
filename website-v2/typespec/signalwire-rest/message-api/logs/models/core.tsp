import "@typespec/http";
import "../../../types";
import "../../../_globally_shared/const.tsp";

using TypeSpec.Http;

@doc("Unique ID of the log.")
model LogPathID {
  @format("uuid")
  @doc("Unique ID of the log.")
  @path
  id: uuid;
}

@doc("Details on charges associated with this log.")
model ChargeDetail {
  @doc("Description for this charge.")
  @example("Inbound SMS")
  description: string;

  @doc("Charged amount.")
  @example(0.00415)
  charge: float64;
}

@doc("Message log entry with all activity details")
model MessageLog {
  @format("uuid")
  @doc("A unique identifier for the log.")
  id: uuid;

  @doc("The origin phone number.")
  @example("+12077447397")
  from: string;

  @doc("The destination phone number.")
  @example("+12029921413")
  to: string;

  @doc("The status of the message.")
  @example("failed")
  status:
    | "queued"
    | "initiated"
    | "delivered"
    | "sent"
    | "received"
    | "undelivered"
    | "failed";

  @doc("The direction of the message.")
  @example("inbound")
  direction:
    | "inbound"
    | "outbound"
    | "outbound-api"
    | "outbound-call"
    | "outbound-reply";

  @doc("The kind of message.")
  @example("sms")
  kind: "sms" | "mms";

  @doc("Source of this log entry.")
  @example("laml")
  source: "realtime_api" | "laml";

  @doc("Type of this log entry.")
  @example("relay_message")
  type: "relay_message" | "laml_message";

  @doc("URL for the resource associated with this log entry. Null for Relay messages.")
  @example("https://example.signalwire.com/api/laml/2010-04-01/Accounts/c38dacad-2f6c-4de1-93d6-cc732e0c70c5/Messages/9ee38635-899a-490a-bfd1-9e72f5eea53c")
  url: url | null;

  @doc("The number of segments.")
  @example(1)
  number_of_segments: int32;

  @doc("The charge in dollars.")
  @example(0)
  charge: float64;

  @doc("Details on charges associated with this log.")
  charge_details: ChargeDetail[];

  @doc("Date and time when the message entry was created.")
  @example(UTC_TIME_EXAMPLE)
  created_at: utcDateTime;
}
