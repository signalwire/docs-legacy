import "../../../types";

using TypeSpec.Http;
using Types;

model SipEndpointPathID {
  @doc("Unique ID of the SIP endpoint.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

@doc("Call handler type for SIP endpoints.")
enum SipEndpointCallHandler {
  relay_context: "relay_context",
  relay_topic: "relay_topic",
  relay_application: "relay_application",
  relay_connector: "relay_connector",
  relay_script: "relay_script",
  laml_webhooks: "laml_webhooks",
  laml_application: "laml_application",
  dialogflow: "dialogflow",
  video_room: "video_room",
  call_flow: "call_flow",
  ai_agent: "ai_agent",
}

@doc("SIP endpoint model.")
model SipEndpoint {
  @doc("A string representation of the type of object this record is.")
  @example("sip_endpoint")
  type: string;

  @doc("The unique identifier of the SIP endpoint.")
  @example("67075301-69b2-4fc3-8a2c-c95a69a5665e")
  @format("uuid")
  id: uuid;

  @doc("The username for the SIP endpoint.")
  @example("c3p0")
  username: string;

  @doc("Friendly Caller ID used as the CNAM when dialing a phone number or the From when dialing another SIP Endpoint.")
  @example("C-3P0")
  caller_id: string | null;

  @doc("When dialing a PSTN phone number, you must send it From a number you have purchased or verified. send_as indicates which number this endpoint has set as its origination. random indicates it will randomly choose a purchased or verified number from within the project.")
  @example("random")
  send_as: string;

  @doc("A list of encryption ciphers this endpoint will support.")
  ciphers: string[];

  @doc("A list of codecs this endpoint will support.")
  codecs: string[];

  @doc("Whether connections to this endpoint require encryption or if encryption is optional.")
  @example("required")
  encryption: "default" | "required" | "optional";

  @doc("What type of handler you want to run on inbound calls.")
  @example(SipEndpointCallHandler.ai_agent)
  call_handler: SipEndpointCallHandler | null;

  @doc("The unique identifier of the calling handler resource.")
  @example("fe4093d9-58c2-4931-b4b9-5679f82652c6")
  @format("uuid")
  calling_handler_resource_id: uuid | null;

  @doc("A string representing the LaML URL to access when a call is received. This is only used (and required) when call_handler is set to laml_webhooks.")
  call_request_url: string | null;

  @doc("A string representing the HTTP method to use with call_request_url. Valid values are GET and POST.")
  @example("POST")
  call_request_method: "GET" | "POST" | null;

  @doc("A string representing the LaML URL to access when the call to call_request_url fails. This is only used (and required) when call_handler is set to laml_webhooks.")
  call_fallback_url: string | null;

  @doc("A string representing the HTTP method to use with call_fallback_url. Valid values are GET and POST.")
  @example("POST")
  call_fallback_method: "GET" | "POST" | null;

  @doc("A string representing a URL to send status change messages to. This is only used (and required) when call_handler is set to laml_webhooks.")
  call_status_callback_url: string | null;

  @doc("A string representing the HTTP method to use with call_status_callback_url. Valid values are GET and POST.")
  @example("POST")
  call_status_callback_method: "GET" | "POST" | null;

  @doc("A string representing the ID of the LaML application to forward incoming calls to. This is only used (and required) when call_handler is set to laml_application.")
  call_laml_application_id: string | null;

  @doc("A string representing the ID of the Dialogflow agent to forward incoming calls to. This is only used (and required) when call_handler is set to dialogflow.")
  call_dialogflow_agent_id: string | null;

  @doc("A string representing the Relay topic to forward incoming calls to. This is only used (and required) when call_handler is set to relay_topic.")
  @example("office")
  call_relay_topic: string | null;

  @doc("A string representing a URL to send status change messages to. This is only used (and required) when call_handler is set to relay_topic.")
  @example("https://myapplication/handle_relay_callbacks")
  call_relay_topic_status_callback_url: string | null;

  @doc("A string representing the Relay context to forward incoming calls to. This is only used (and required) when call_handler is set to relay_context.")
  call_relay_context: string | null;

  @doc("A string representing a URL to send status change messages to. This is only used (and required) when call_handler is set to relay_context.")
  @example("https://myapplication/handle_relay_callbacks")
  call_relay_context_status_callback_url: string | null;

  @doc("A string representing the Relay application to forward incoming calls to. This is only used (and required) when call_handler is set to relay_application.")
  call_relay_application: string | null;

  @doc("A string representing the ID of the Video Room to forward incoming calls to. This is only used (and required) when call_handler is set to video_room.")
  @format("uuid")
  call_video_room_id: uuid | null;

  @doc("A string representing a URL of a SWML script to respond to incoming calls. This is only used (and required) when call_handler is set to relay_script.")
  @example("https://dev.signalwire.com/relay-bins/f9d13f68-f71e-4042-95bb-b07b9e2f2f92")
  call_relay_script_url: string | null;
}
