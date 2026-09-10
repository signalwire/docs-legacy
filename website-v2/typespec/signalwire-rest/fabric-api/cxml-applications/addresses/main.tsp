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

@route("/resources/cxml_applications/{id}/addresses")
namespace FabricAPI.CxmlApplication.Addresses {
  @tag(CXML_APPLICATIONS_TAG)
  interface CxmlApplicationAddresses {
    @operationId("list_cxml_application_addresses")
    @summary("List cXML Application Addresses")
    @doc("""
      This endpoint returns a list of addresses associated with a specific LaML Application.
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list(...CxmlApplicationAddressPathID):
      | CxmlApplicationAddressListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
