import "./core.tsp";

using TypeSpec.Http;

@doc("Request body for creating a SIP endpoint.")
model CreateSipEndpointRequest {
  @doc("String representing the username portion of the endpoint. Must be unique across your project and must not contain white space characters or @.")
  @example("c3p0")
  username: string;

  @doc("A password to authenticate registrations to this endpoint.")
  @example("yavinOrBust")
  password: string;

  @doc("Friendly Caller ID used as the CNAM when dialing a phone number or the From when dialing another SIP Endpoint.")
  @example("C-3P0")
  caller_id?: string;

  @doc("When dialing a PSTN phone number, you must send it From a number you have purchased or verified. send_as indicates which number this endpoint has set as its origination. random indicates it will randomly choose a purchased or verified number from within the project.")
  @example("random")
  send_as?: string;

  @doc("A list of encryption ciphers this endpoint will support.")
  ciphers?: string[];

  @doc("A list of codecs this endpoint will support.")
  codecs?: string[];

  @doc("Specifies the encryption requirements for connections to this endpoint.")
  @example("required")
  encryption?: "default" | "required" | "optional";

  @doc("What type of handler you want to run on inbound calls.")
  @example("ai_agent")
  call_handler?:
    | "relay_context"
    | "relay_topic"
    | "relay_application"
    | "relay_connector"
    | "relay_script"
    | "laml_webhooks"
    | "laml_application"
    | "dialogflow"
    | "video_room"
    | "call_flow"
    | "ai_agent";

  @doc("The LaML URL to access when a call is received. Required when call_handler is laml_webhooks.")
  call_request_url?: string;

  @doc("The HTTP method to use with call_request_url.")
  @example("POST")
  call_request_method?: "GET" | "POST";

  @doc("The LaML URL to access when the call to call_request_url fails. Required when call_handler is laml_webhooks.")
  call_fallback_url?: string;

  @doc("The HTTP method to use with call_fallback_url.")
  @example("POST")
  call_fallback_method?: "GET" | "POST";

  @doc("A URL to send status change messages to. Required when call_handler is laml_webhooks.")
  call_status_callback_url?: string;

  @doc("The HTTP method to use with call_status_callback_url.")
  @example("POST")
  call_status_callback_method?: "GET" | "POST";

  @doc("The ID of the LaML application to forward incoming calls to. Required when call_handler is laml_application.")
  call_laml_application_id?: string;

  @doc("The ID of the Dialogflow agent to forward incoming calls to. Required when call_handler is dialogflow.")
  call_dialogflow_agent_id?: string;

  @doc("The Relay topic to forward incoming calls to. Required when call_handler is relay_topic.")
  @example("office")
  call_relay_topic?: string;

  @doc("A URL to send status change messages to. Required when call_handler is relay_topic.")
  @example("https://myapplication/handle_relay_callbacks")
  call_relay_topic_status_callback_url?: string;

  @doc("The Relay context to forward incoming calls to. Required when call_handler is relay_context.")
  @example("office")
  call_relay_context?: string;

  @doc("A URL to send status change messages to. Required when call_handler is relay_context.")
  @example("https://myapplication/handle_relay_callbacks")
  call_relay_context_status_callback_url?: string;

  @doc("The Relay application to forward incoming calls to. Required when call_handler is relay_application.")
  @example("my-relay-app")
  call_relay_application?: string;

  @doc("The ID of the Video Room to forward incoming calls to. Required when call_handler is video_room.")
  @format("uuid")
  call_video_room_id?: string;

  @doc("The ID of the Call Flow to forward incoming calls to. Required when call_handler is call_flow.")
  @format("uuid")
  call_flow_id?: string;

  @doc("The version of the Call Flow to use. Valid values are 'working_copy' or 'current_deployed'.")
  call_flow_version?: string;

  @doc("The ID of the AI Agent to forward incoming calls to. Required when call_handler is ai_agent.")
  @format("uuid")
  call_ai_agent_id?: string;

  @doc("A URL of a SWML script to respond to incoming calls. Required when call_handler is relay_script.")
  @example("https://dev.signalwire.com/relay-bins/f9d13f68-f71e-4042-95bb-b07b9e2f2f92")
  call_relay_script_url?: string;
}

