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

@route("/Accounts/{AccountSid}/Applications")
namespace CompatibilityAPI.Applications {
  @tag(APPLICATIONS_TAG)
  @friendlyName("Applications")
  interface Applications {
    @operationId("list_applications")
    @summary("List Applications")
    @doc("""
      The ability to read all of the applications that are associated with your Account. This will be returned as a list of applications.
      
      ${tokenPermissions<"_Voice_ or _Messaging_ or _Fax_">}
      """)
    list(
      ...AccountSidPath,

      @query
      @doc("Filter by a named unique identifier for the resource.")
      @example("My Friendly Name")
      FriendlyName?: string,

      @query
      @doc("The page number to retrieve. Page numbers are zero-indexed, so the first page is 0.")
      @minValue(0)
      @example(0)
      Page?: int32 = 0,

      @query
      @doc("The number of results to return per page. The default is 50, and the maximum is 1000.")
      @minValue(1)
      @maxValue(1000)
      @example(50)
      PageSize?: int32 = 50,

      @query
      @doc("A token used to retrieve a specific page of results.")
      @example("PA01234567890abcdef01234567890abcdef")
      PageToken?: string,
    ):
      | ApplicationListResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422;

    @operationId("create_application")
    @summary("Create an Application")
    @doc("""
      Create an Application.
      
      ${tokenPermissions<"_Voice_ or _Messaging_ or _Fax_">}
      """)
    @post
    create(
      ...AccountSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: CreateApplicationRequest,
    ):
      | ApplicationCreatedResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422;

    @operationId("get_application")
    @summary("Find an Application by ID")
    @doc("""
      Find an Application by ID.
      
      ${tokenPermissions<"_Voice_ or _Messaging_ or _Fax_">}
      """)
    @route("/{Sid}")
    read(...AccountSidPath, ...ApplicationPathSid):
      | ApplicationResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404;

    @operationId("update_application")
    @summary("Update an Application")
    @doc("""
      Update an Application.
      
      ${tokenPermissions<"_Voice_ or _Messaging_ or _Fax_">}
      """)
    @post
    @route("/{Sid}")
    update(
      ...AccountSidPath,
      ...ApplicationPathSid,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: UpdateApplicationRequest,
    ):
      | ApplicationResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422;

    @operationId("delete_application")
    @summary("Delete an Application")
    @doc("""
      Delete an Application.
      
      ${tokenPermissions<"_Voice_ or _Messaging_ or _Fax_">}
      """)
    @delete
    @route("/{Sid}")
    delete(...AccountSidPath, ...ApplicationPathSid):
      | CompatibilityStatusCode204
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404;
  }
}
