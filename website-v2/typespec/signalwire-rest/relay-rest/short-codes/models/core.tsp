import "../../../types";
import "../../phone-numbers/models/core.tsp";

using TypeSpec.Http;
using Types;

model ShortCodePathID {
  @doc("Unique ID of the short code.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

@doc("Short code capabilities.")
enum ShortCodeCapability {
  @doc("SMS messaging capability.")
  sms: "sms",

  @doc("MMS messaging capability.")
  mms: "mms",
}

@doc("Short code type.")
enum ShortCodeType {
  @doc("Vanity short code with a specific number.")
  vanity: "vanity",

  @doc("Randomly assigned short code.")
  random: "random",
}

@doc("Message handler type for short codes.")
enum ShortCodeMessageHandler {
  @doc("Handle messages using a Relay context.")
  relay_context: "relay_context",

  @doc("Handle messages using LāML webhooks.")
  laml_webhooks: "laml_webhooks",

  @doc("Handle messages using a LāML application.")
  laml_application: "laml_application",
}

@doc("Short code model.")
model ShortCode {
  @doc("The unique identifier of the short code.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  id: uuid;

  @doc("The name given to the short code.")
  @example("My Short Code")
  name: string | null;

  @doc("The short code number.")
  @example("12345")
  number: string;

  @doc("The messaging capabilities of the short code.")
  capabilities: ShortCodeCapability[];

  @doc("The type of number (always 'shortcode').")
  @example("shortcode")
  number_type: "shortcode";

  @doc("The type of short code.")
  code_type: ShortCodeType;

  @doc("The ISO 3166-1 alpha-2 country code.")
  @example("US")
  country_code: string;

  @doc("The date and time when the short code was created.")
  @example("2023-01-15T10:30:00Z")
  created_at: string;

  @doc("The date and time when the short code was last updated.")
  @example("2023-01-15T10:30:00Z")
  updated_at: string;

  @doc("The date and time when the short code will next be billed.")
  @example("2024-01-15T10:30:00Z")
  next_billed_at: string | null;

  @doc("The lease duration of the short code (e.g., '12 months').")
  @example("12 months")
  lease_duration: string | null;

  @doc("The message handler type for incoming messages.")
  message_handler: ShortCodeMessageHandler | null;

  @doc("The URL to send message requests to when using laml_webhooks handler.")
  @example("https://example.com/message")
  message_request_url: string | null;

  @doc("The HTTP method to use for message requests.")
  message_request_method: HttpMethod | null;

  @doc("The fallback URL for message requests.")
  @example("https://example.com/fallback")
  message_fallback_url: string | null;

  @doc("The HTTP method to use for fallback requests.")
  message_fallback_method: HttpMethod | null;

  @doc("The ID of the LāML application to handle messages when using laml_application handler.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  message_laml_application_id: uuid | null;

  @doc("The Relay context to use when using relay_context handler.")
  @example("my-context")
  message_relay_context: string | null;
}
