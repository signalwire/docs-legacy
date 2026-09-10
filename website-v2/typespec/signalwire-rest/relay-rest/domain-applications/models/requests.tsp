import "./core.tsp";

using TypeSpec.Http;

@doc("Request body for creating a domain application.")
model CreateDomainApplicationRequest {
  @doc("A string representing the friendly name for this domain application.")
  @example("Test App")
  name: string;

  @doc("A string representing the identifier portion of the domain application.")
  identifier: string;

  @doc("The user portion of the domain application.")
  @example("helpdesk")
  user?: string = "*";

  @doc("Whether the domain application will enforce IP authentication for incoming requests.")
  @example(true)
  ip_auth_enabled?: boolean;

  @doc("A list containing whitelisted IP addresses and IP blocks used if ip_auth_enabled is true.")
  ip_auth?: string[] = #[];

  @doc("Whether connections to this domain application require encryption or if encryption is optional.")
  @example("required")
  encryption?: "optional" | "required" | "forbidden" = "optional";

  @doc("A list of codecs this domain application will support.")
  codecs?: string[] = #["PCMU", "PCMA"];

  @doc("A list of encryption ciphers this domain application will support.")
  ciphers?: string[] = #[
    "AEAD_AES_256_GCM_8",
    "AES_256_CM_HMAC_SHA1_80",
    "AES_CM_128_HMAC_SHA1_80",
    "AES_256_CM_HMAC_SHA1_32",
    "AES_CM_128_HMAC_SHA1_32"
  ];

  @doc("Specify how the domain application will handle calls.")
  call_handler?: DomainAppCallHandlerRequest;

  @doc("A string representing the Relay topic to forward incoming calls to. Required when call_handler is relay_topic.")
  @example("office")
  call_relay_topic?: string;

  @doc("A string representing a URL to send status change messages to.")
  @example("https://myapplication/handle_relay_callbacks")
  call_relay_topic_status_callback_url?: string;

  @doc("A string representing the Relay Application to forward incoming calls to. Required when call_handler is relay_application.")
  @example("my-relay-app")
  call_relay_application?: string;

  @doc("A string representing the LaML URL to access when a call is received. Required when call_handler is laml_webhooks.")
  @example("https://example.com/laml")
  call_request_url?: string;

  @doc("A string representing the HTTP method to use with call_request_url.")
  call_request_method?: "GET" | "POST" = "POST";

  @doc("A string representing the LaML URL to access when the call to call_request_url fails.")
  @example("https://example.com/fallback")
  call_fallback_url?: string;

  @doc("A string representing the HTTP method to use with call_fallback_url.")
  call_fallback_method?: "GET" | "POST" = "POST";

  @doc("A string representing a URL to send status change messages to.")
  @example("https://example.com/status")
  call_status_callback_url?: string;

  @doc("A string representing the HTTP method to use with call_status_callback_url.")
  call_status_callback_method?: "GET" | "POST" = "POST";

  @doc("A string representing the ID of the LaML application to forward incoming calls to. Required when call_handler is laml_application.")
  @example("app-123456")
  call_laml_application_id?: string;

  @doc("A string representing the ID of the Video Room to forward incoming calls to. Required when call_handler is video_room.")
  @example("fe4093d9-58c2-4931-b4b9-5679f82652c6")
  @format("uuid")
  call_video_room_id?: uuid;

  @doc("A string representing the URL of the Relay script to execute when a call is received. Required when call_handler is relay_script.")
  @example("https://example.com/relay-script")
  call_relay_script_url?: string;

  @doc("A string representing the ID of the Dialogflow Agent to forward incoming calls to. Required when call_handler is dialogflow.")
  @example("fe4093d9-58c2-4931-b4b9-5679f82652c6")
  @format("uuid")
  call_dialogflow_agent_id?: uuid;

  @doc("A string representing the ID of the AI Agent to forward incoming calls to. Required when call_handler is ai_agent.")
  @example("fe4093d9-58c2-4931-b4b9-5679f82652c6")
  @format("uuid")
  call_ai_agent_id?: uuid;

  @doc("A string representing the ID of the Call Flow to forward incoming calls to. Required when call_handler is call_flow.")
  @example("fe4093d9-58c2-4931-b4b9-5679f82652c6")
  @format("uuid")
  call_flow_id?: uuid;

  @doc("A string representing the version of your Call Flow you'd like to use.")
  call_flow_version?: "working_copy" | "current_deployed";

  #deprecated "This handler type is deprecated. Please use call_relay_application or call_relay_topic instead."
  @doc("This handler type is deprecated. Please use call_relay_application or call_relay_topic instead.")
  @example("office")
  call_relay_context?: string;

  #deprecated "This property is deprecated. Please use call_relay_topic_status_callback_url instead."
  @doc("This property is deprecated. Please use call_relay_topic_status_callback_url instead.")
  @example("https://myapplication/handle_relay_callbacks")
  call_relay_context_status_callback_url?: string;
}

