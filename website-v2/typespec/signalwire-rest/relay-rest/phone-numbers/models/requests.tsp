import "./core.tsp";

using TypeSpec.Http;

@doc("Request body for purchasing a phone number.")
model PurchasePhoneNumberRequest {
  @doc("The phone number in E164 format.")
  @example("+15558675309")
  number: string;
}

@doc("Request body for updating a phone number.")
model UpdatePhoneNumberRequest {
  @doc("The friendly name for the phone number.")
  @example("Main Office Line")
  name?: string;

  @doc("The call handler for the phone number.")
  call_handler?: PhoneNumberCallHandlerRequest;

  @doc("The call receive mode for the phone number.")
  call_receive_mode?: string;

  @doc("The call request URL for the phone number.")
  call_request_url?: string;

  @doc("The call request method for the phone number.")
  call_request_method?: "GET" | "POST";

  @doc("The call fallback URL for the phone number.")
  call_fallback_url?: string;

  @doc("The call fallback method for the phone number.")
  call_fallback_method?: "GET" | "POST";

  @doc("The call status callback URL for the phone number.")
  call_status_callback_url?: string;

  @doc("The call status callback method for the phone number.")
  call_status_callback_method?: "GET" | "POST";

  @doc("The ID of the LaML Application to use when using the laml_application call handler.")
  call_laml_application_id?: string;

  @doc("The ID of the Dialogflow Agent to start when using the dialogflow call handler.")
  call_dialogflow_agent_id?: string;

  @doc("A string representing the Relay topic to forward incoming calls to.")
  @example("office")
  call_relay_topic?: string;

  @doc("A string representing a URL to send status change messages to when call_handler is set to relay_topic.")
  @example("https://myapplication/handle_relay_callbacks")
  call_relay_topic_status_callback_url?: string;

  @doc("The URL to make a request to when using the relay_script call handler.")
  @example("https://example.signalwire.com/relay-bins/60e2ba7b-366e-44de-84e3-0c76cfccf1cc")
  call_relay_script_url?: string;

  #deprecated "This handler type is deprecated. Please use call_relay_application or call_relay_topic instead."
  @doc("This handler type is deprecated. Please use call_relay_application or call_relay_topic instead.")
  @example("my_relay_app")
  call_relay_context?: string;

  #deprecated "This property is deprecated. Please use call_relay_topic_status_callback_url instead."
  @doc("This property is deprecated. Please use call_relay_topic_status_callback_url instead.")
  @example("https://myapplication/handle_relay_callbacks")
  call_relay_context_status_callback_url?: string;

  @doc("A string representing the Relay Application to forward incoming calls to.")
  @example("my-relay-app")
  call_relay_application?: string;

  @doc("The ID of the Relay Connector to use when using the relay_connector call handler.")
  call_relay_connector_id?: string;

  @doc("The ID of the SIP Endpoint to use when using the relay_sip_endpoint call handler.")
  call_sip_endpoint_id?: string;

  @doc("The Verto resource to use when using the relay_verto_endpoint call handler.")
  call_verto_resource?: string;

  @doc("The ID of the Video Room to forward incoming calls to when using the video_room call handler.")
  @format("uuid")
  call_video_room_id?: uuid;

  @doc("The message handler for the phone number.")
  message_handler?: PhoneNumberMessageHandler;

  @doc("The message request URL for the phone number.")
  message_request_url?: string;

  @doc("The message request method for the phone number.")
  message_request_method?: "GET" | "POST";

  @doc("The message fallback URL for the phone number.")
  message_fallback_url?: string;

  @doc("The message fallback method for the phone number.")
  message_fallback_method?: "GET" | "POST";

  @doc("The ID of the LaML Application to use for messages.")
  message_laml_application_id?: string;

  @doc("A string representing the Relay topic to forward incoming messages to.")
  message_relay_topic?: string;

  #deprecated "This handler type is deprecated. Please use message_relay_application or message_relay_topic instead."
  @doc("This handler type is deprecated. Please use message_relay_application or message_relay_topic instead.")
  message_relay_context?: string;

  @doc("A string representing the Relay Application to forward incoming messages to.")
  message_relay_application?: string;
}

@doc("Request body for importing a phone number.")
model ImportPhoneNumberRequest {
  @doc("The phone number to import in E.164 format. Number must be between 5 and 30 characters with no special characters besides a leading +.")
  @example("+49152234333323")
  @minLength(5)
  @maxLength(30)
  number: string;

  @doc("The type of phone number being imported.")
  @example("longcode")
  number_type: "longcode" | "tollfree";

  @doc("The capabilities to enable for this phone number. Can include any combination of SMS, Voice, Fax, and MMS. If not provided, defaults to all capabilities.")
  @example(#["sms", "fax"])
  capabilities?: ("sms" | "voice" | "fax" | "mms")[];
}
