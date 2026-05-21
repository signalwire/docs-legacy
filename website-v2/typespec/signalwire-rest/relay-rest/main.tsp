import "@typespec/http";
import "@typespec/openapi";
import "../types";
import "./addresses";
import "./domain-applications";
import "./sip-endpoints";
import "./sip-profile";
import "./phone-numbers";
import "./number-groups";
import "./mfa";
import "./verified-caller-ids";
import "./campaign-registry";
import "./queues";
import "./recordings";
import "./short-codes";
import "../_globally_shared/const.tsp";
import "../../_shared/auth.tsp";
import "./tags.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@tagMetadata(ADDRESSES_TAG, ADDRESSES_TAG_METADATA)
@tagMetadata(CAMPAIGN_REGISTRY_TAG, CAMPAIGN_REGISTRY_TAG_METADATA)
@tagMetadata(DOMAIN_APPLICATIONS_TAG, DOMAIN_APPLICATIONS_TAG_METADATA)
@tagMetadata(NUMBER_GROUPS_TAG, NUMBER_GROUPS_TAG_METADATA)
@tagMetadata(NUMBER_GROUP_MEMBERSHIP_TAG, NUMBER_GROUP_MEMBERSHIP_TAG_METADATA)
@tagMetadata(PHONE_NUMBERS_TAG, PHONE_NUMBERS_TAG_METADATA)
@tagMetadata(IMPORTED_PHONE_NUMBERS_TAG, IMPORTED_PHONE_NUMBERS_TAG_METADATA)
@tagMetadata(PHONE_NUMBER_LOOKUP_TAG, PHONE_NUMBER_LOOKUP_TAG_METADATA)
@tagMetadata(RECORDINGS_TAG, RECORDINGS_TAG_METADATA)
@tagMetadata(SIP_ENDPOINTS_TAG, SIP_ENDPOINTS_TAG_METADATA)
@tagMetadata(SIP_PROFILE_TAG, SIP_PROFILE_TAG_METADATA)
@tagMetadata(MFA_TAG, MFA_TAG_METADATA)
@tagMetadata(VERIFIED_CALLER_IDS_TAG, VERIFIED_CALLER_IDS_TAG_METADATA)
@tagMetadata(QUEUES_TAG, QUEUES_TAG_METADATA)
@tagMetadata(QUEUE_MEMBERS_TAG, QUEUE_MEMBERS_TAG_METADATA)
@tagMetadata(SHORT_CODES_TAG, SHORT_CODES_TAG_METADATA)
@service(#{ title: "RELAY REST API" })
@externalDocs(
  "https://signalwire.com/docs/apis",
  "Find more information about this and other SignalWire APIs."
)
@info(#{
  title: "RELAY REST API",
  version: "1.0.0",
  contact: CONTACT_INFO,
  license: LICENSE_INFO,
  termsOfService: TERMS_OF_SERVICE,
})
@server(
  "https://{space_name}.signalwire.com/api/relay/rest",
  "Endpoint",
  {
    @doc("Your SignalWire Space's subdomain.")
    @example("YOUR_SPACE")
    space_name: string = "YOUR_SPACE",
  }
)
@useAuth(SignalWireBasicAuth)
namespace RelayRestAPI;