@doc("Request body for updating a domain application.")
model UpdateDomainApplicationRequest {
  @doc("A string representing the friendly name for this domain application.")
  @example("Test App")
  name?: string;

  @doc("A string representing the identifier portion of the domain application.")
  identifier?: string;

  @doc("A string representing the user portion of the domain application.")
  @example("helpdesk")
  user?: string;

  @doc("Whether the domain application will enforce IP authentication for incoming requests.")
  @example(true)
  ip_auth_enabled?: boolean;

  @doc("A list containing whitelisted IP addresses and IP blocks used if ip_auth_enabled is true.")
  ip_auth?: string[];

  @doc("Whether connections to this domain application require encryption or if encryption is optional.")
  @example("required")
  encryption?: "optional" | "required" | "forbidden";

  @doc("A list of codecs this domain application will support.")
  codecs?: string[];

  @doc("A list of encryption ciphers this domain application will support.")
  ciphers?: string[];

  @doc("Specify how the domain application will handle calls.")
  call_handler?: DomainAppCallHandlerRequest;

  @doc("A string representing the Relay topic to forward incoming calls to.")
  @example("office")
  call_relay_topic?: string;

  @doc("A string representing a URL to send status change messages to.")
  @example("https://myapplication/handle_relay_callbacks")
  call_relay_topic_status_callback_url?: string;

  @doc("A string representing the Relay Application to forward incoming calls to.")
  @example("my-relay-app")
  call_relay_application?: string;

  @doc("A string representing the LaML URL to access when a call is received.")
  @example("https://example.com/laml")
  call_request_url?: string;

  @doc("A string representing the HTTP method to use with call_request_url.")
  call_request_method?: "GET" | "POST";

  @doc("A string representing the LaML URL to access when the call to call_request_url fails.")
  @example("https://example.com/fallback")
  call_fallback_url?: string;

  @doc("A string representing the HTTP method to use with call_fallback_url.")
  call_fallback_method?: "GET" | "POST";

  @doc("A string representing a URL to send status change messages to.")
  @example("https://example.com/status")
  call_status_callback_url?: string;

  @doc("A string representing the HTTP method to use with call_status_callback_url.")
  call_status_callback_method?: "GET" | "POST";

  @doc("A string representing the ID of the LaML application to forward incoming calls to.")
  @example("app-123456")
  call_laml_application_id?: string;

  @doc("A string representing the ID of the Video Room to forward incoming calls to.")
  @example("fe4093d9-58c2-4931-b4b9-5679f82652c6")
  @format("uuid")
  call_video_room_id?: uuid;

  @doc("A string representing the URL of the Relay script to execute when a call is received.")
  @example("https://example.com/relay-script")
  call_relay_script_url?: string;

  @doc("A string representing the ID of the Dialogflow Agent to forward incoming calls to.")
  @example("fe4093d9-58c2-4931-b4b9-5679f82652c6")
  @format("uuid")
  call_dialogflow_agent_id?: uuid;

  @doc("A string representing the ID of the AI Agent to forward incoming calls to.")
  @example("fe4093d9-58c2-4931-b4b9-5679f82652c6")
  @format("uuid")
  call_ai_agent_id?: uuid;

  @doc("A string representing the ID of the Call Flow to forward incoming calls to.")
  @example("fe4093d9-58c2-4931-b4b9-5679f82652c6")
  @format("uuid")
  call_flow_id?: uuid;

  @doc("A string representing the version of your Call Flow you'd like to use.")
  call_flow_version?: "working_copy" | "current_deployed";

  #deprecated "This handler type is deprecated. Please use call_relay_application or call_relay_topic instead."
  @doc("This handler type is deprecated. Please use call_relay_application or call_relay_topic instead.")
  @example("office")
  call_relay_context?: string;

  #deprecated "This property is deprecated. Please use call_relay_topic_status_callback_url instead."
  @doc("This property is deprecated. Please use call_relay_topic_status_callback_url instead.")
  @example("https://myapplication/handle_relay_callbacks")
  call_relay_context_status_callback_url?: string;
}
