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

@route("/resources/cxml_scripts")
namespace FabricAPI.CXMLScripts {
  @tag(CXML_SCRIPTS_TAG)
  @friendlyName("CXML Scripts")
  @summary("CXML Scripts")
  interface CXMLScripts {
    @operationId("list_cxml_scripts")
    @summary("List cXML Scripts")
    @doc("""
      A list of cXML Scripts
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list():
      | CXMLScriptListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("get_cxml_script")
    @summary("Get cXML Script")
    @doc("""
      Returns a cXML Script by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    read(...CXMLScriptPathID):
      | {
          @statusCode statusCode: 200;
          @body cxml_script: CXMLScriptResponse;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("create_cxml_script")
    @summary("Create cXML Script")
    @doc("""
      Creates a cXML Script
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @post
    create(@body request: CXMLScriptCreateRequest):
      | {
          @statusCode statusCode: 200;
          @body cxml_script: CXMLScriptResponse;
        }
      | StatusCode401
      | StatusCode404
      | CXMLScriptCreateStatusCode422
      | StatusCode500;

    @operationId("update_cxml_script")
    @summary("Update cXML Script")
    @doc("""
      Updates a cXML Script by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @put
    update(...CXMLScriptPathID, @body request: CXMLScriptUpdateRequest):
      | {
          @statusCode statusCode: 200;
          @body cxml_script: CXMLScriptResponse;
        }
      | StatusCode401
      | StatusCode404
      | CXMLScriptUpdateStatusCode422
      | StatusCode500;

    @operationId("delete_cxml_script")
    @summary("Delete cXML Script")
    @doc("""
      Deletes a cXML Script by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @delete
    delete(...CXMLScriptPathID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
