import "@typespec/http";
import "@typespec/openapi";
import "../types";
import "./ai-agent";
import "./dialogflow-agents";
import "./call-flows";
import "./conference-rooms";
import "./cxml-scripts";
import "./cxml-webhooks";
import "./embeds-tokens";
import "./addresses";
import "./freeswitch-connectors";
import "./cxml-applications";
import "./relay-applications";
import "./resources";
import "./sip-endpoints";
import "./sip_gateways";
import "./subscribers";
import "./swml-scripts";
import "./swml-webhook";
import "./domain-applications";
import "./phone-routes";
import "../_globally_shared/const.tsp";
import "../../_shared/auth.tsp";
import "./tags.tsp";
import "../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@tagMetadata(AI_CUSTOM_TAG, AI_CUSTOM_TAG_METADATA)
@tagMetadata(AI_DIALOGFLOW_TAG, AI_DIALOGFLOW_TAG_METADATA)
@tagMetadata(CALL_FLOWS_TAG, CALL_FLOWS_TAG_METADATA)
@tagMetadata(EMBEDS_TOKENS_TAG, EMBEDS_TOKENS_TAG_METADATA)
@tagMetadata(SWML_WEBHOOK_TAG, SWML_WEBHOOK_TAG_METADATA)
@tagMetadata(FABRIC_ADDRESS_TAG, FABRIC_ADDRESS_TAG_METADATA)
@tagMetadata(FREESWITCH_CONNECTOR_TAG, FREESWITCH_CONNECTOR_TAG_METADATA)
@tagMetadata(CXML_APPLICATIONS_TAG, CXML_APPLICATIONS_TAG_METADATA)
@tagMetadata(CXML_SCRIPTS_TAG, CXML_SCRIPTS_TAG_METADATA)
@tagMetadata(CXML_WEBHOOK_TAG, CXML_WEBHOOK_TAG_METADATA)
@tagMetadata(RELAY_APPLICATION_TAG, RELAY_APPLICATION_TAG_METADATA)
@tagMetadata(RESOURCES_TAG, RESOURCES_TAG_METADATA)
@tagMetadata(SIP_ENDPOINTS_TAG, SIP_ENDPOINTS_TAG_METADATA)
@tagMetadata(SIP_GATEWAY_TAG, SIP_GATEWAY_TAG_METADATA)
@tagMetadata(SUBSCRIBERS_TAG, SUBSCRIBERS_TAG_METADATA)
@tagMetadata(SUBSCRIBERS_TOKENS_TAG, SUBSCRIBERS_TOKENS_TAG_METADATA)
@tagMetadata(SUBSCRIBER_SIP_ENDPOINT_TAG, SUBSCRIBER_SIP_ENDPOINT_TAG_METADATA)
@tagMetadata(SWML_SCRIPTS_TAG, SWML_SCRIPTS_TAG_METADATA)
@tagMetadata(CONFERENCE_ROOM_TAG, CONFERENCE_ROOM_TAG_METADATA)
@tagMetadata(DOMAIN_APPLICATIONS_TAG, DOMAIN_APPLICATIONS_TAG_METADATA)
@tagMetadata(PHONE_ROUTES_TAG, PHONE_ROUTES_TAG_METADATA)
@service(#{ title: "Call Fabric API" })
@externalDocs(
  "https://signalwire.com/docs/apis",
  "The Fabric API holds a collection of endpoints that will help you in managing and creating your SignalWire Resources."
)
@info(#{
  title: "Call Fabric API",
  version: "1.0.0",
  contact: CONTACT_INFO,
  license: LICENSE_INFO,
  termsOfService: TERMS_OF_SERVICE,
})
@server(
  "https://{space_name}.${SERVER_URL}/fabric/",
  "Endpoint",
  {
    @doc(SERVER_URL_DESCRIPTION)
    @example("example")
    space_name: string = "{Your_Space_Name}",
  }
)
@useAuth(SignalWireBasicAuth)
@doc("""
  API to access/manage SignalWire's Call Fabric objects.
  
  ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
  """)
namespace FabricAPI;