@doc("Request body for updating a SIP endpoint.")
model UpdateSipEndpointRequest {
  @doc("String representing the username portion of the endpoint. Must be unique across your project and must not contain white space characters or @.")
  @example("c3p0")
  username?: string;

  @doc("A password to authenticate registrations to this endpoint.")
  @example("yavinOrBust")
  password?: string;

  @doc("Friendly Caller ID used as the CNAM when dialing a phone number or the From when dialing another SIP Endpoint.")
  @example("C-3P0")
  caller_id?: string;

  @doc("When dialing a PSTN phone number, you must send it From a number you have purchased or verified. send_as indicates which number this endpoint has set as its origination. random indicates it will randomly choose a purchased or verified number from within the project.")
  @example("random")
  send_as?: string;

  @doc("A list of encryption ciphers this endpoint will support.")
  ciphers?: string[];

  @doc("A list of codecs this endpoint will support.")
  codecs?: string[];

  @doc("Specifies the encryption requirements for connections to this endpoint.")
  @example("required")
  encryption?: "default" | "required" | "optional";

  @doc("What type of handler you want to run on inbound calls.")
  @example("ai_agent")
  call_handler?:
    | "relay_context"
    | "relay_topic"
    | "relay_application"
    | "relay_connector"
    | "relay_script"
    | "laml_webhooks"
    | "laml_application"
    | "dialogflow"
    | "video_room"
    | "call_flow"
    | "ai_agent";

  @doc("The LaML URL to access when a call is received. Required when call_handler is laml_webhooks.")
  call_request_url?: string;

  @doc("The HTTP method to use with call_request_url.")
  @example("POST")
  call_request_method?: "GET" | "POST";

  @doc("The LaML URL to access when the call to call_request_url fails. Required when call_handler is laml_webhooks.")
  call_fallback_url?: string;

  @doc("The HTTP method to use with call_fallback_url.")
  @example("POST")
  call_fallback_method?: "GET" | "POST";

  @doc("A URL to send status change messages to. Required when call_handler is laml_webhooks.")
  call_status_callback_url?: string;

  @doc("The HTTP method to use with call_status_callback_url.")
  @example("POST")
  call_status_callback_method?: "GET" | "POST";

  @doc("The ID of the LaML application to forward incoming calls to. Required when call_handler is laml_application.")
  call_laml_application_id?: string;

  @doc("The ID of the Dialogflow agent to forward incoming calls to. Required when call_handler is dialogflow.")
  call_dialogflow_agent_id?: string;

  @doc("The Relay topic to forward incoming calls to. Required when call_handler is relay_topic.")
  @example("office")
  call_relay_topic?: string;

  @doc("A URL to send status change messages to. Required when call_handler is relay_topic.")
  @example("https://myapplication/handle_relay_callbacks")
  call_relay_topic_status_callback_url?: string;

  @doc("The Relay context to forward incoming calls to. Required when call_handler is relay_context.")
  @example("office")
  call_relay_context?: string;

  @doc("A URL to send status change messages to. Required when call_handler is relay_context.")
  @example("https://myapplication/handle_relay_callbacks")
  call_relay_context_status_callback_url?: string;

  @doc("The Relay application to forward incoming calls to. Required when call_handler is relay_application.")
  @example("my-relay-app")
  call_relay_application?: string;

  @doc("The ID of the Video Room to forward incoming calls to. Required when call_handler is video_room.")
  @format("uuid")
  call_video_room_id?: string;

  @doc("The ID of the Call Flow to forward incoming calls to. Required when call_handler is call_flow.")
  @format("uuid")
  call_flow_id?: string;

  @doc("The version of the Call Flow to use. Valid values are 'working_copy' or 'current_deployed'.")
  call_flow_version?: string;

  @doc("The ID of the AI Agent to forward incoming calls to. Required when call_handler is ai_agent.")
  @format("uuid")
  call_ai_agent_id?: string;

  @doc("A URL of a SWML script to respond to incoming calls. Required when call_handler is relay_script.")
  @example("https://dev.signalwire.com/relay-bins/f9d13f68-f71e-4042-95bb-b07b9e2f2f92")
  call_relay_script_url?: string;
}
