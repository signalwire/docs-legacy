@doc("DisplayTypes")
enum DisplayTypes {
  App: "app",
  Room: "room",
  Call: "call",
  Subscriber: "subscriber",
}

model AudioChannel {
  @doc("Audio Channel of Fabric Address")
  @example("/external/resource_name?channel=audio")
  audio: string;
}

model MessagingChannel {
  @doc("Messaging Channel of Fabric Address")
  @example("/external/resource_name?channel=messaging")
  messaging: string;
}

model VideoChannel {
  @doc("Video Channel of Fabric Address")
  @example("/external/resource_name?channel=video")
  video: string;
}

@doc("Sets the handler to handle incoming `calls` or `messages`.")
enum UsedForType {
  Calling: "calling",
  Messaging: "messaging",
}

@doc("The method type to use for the URL")
enum UrlMethodType {
  Get: "GET",
  Post: "POST",
}

@doc("Indicates whether the call will be handled by a script or an external url.")
enum HandleCallsUsing {
  Script: "script",
  ExternalUrl: "external_url",
}

enum FabricResponseType {
  AiAgent: "ai_agent",
  DialogflowAgent: "dialogflow_agent",
  CallFlow: "call_flow",
  SwmlWebhook: "swml_webhook",
  FreeswitchConnector: "freeswitch_connector",
  CxmlApplication: "cxml_application",
  CxmlScript: "cxml_script",
  CxmlWebhook: "cxml_webhook",
  RelayApplication: "relay_application",
  SipEndpoint: "sip_endpoint",
  SipGateway: "sip_gateway",
  Subscriber: "subscriber",
  SwmlScript: "swml_script",
  ConferenceRoom: "video_room",
}

union AddressChannel {
  AudioChannel,
  MessagingChannel,
  VideoChannel,
}
