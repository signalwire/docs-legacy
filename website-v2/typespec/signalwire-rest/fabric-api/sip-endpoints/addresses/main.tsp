import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/responses.tsp";
import "../../../types";
import "../../tags.tsp";
import "../../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/resources/sip_endpoints/{id}/addresses")
namespace FabricAPI.SipEndpoint.Addresses {
  @tag(SIP_ENDPOINTS_TAG)
  interface SipEndpointAddresses {
    @operationId("list_sip_endpoint_addresses")
    @summary("List SIP Endpoint Addresses")
    @doc("""
      A list of SIP Endpoint Addresses.
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list(...SipEndpointAddressPathID):
      | SipEndpointAddressListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
