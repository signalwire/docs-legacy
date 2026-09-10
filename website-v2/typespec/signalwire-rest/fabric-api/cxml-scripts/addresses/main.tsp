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

@route("/resources/cxml_scripts/{id}/addresses")
namespace FabricAPI.CXMLScript.Addresses {
  @tag(CXML_SCRIPTS_TAG)
  interface CXMLScriptAddresses {
    @operationId("list_cxml_script_addresses")
    @summary("List cXML Script Addresses")
    @doc("""
      This endpoint returns a list of addresses associated with a specific cXML Script.
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list(...CXMLScriptAddressPathID):
      | CXMLScriptAddressListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
