import "@typespec/http";
import "@typespec/openapi";
import "../../../types";
import "./models/responses.tsp";
import "./models/requests.tsp";
import "../../tags.tsp";
import "../../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/resources/sip_gateways/{resource_id}/addresses")
namespace FabricAPI.SipGateways.Addresses {
  @tag(SIP_GATEWAY_TAG)
  @friendlyName("SIP Gateway")
  interface RelayApplicationAddresses {
    @operationId("list_sip_gateway_addresses")
    @summary("List Fabric Addresses assigned to a SIP Gateway")
    @doc("""
      Returns a paginated list of Fabric Addresses associated with the specified SIP Gateway.
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    readAddressesByResourceId(...SipGatewayAddressRequest):
      | SipGatewayAddressListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
