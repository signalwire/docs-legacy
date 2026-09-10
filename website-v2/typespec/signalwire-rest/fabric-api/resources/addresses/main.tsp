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

@route("/resources/{id}/addresses")
namespace FabricAPI.Resource.Addresses {
  @tag(RESOURCES_TAG)
  interface ResourceAddresses {
    @operationId("list_resource_addresses")
    @summary("List Resource Addresses")
    @doc("""
      This endpoint is used to retrieve addresses associated with a specific Resource.
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list(...ResourceAddressPathID):
      | ResourceAddressListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
