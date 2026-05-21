import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "./models/errors.tsp";
import "./addresses";
import "../../types";
import "../tags.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/resources/cxml_applications")
namespace FabricAPI.CxmlApplications {
  @tag(CXML_APPLICATIONS_TAG)
  @friendlyName("cXML Applications")
  interface CxmlApplications {
    @operationId("list_cxml_applications")
    @summary("List cXML Applications")
    @doc("""
      A list of cXML Applications
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list():
      | CxmlApplicationListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("get_cxml_application")
    @summary("Get cXML Application")
    @doc("""
      Returns a cXML Application by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    read(...CxmlApplicationPathID):
      | {
          @statusCode statusCode: 200;
          @body laml_application: CxmlApplicationResponse;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("update_cxml_application")
    @summary("Update cXML Application")
    @doc("""
      Updates a cXML Application by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @put
    update(
      ...CxmlApplicationPathID,
      @body request: CxmlApplicationUpdateRequest,
    ):
      | {
          @statusCode statusCode: 200;
          @body laml_application: CxmlApplicationResponse;
        }
      | StatusCode401
      | StatusCode404
      | CxmlApplicationUpdateStatusCode422
      | StatusCode500;

    @operationId("delete_cxml_application")
    @summary("Delete LAML Application")
    @doc("""
      Deletes a LAML Application by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @delete
    delete(...CxmlApplicationPathID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
