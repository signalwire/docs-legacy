import "../../../types";

using TypeSpec.Http;
using Types;

@doc("HTTP method type.")
enum HttpMethod {
  GET: "GET",
  POST: "POST",
}

@doc("Call receive mode.")
enum CallReceiveMode {
  voice: "voice",
  fax: "fax",
}

@doc("Phone number type.")
enum PhoneNumberType {
  tollfree: "toll-free",
  longcode: "longcode",
}

@doc("Phone number capability.")
enum PhoneNumberCapability {
  voice: "voice",
  sms: "sms",
  mms: "mms",
  fax: "fax",
}

@doc("Call handler type for phone numbers.")
enum PhoneNumberCallHandler {
  relay_context: "relay_context",
  relay_topic: "relay_topic",
  relay_script: "relay_script",
  relay_application: "relay_application",
  relay_connector: "relay_connector",
  relay_sip_endpoint: "relay_sip_endpoint",
  relay_verto_endpoint: "relay_verto_endpoint",
  laml_webhooks: "laml_webhooks",
  laml_application: "laml_application",
  dialogflow: "dialogflow",
  video_room: "video_room",
  call_flow: "call_flow",
  ai_agent: "ai_agent",
  fabric_subscriber: "fabric_subscriber",
  sip_gateway: "sip_gateway",
  call_queue: "call_queue",
}

@doc("Message handler type for phone numbers.")
enum PhoneNumberMessageHandler {
  relay_context: "relay_context",
  relay_topic: "relay_topic",
  relay_application: "relay_application",
  laml_webhooks: "laml_webhooks",
  laml_application: "laml_application",
}

@doc("Call handler type for phone number update requests. Excludes handlers that can only be set via Fabric API.")
enum PhoneNumberCallHandlerRequest {
  relay_context: "relay_context",
  relay_topic: "relay_topic",
  relay_script: "relay_script",
  relay_application: "relay_application",
  relay_connector: "relay_connector",
  relay_sip_endpoint: "relay_sip_endpoint",
  relay_verto_endpoint: "relay_verto_endpoint",
  laml_webhooks: "laml_webhooks",
  laml_application: "laml_application",
  dialogflow: "dialogflow",
  video_room: "video_room",
}

