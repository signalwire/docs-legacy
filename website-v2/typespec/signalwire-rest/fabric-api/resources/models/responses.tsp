import "./core.tsp";
import "../../_shared/const.tsp";
import "../../_shared/enums.tsp";
import "../../ai-agent";
import "../../call-flows";
import "../../cxml-webhooks";
import "../../cxml-scripts";
import "../../cxml-applications";
import "../../dialogflow-agents";
import "../../freeswitch-connectors";
import "../../relay-applications";
import "../../sip-endpoints";
import "../../sip_gateways";
import "../../subscribers";
import "../../subscribers/subscriber-sip-endpoint";
import "../../swml-webhook";
import "../../swml-scripts";
import "../../conference-rooms";
import "@typespec/http";
import "@typespec/openapi3";

using TypeSpec.OpenAPI;

const RESPONSE_TYPE_DESC = "The type of Resource";

model ResourceResponseBase {
  @doc("Unique ID of the Resource.")
  @example("993ed018-9e79-4e50-b97b-984bd5534095")
  @format("uuid")
  id: uuid;

  @doc("Unique ID of the Project.")
  @example("1313fe58-5e14-4c11-bbe7-6fdfa11fe780")
  @format("uuid")
  project_id: uuid;

  @doc("Display name of the Resource")
  @example("My Resource")
  display_name: string;

  @doc("Date and time when the resource was created.")
  @example(UTC_TIME_EXAMPLE)
  created_at: utcDateTime;

  @doc("Date and time when the resource was updated.")
  @example(UTC_TIME_EXAMPLE)
  updated_at: utcDateTime;
}

@summary("AI Agent")
model ResourceResponseAI is ResourceResponseBase {
  @doc(RESPONSE_TYPE_DESC)
  @example(FabricResponseType.AiAgent)
  type: FabricResponseType.AiAgent;

  @doc("An object containing the response data of the AI Agent")
  ai_agent: AIAgent;
}

@summary("Call Flow")
model ResourceResponseCallFlow is ResourceResponseBase {
  @doc(RESPONSE_TYPE_DESC)
  @example(FabricResponseType.CallFlow)
  type: FabricResponseType.CallFlow;

  @doc("An object containing the response data of the Call Flow")
  call_flow: CallFlow;
}

@summary("cXML Webhook")
model ResourceResponseCXMLWebhook is ResourceResponseBase {
  @doc(RESPONSE_TYPE_DESC)
  @example(FabricResponseType.CxmlWebhook)
  type: FabricResponseType.CxmlWebhook;

  @doc("An object containing the response data of the cXML Webhook")
  cxml_webhook: CXMLWebhook;
}

@summary("cXML Script")
model ResourceResponseCXMLScript is ResourceResponseBase {
  @doc(RESPONSE_TYPE_DESC)
  @example(FabricResponseType.CxmlScript)
  type: FabricResponseType.CxmlScript;

  @doc("An object containing the response data of the cXML Script")
  cxml_script: CXMLScript;
}

@summary("cXML Application")
model ResourceResponseCXMLApplication is ResourceResponseBase {
  @doc(RESPONSE_TYPE_DESC)
  @example(FabricResponseType.CxmlApplication)
  type: FabricResponseType.CxmlApplication;

  @doc("An object containing the response data of the cXML Application")
  cxml_application: CxmlApplication;
}

@summary("Dialogflow Agent")
model ResourceResponseDialogFlowAgent is ResourceResponseBase {
  @doc(RESPONSE_TYPE_DESC)
  @example(FabricResponseType.DialogflowAgent)
  type: FabricResponseType.DialogflowAgent;

  @doc("An object containing the response data of the Dialogflow Agent")
  dialogflow_agent: DialogflowAgent;
}

@summary("FreeSWITCH Connector")
model ResourceResponseFSConnector is ResourceResponseBase {
  @doc(RESPONSE_TYPE_DESC)
  @example(FabricResponseType.FreeswitchConnector)
  type: FabricResponseType.FreeswitchConnector;

  @doc("An object containing the response data of the FreeSWITCH Connector")
  freeswitch_connector: FreeswitchConnector;
}

