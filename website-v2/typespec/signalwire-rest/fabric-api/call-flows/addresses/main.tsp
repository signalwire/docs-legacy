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

@route("/resources/call_flow/{id}/addresses")
namespace FabricAPI.CallFlow.Addresses {
  @tag(CALL_FLOWS_TAG)
  interface CallFlowAddresses {
    @operationId("list_call_flow_addresses")
    @summary("List Call Flow Addresses")
    @doc("""
      This endpoint returns a list of addresses associated with a specific Call Flow.
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list(...CallFlowAddressPathID):
      | CallFlowAddressListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