model PhoneNumberPathID {
  @doc("Unique ID of the phone number.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

model E164NumberPath {
  @doc("The phone number in E.164 format.")
  @example("+15551234567")
  @path
  e164_number: string;
}

@doc("Phone number model.")
model PhoneNumber {
  @doc("The unique identifier of the phone number.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  id: uuid;

  @doc("The phone number in E.164 format.")
  @example("+15558675309")
  number: string;

  @doc("The name given to the phone number. Helps to distinguish different phone numbers within your project.")
  @example("Jenny")
  name: string | null;

  @doc("A list of communication methods this phone number supports.")
  capabilities: PhoneNumberCapability[];

  @doc("The type of number this is defined as.")
  @example(PhoneNumberType.tollfree)
  number_type: PhoneNumberType;

  @doc("The E911 address ID associated with this phone number.")
  @format("uuid")
  e911_address_id: uuid | null;

  @doc("The date the number was added to your project.")
  created_at: utcDateTime;

  @doc("The date the number was last updated.")
  updated_at: utcDateTime;

  @doc("The next date the number will be billed for.")
  next_billed_at: utcDateTime | null;

  @doc("What type of handler you want to run on inbound calls.")
  @example(PhoneNumberCallHandler.relay_context)
  call_handler: PhoneNumberCallHandler | null;

  @doc("The unique identifier of the calling handler resource.")
  @example("fe4093d9-58c2-4931-b4b9-5679f82652c6")
  @format("uuid")
  calling_handler_resource_id: uuid | null;

  @doc("How do you want to receive the incoming call.")
  @example(CallReceiveMode.voice)
  call_receive_mode: CallReceiveMode;

  @doc("The URL to make a request to when using the laml_webhooks call handler.")
  call_request_url: string | null;

  @doc("The HTTP method to use when making a request to the call_request_url.")
  @example(HttpMethod.POST)
  call_request_method: HttpMethod | null;

  @doc("The fallback URL to make a request to when using the laml_webhooks call handler and the call_request_url fails.")
  call_fallback_url: string | null;

  @doc("The HTTP method to use when making a request to the call_fallback_url.")
  @example(HttpMethod.POST)
  call_fallback_method: HttpMethod | null;

  @doc("The URL to make status callbacks to when using the laml_webhooks call handler.")
  call_status_callback_url: string | null;

  @doc("The HTTP method to use when making a request to the call_status_callback_url.")
  @example(HttpMethod.POST)
  call_status_callback_method: HttpMethod | null;

  @doc("The ID of the LaML Application to use when using the laml_application call handler.")
  call_laml_application_id: string | null;

  @doc("The ID of the Dialogflow Agent to start when using the dialogflow call handler.")
  call_dialogflow_agent_id: string | null;

  @doc("A string representing the Relay topic to forward incoming calls to. This is only used (and required) when call_handler is set to relay_topic.")
  @example("office")
  call_relay_topic: string | null;

  @doc("A string representing a URL to send status change messages to. This is only used (and required) when call_handler is set to relay_topic.")
  @example("https://myapplication/handle_relay_callbacks")
  call_relay_topic_status_callback_url: string | null;

  @doc("The URL to make a request to when using the relay_script call handler. The URL must respond with a valid SWML script.")
  @example("https://example.signalwire.com/relay-bins/60e2ba7b-366e-44de-84e3-0c76cfccf1cc")
  call_relay_script_url: string | null;

  @doc("The name of the Relay Context to send this call to when using the relay_context call handler.")
  @example("my_relay_app")
  call_relay_context: string | null;

  @doc("A string representing a URL to send status change messages to. This is only used (and required) when call_handler is set to relay_context.")
  @example("https://myapplication/handle_relay_callbacks")
  call_relay_context_status_callback_url: string | null;

  @doc("The name of the Relay Application to send this call to when using the relay_application call handler.")
  @example("my_relay_app")
  call_relay_application: string | null;

  @doc("The ID of the Relay Connector to send this call to when using the relay_connector call handler.")
  call_relay_connector_id: string | null;

  @doc("The ID of the Relay SIP Endpoint to send this call to when using the relay_sip_endpoint call handler.")
  @format("uuid")
  call_sip_endpoint_id: uuid | null;

  @doc("The name of the Verto Relay Endpoint to send this call to when using the relay_verto_endpoint call handler.")
  call_verto_resource: string | null;

  @doc("The ID of the Video Room to send this call to when using the video_room call handler.")
  @example("fe4093d9-58c2-4931-b4b9-5679f82652c6")
  @format("uuid")
  call_video_room_id: uuid | null;

  @doc("What type of handler you want to run on inbound messages.")
  @example(PhoneNumberMessageHandler.relay_application)
  message_handler: PhoneNumberMessageHandler | null;

  @doc("The unique identifier of the messaging handler resource.")
  @example("fe4093d9-58c2-4931-b4b9-5679f82652c6")
  @format("uuid")
  messaging_handler_resource_id: uuid | null;

  @doc("The URL to make a request to when using the laml_webhooks message handler.")
  message_request_url: string | null;

  @doc("The HTTP method to use when making a request to the message_request_url.")
  @example(HttpMethod.POST)
  message_request_method: HttpMethod | null;

  @doc("The fallback URL to make a request to when using the laml_webhooks message handler and the message_request_url fails.")
  message_fallback_url: string | null;

  @doc("The HTTP method to use when making a request to the message_fallback_url.")
  @example(HttpMethod.POST)
  message_fallback_method: HttpMethod | null;

  @doc("The ID of the LaML Application to use when using the laml_application message handler.")
  message_laml_application_id: string | null;

  @doc("The name of the Relay Topic to send this message to when using the relay_topic message handler.")
  message_relay_topic: string | null;

  @doc("The name of the Relay Context to send this message to when using the relay_context message handler.")
  @example("my_relay_app")
  message_relay_context: string | null;

  @doc("The ISO 3166-1 alpha-2 country code of the phone number.")
  @example("US")
  country_code: string | null;
}

@doc("Phone number capabilities.")
model PhoneNumberCapabilities {
  @doc("Whether the phone number can receive voice calls.")
  voice?: boolean;

  @doc("Whether the phone number can send/receive SMS.")
  sms?: boolean;

  @doc("Whether the phone number can send/receive MMS.")
  mms?: boolean;

  @doc("Whether the phone number can send/receive fax.")
  fax?: boolean;
}

@doc("Available phone number for purchase.")
model AvailablePhoneNumber {
  @doc("The phone number in E.164 format.")
  @example("+15551234567")
  number: string;

  @doc("The region of the phone number.")
  @example("CA")
  region?: string;

  @doc("The city of the phone number.")
  @example("Los Angeles")
  city?: string;

  @doc("The rate center of the phone number.")
  rate_center?: string;

  @doc("The LATA of the phone number.")
  lata?: string;

  @doc("The capabilities of the phone number.")
  capabilities?: PhoneNumberCapabilities;
}

@doc("Phone number lookup result.")
model PhoneNumberLookup {
  @doc("The Country code associated with the number.")
  @example(1)
  country_code_number?: int32;

  @doc("Number in the countries national format.")
  @example("5551234567")
  national_number?: string;

  @doc("Whether the number supplied is a possible number.")
  @example(true)
  possible_number?: boolean;

  @doc("Whether the number supplied is a valid number.")
  @example(true)
  valid_number?: boolean;

  @doc("The E164 number formatted in national format.")
  @example("(555) 123-4567")
  national_number_formatted?: string;

  @doc("The E164 number formatted in international format.")
  @example("+1 555-123-4567")
  international_number_formatted?: string;

  @doc("The number in E164 format.")
  @example("+15551234567")
  e164?: string;

  @doc("The location of the number based on its area code and NPA.")
  @example("Texas")
  location?: string;

  @doc("The ISO3166 alpha 2 country code associated with the number.")
  @example("US")
  country_code?: string;

  @doc("The time zones associated with the number.")
  timezones?: string[];

  @doc("The type of number based on its area code and NPA.")
  @example("Fixed Line or Mobile")
  number_type?: string;

  @doc("Carrier information. Adding include=carrier to your request will do a live lookup to determine the current carrier information about this number.")
  carrier?: CarrierLookupInfo;

  @doc("Caller ID information. Adding include=cnam to your request will do a live lookup to determine the current caller ID information about this number.")
  cnam?: CnamInfo;
}

@doc("Carrier lookup information.")
model CarrierLookupInfo {
  @doc("The LRN associated with the number.")
  @example("15551234567")
  lrn?: string;

  @doc("The Service Profile Identifier associated with the number.")
  @example("683X")
  spid?: string;

  @doc("The Operating Company Number associated with the number.")
  @example("12345")
  ocn?: string;

  @doc("The Local Access and Transport Area number associated with the number.")
  @example("99999")
  lata?: string;

  @doc("The City associated with the number.")
  @example("Aberdeen")
  city?: string;

  @doc("The State/Province/Region associated with the number.")
  @example("WA")
  state?: string;

  @doc("The Jurisdiction associated with the number.")
  @example("indeterminate")
  jurisdiction?: string;

  @doc("The LEC or Carrier of the number.")
  @example("Verizon")
  lec?: string;

  @doc("The type of line the number is. Generally either wireless or landline.")
  @example("landline")
  linetype?: string;
}

@doc("Caller ID (CNAM) information.")
model CnamInfo {
  @doc("The caller ID associated with the number.")
  @example("John Smith")
  caller_id?: string;
}