@summary("Relay Application")
model ResourceResponseRelayApp is ResourceResponseBase {
  @doc(RESPONSE_TYPE_DESC)
  @example(FabricResponseType.RelayApplication)
  type: FabricResponseType.RelayApplication;

  @doc("An object containing the response data of the Relay Application")
  relay_application: RelayApplication;
}

@summary("SIP Endpoint")
model ResourceResponseSipEndpoint is ResourceResponseBase {
  @doc(RESPONSE_TYPE_DESC)
  @example(FabricResponseType.SipEndpoint)
  type: FabricResponseType.SipEndpoint;

  @doc("An object containing the response data of the SIP Endpoint")
  sip_endpoint: SipEndpoint;
}

@summary("SIP Gateway")
model ResourceResponseSipGateway is ResourceResponseBase {
  @doc(RESPONSE_TYPE_DESC)
  @example(FabricResponseType.SipGateway)
  type: FabricResponseType.SipGateway;

  @doc("An object containing the response data of the SIP Gateway")
  sip_gateway: SipGateway;
}

@summary("Subscriber")
model ResourceResponseSubscriber is ResourceResponseBase {
  @doc(RESPONSE_TYPE_DESC)
  @example(FabricResponseType.Subscriber)
  type: FabricResponseType.Subscriber;

  @doc("An object containing the response data of the Subscriber")
  subscriber: Subscriber;
}

@summary("SWML Webhook")
model ResourceResponseSWMLWebhook is ResourceResponseBase {
  @doc(RESPONSE_TYPE_DESC)
  @example(FabricResponseType.SwmlWebhook)
  type: FabricResponseType.SwmlWebhook;

  @doc("An object containing the response data of the SWML Webhook")
  swml_webhook: SWMLWebhook;
}

@summary("SWML Script")
model ResourceResponseSWMLScript is ResourceResponseBase {
  @doc(RESPONSE_TYPE_DESC)
  @example(FabricResponseType.SwmlScript)
  type: FabricResponseType.SwmlScript;

  @doc("An object containing the response data of the SWML Script")
  swml_script: SwmlScript;
}

@summary("Conference Room")
model ResourceResponseConferenceRoom is ResourceResponseBase {
  @doc(RESPONSE_TYPE_DESC)
  @example(FabricResponseType.SwmlScript)
  type: FabricResponseType.SwmlScript;

  @doc("An object containing the response data of the Conference Room")
  conference_room: ConferenceRoom;
}

@oneOf
union ResourceResponse {
  ResourceResponseAI,
  ResourceResponseCallFlow,
  ResourceResponseCXMLWebhook,
  ResourceResponseCXMLScript,
  ResourceResponseCXMLApplication,
  ResourceResponseDialogFlowAgent,
  ResourceResponseFSConnector,
  ResourceResponseRelayApp,
  ResourceResponseSipEndpoint,
  ResourceResponseSipGateway,
  ResourceResponseSubscriber,
  ResourceResponseSWMLWebhook,
  ResourceResponseSWMLScript,
  ResourceResponseConferenceRoom,
}

model ResourceListResponse {
  @doc("An array of objects that contain a list of Resource data")
  data: ResourceResponse[];

  @doc("Object containing pagination links")
  links: ResourcePaginationResponse;
}

model ResourcePaginationResponse {
  @doc("The link to the current page")
  @example("https://devspace.signalwire.com/api/fabric/resources?page_number=0&page_size=50")
  self: url;

  @doc("The link to the first page")
  @example("https://devspace.signalwire.com/api/fabric/resources?page_size=50")
  first: url;

  @doc("The link to the next page")
  @example("https://devspace.signalwire.com/api/fabric/resources?page_number=1&page_size=50&page_token=PA0f2b7869-304c-45ac-8863-3455ccb34cdc")
  next?: url;

  @doc("The link to the previous page")
  @example("https://devspace.signalwire.com/api/fabric/resources?page_number=0&page_size=50&page_token=PA0f2b7869-304c-45ac-8863-3455ccb34cdc")
  prev?: url;
}
