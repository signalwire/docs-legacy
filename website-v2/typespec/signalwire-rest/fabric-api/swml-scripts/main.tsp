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

@route("/resources/swml_scripts")
namespace FabricAPI.SwmlScripts {
  @tag(SWML_SCRIPTS_TAG)
  @friendlyName("SWML Scripts")
  interface SwmlScripts {
    @operationId("list_swml_scripts")
    @summary("List SWML Scripts")
    @doc("""
      A list of SWML Scripts
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list():
      | SwmlScriptListResponse[]
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("get_swml_script")
    @summary("Get SWML Script")
    @doc("""
      Returns a SWML Script by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    read(...SwmlScriptPathID):
      | {
          @statusCode statusCode: 200;
          @body swml_script: SwmlScriptResponse;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("create_swml_script")
    @summary("Create SWML Script")
    @doc("""
      Creates a SWML Script
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @post
    create(@body request: SwmlScriptCreateRequest):
      | {
          @statusCode statusCode: 200;
          @body swml_script: SwmlScriptResponse;
        }
      | StatusCode401
      | StatusCode404
      | SwmlScriptCreateStatusCode422
      | StatusCode500;

    @operationId("update_swml_script")
    @summary("Update SWML Script")
    @doc("""
      Updates a SWML Script by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @put
    update(...SwmlScriptPathID, @body request: SwmlScriptUpdateRequest):
      | {
          @statusCode statusCode: 200;
          @body swml_script: SwmlScriptResponse;
        }
      | StatusCode401
      | StatusCode404
      | SwmlScriptUpdateStatusCode422
      | StatusCode500;

    @operationId("delete_swml_script")
    @summary("Delete SWML Script")
    @doc("""
      Deletes a SWML Script by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @delete
    delete(...SwmlScriptPathID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
