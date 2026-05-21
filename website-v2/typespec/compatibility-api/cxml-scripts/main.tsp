import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "../_shared/errors.tsp";
import "../tags.tsp";
import "../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@route("/Accounts/{AccountSid}/LamlBins")
namespace CompatibilityAPI.CxmlScripts {
  @tag(CXML_SCRIPTS_TAG)
  @friendlyName("cXML Scripts")
  interface CxmlScripts {
    @operationId("list_cxml_scripts")
    @summary("List All cXML Scripts")
    @doc("""
      Returns a list of your cXML scripts. The scripts are returned sorted by creation date, with the most recent appearing first.
      
      ${tokenPermissions<"_Voice_ or _Messaging_ or _Fax_">}
      """)
    list(
      ...CxmlScriptsAccountSidPath,

      @query
      @doc("A friendly name given to the cXML script.")
      @example("Death Star IVR")
      Name?: string,

      @query
      @doc("The page number to retrieve. Default is 0.")
      @example(0)
      Page?: int32 = 0,

      @query
      @doc("The number of items per page. Default is 50, maximum is 1000.")
      @minValue(1)
      @maxValue(1000)
      @example(50)
      PageSize?: int32 = 50,

      @query
      @doc("The token for cursor-based pagination. Must start with 'PA' or 'PB'.")
      @example("PAb3877c40da604998")
      PageToken?: string,
    ):
      | CxmlScriptListResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422;

    @operationId("create_cxml_script")
    @summary("Create a cXML Script")
    @doc("""
      Create a cXML script.
      
      ${tokenPermissions<"_Voice_ or _Messaging_ or _Fax_">}
      """)
    @post
    create(
      ...CxmlScriptsAccountSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: CreateCxmlScriptRequest,
    ):
      | CxmlScriptCreatedResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422;

    @operationId("retrieve_cxml_script")
    @summary("Retrieve a cXML Script")
    @doc("""
      Retrieve a cXML script.
      
      ${tokenPermissions<"_Voice_ or _Messaging_ or _Fax_">}
      """)
    @route("/{Sid}")
    read(...CxmlScriptsAccountSidPath, ...CxmlScriptSidPath):
      | CxmlScriptResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404;

    @operationId("update_cxml_script")
    @summary("Update a cXML Script")
    @doc("""
      Update a cXML script.
      
      ${tokenPermissions<"_Voice_ or _Messaging_ or _Fax_">}
      """)
    @post
    @route("/{Sid}")
    update(
      ...CxmlScriptsAccountSidPath,
      ...CxmlScriptSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: UpdateCxmlScriptRequest,
    ):
      | CxmlScriptResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422;

    @operationId("delete_cxml_script")
    @summary("Delete a cXML Script")
    @doc("""
      Delete a cXML script.
      
      ${tokenPermissions<"_Voice_ or _Messaging_ or _Fax_">}
      """)
    @delete
    @route("/{Sid}")
    delete(...CxmlScriptsAccountSidPath, ...CxmlScriptSidPath):
      | CompatibilityStatusCode204
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422;
  }
}
