import "../../../types";
import "../../const.tsp";

using TypeSpec.Http;

model LogPathID {
  @doc("Unique ID of the log")
  @format("uuid")
  @path
  @example("b7182dc2-00f3-40e4-a5ce-20f164b329df")
  id: uuid;
}

model ChargeDetail {
  @doc("Description for this charge.")
  @example("Outbound Fax Minutes")
  description: string;

  @doc("Charged amount.")
  @example(0.01)
  charge: float64;
}

model FaxLog {
  @doc("A unique identifier for the log")
  @format("uuid")
  @example("b7182dc2-00f3-40e4-a5ce-20f164b329df")
  id: uuid;

  @doc("The origin phone number in E.164 format.")
  @example("+12065551212")
  from: string | null;

  @doc("The destination phone number in E.164 format.")
  @example("+12065553434")
  to: string | null;

  @doc("The status of this fax call.")
  @example("completed")
  status:
    | "queued"
    | "initiated"
    | "ringing"
    | "in-progress"
    | "busy"
    | "failed"
    | "no-answer"
    | "canceled"
    | "completed";

  @doc("The direction of this fax call.")
  @example("inbound")
  direction: "inbound" | "outbound-api" | "outbound-dial" | null;

  @doc("Source of this log entry.")
  @example("laml")
  source: "laml";

  @doc("Type of this log entry.")
  @example("laml_call")
  type: "laml_call";

  @doc("URL for the associated fax resource with this log entry.")
  @example("https://example.signalwire.com/api/laml/2010-04-01/Accounts/b7182dc2-00f3-40e4-a5ce-20f164b329df/Faxes/c9a1d3e4-56f7-89ab-cdef-0123456789ab")
  url: url;

  @doc("Represents a customer hosted Fax server.")
  @example(null)
  remote_station: string | null;

  @doc("The amount charged for this fax request.")
  @example(0.01)
  charge: float64;

  @doc("The number of pages the fax document contained.")
  @example(2)
  number_of_pages: int32 | null;

  @doc("The quality that was set when the fax document was sent.")
  @example("fine")
  quality: "fine" | "standard" | "superfine" | null;

  @doc("Details on charges associated with this log.")
  @example(#[])
  charge_details: ChargeDetail[];

  @doc("Date and time when the fax was created.")
  @example(UTC_TIME_EXAMPLE)
  created_at: utcDateTime;

  @doc("Error code for this resource (if available).")
  @example("34004")
  error_code: string | null;

  @doc("The description of this error (if available).")
  @example("The call dropped prematurely")
  error_message: string | null;
}
