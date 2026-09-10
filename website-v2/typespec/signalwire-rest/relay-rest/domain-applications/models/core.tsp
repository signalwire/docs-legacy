import "../../../types";

using TypeSpec.Http;
using Types;

model DomainApplicationPathID {
  @doc("Unique ID of the domain application.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

@doc("Call handler types that can be assigned via the API.")
enum DomainAppCallHandlerRequest {
  relay_topic: "relay_topic",
  relay_application: "relay_application",
  laml_webhooks: "laml_webhooks",
  laml_application: "laml_application",
  video_room: "video_room",
  relay_script: "relay_script",
  dialogflow: "dialogflow",
  ai_agent: "ai_agent",
  call_flow: "call_flow",
  relay_context: "relay_context",
}

@doc("All possible call handler types for domain applications. Includes types that can only be assigned via the Fabric API or UI.")
enum DomainAppCallHandler {
  relay_topic: "relay_topic",
  relay_application: "relay_application",
  laml_webhooks: "laml_webhooks",
  laml_application: "laml_application",
  video_room: "video_room",
  relay_script: "relay_script",
  dialogflow: "dialogflow",
  ai_agent: "ai_agent",
  call_flow: "call_flow",
  relay_context: "relay_context",
  relay_connector: "relay_connector",
  fabric_subscriber: "fabric_subscriber",
  sip_gateway: "sip_gateway",
  call_queue: "call_queue",
}

@doc("Domain application model.")
model DomainApplication {
  @doc("The unique identifier of the domain application on SignalWire.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  id: uuid;

  @doc("A string representation of the type of object this record is.")
  @example("domain_application")
  type: string;

  @doc("The unique domain for this application, combining your space subdomain and identifier.")
  @example("your-space-test_id")
  domain: string;

  @doc("A string representing the friendly name for this domain application.")
  @example("Test App")
  name: string | null;

  @doc("A string representing the identifier portion of the domain application.")
  identifier: string;

  @doc("A string representing the user portion of the domain application.")
  @example("helpdesk")
  user: string;

  @doc("Whether the domain application will enforce IP authentication for incoming requests.")
  @example(true)
  ip_auth_enabled: boolean;

  @doc("A list containing whitelisted IP addresses and IP blocks used if ip_auth_enabled is true.")
  ip_auth: string[];

  @doc("Specify how the domain application will handle calls.")
  call_handler: DomainAppCallHandler | null;

  @doc("The unique identifier of the calling handler resource.")
  @example("fe4093d9-58c2-4931-b4b9-5679f82652c6")
  @format("uuid")
  calling_handler_resource_id: uuid | null;

  @doc("A string representing the Relay topic to forward incoming calls to.")
  @example("office")
  call_relay_topic: string | null;

  @doc("A string representing a URL to send status change messages to.")
  @example("https://myapplication/handle_relay_callbacks")
  call_relay_topic_status_callback_url: string | null;

  #deprecated "Use call_relay_application instead."
  @doc("Deprecated. Use call_relay_application instead.")
  @example("office")
  call_relay_context: string | null;

  #deprecated "Use call_relay_topic_status_callback_url instead."
  @doc("Deprecated. Use call_relay_topic_status_callback_url instead.")
  call_relay_context_status_callback_url: string | null;

  @doc("A string representing the LaML URL to access when a call is received.")
  @example("https://example.com/laml")
  call_request_url: string | null;

  @doc("A string representing the HTTP method to use with call_request_url.")
  call_request_method: "GET" | "POST" | null;

  @doc("A string representing the LaML URL to access when the call to call_request_url fails.")
  @example("https://example.com/fallback")
  call_fallback_url: string | null;

  @doc("A string representing the HTTP method to use with call_fallback_url.")
  call_fallback_method: "GET" | "POST" | null;

  @doc("A string representing a URL to send status change messages to.")
  @example("https://example.com/status")
  call_status_callback_url: string | null;

  @doc("A string representing the HTTP method to use with call_status_callback_url.")
  call_status_callback_method: "GET" | "POST" | null;

  @doc("A string representing the ID of the LaML application to forward incoming calls to.")
  @example("app-123456")
  call_laml_application_id: string | null;

  @doc("A string representing the ID of the Video Room to forward incoming calls to.")
  @example("fe4093d9-58c2-4931-b4b9-5679f82652c6")
  @format("uuid")
  call_video_room_id: uuid | null;

  @doc("A string representing the URL of the Relay script to execute when a call is received.")
  @example("https://example.com/relay-script")
  call_relay_script_url: string | null;

  @doc("A string representing whether connections to this domain application require encryption or if encryption is optional. Valid values are optional, required, and forbidden.")
  @example("required")
  encryption: "optional" | "required" | "forbidden";

  @doc("A list of codecs this domain application will support. Currently supported values are: OPUS, G722, PCMU, PCMA, G729, VP8, and H264.")
  codecs: string[];

  @doc("A list of encryption ciphers this domain application will support. Currently supported values are: AEAD_AES_256_GCM_8, AES_256_CM_HMAC_SHA1_80, AES_CM_128_HMAC_SHA1_80, AES_256_CM_HMAC_SHA1_32, and AES_CM_128_HMAC_SHA1_32.")
  ciphers: string[];
}
