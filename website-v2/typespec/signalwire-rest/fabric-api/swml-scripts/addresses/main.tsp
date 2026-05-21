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

@route("/resources/swml_scripts/{id}/addresses")
namespace FabricAPI.SWMLScript.Addresses {
  @tag(SWML_SCRIPTS_TAG)
  interface SWMLScriptAddresses {
    @operationId("list_swml_script_addresses")
    @summary("List SWML Script Addresses")
    @doc("""
      This endpoints returns a list of addresses associated with a specific SWML script.
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list(...SWMLScriptAddressPathID):
      | SWMLScriptAddressListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
