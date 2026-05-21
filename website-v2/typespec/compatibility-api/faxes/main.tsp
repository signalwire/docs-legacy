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

@route("/Accounts/{AccountSid}/Faxes")
namespace CompatibilityAPI.Faxes {
  @tag(FAXES_TAG)
  @friendlyName("Faxes")
  interface Faxes {
    @operationId("list_all_faxes")
    @summary("List all Faxes")
    @doc("""
      List all faxes.
      
      ${tokenPermissions<"_Fax_">}
      """)
    list(
      ...FaxesAccountSidPath,

      @query
      @doc("The page index to retrieve. Zero-indexed.")
      @minValue(0)
      @example(0)
      Page?: int32 = 0,

      @query
      @doc("The number of results per page. Default is 50, maximum is 1000.")
      @minValue(1)
      @maxValue(1000)
      @example(50)
      PageSize?: int32 = 50,

      @query
      @doc("Token for cursor-based pagination. Required when Page > 0.")
      @example("PAb3877c40da604998")
      PageToken?: string,

      @query
      @doc("The date, in ISO 8601 format, after which the fax was sent.")
      @example("2024-01-01T00:00:00Z")
      DateCreatedAfter?: string,

      @query
      @doc("The date, in ISO 8601 format, on or before which the fax was sent.")
      @example("2024-12-31T23:59:59Z")
      DateCreatedOnOrBefore?: string,

      @query
      @doc("The phone number, in E.164 format, the fax was sent from.")
      @example("+15551234567")
      From?: string,

      @query
      @doc("The phone number, in E.164 format, the fax was sent to.")
      @example("+15559876543")
      To?: string,
    ):
      | FaxListResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422;

    @operationId("send_fax")
    @summary("Send a Fax")
    @doc("""
      Send a fax.
      
      ${tokenPermissions<"_Fax_">}
      """)
    @post
    create(
      ...FaxesAccountSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: SendFaxRequest,
    ):
      | FaxResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422;

    @operationId("retrieve_fax")
    @summary("Retrieve a Fax")
    @doc("""
      Retrieve a fax.
      
      ${tokenPermissions<"_Fax_">}
      """)
    @route("/{Sid}")
    read(...FaxesAccountSidPath, ...FaxSidPath):
      | FaxResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404;

    @operationId("update_fax")
    @summary("Update a Fax")
    @doc("""
      Allows you to cancel a queued fax. Only faxes in 'queued' status can be canceled.
      
      ${tokenPermissions<"_Fax_">}
      """)
    @post
    @route("/{Sid}")
    update(
      ...FaxesAccountSidPath,
      ...FaxSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: UpdateFaxRequest,
    ):
      | FaxResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422;

    @operationId("delete_fax")
    @summary("Delete a Fax")
    @doc("""
      Delete a fax. Cannot delete a fax that is currently in progress (processing, sending, or receiving).
      
      ${tokenPermissions<"_Fax_">}
      """)
    @delete
    @route("/{Sid}")
    delete(...FaxesAccountSidPath, ...FaxSidPath):
      | CompatibilityStatusCode204
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode409;
  }

  @tag(FAX_MEDIA_TAG)
  @friendlyName("Fax Media")
  @route("/{FaxSid}/Media")
  interface FaxMedia {
    @operationId("list_all_fax_media")
    @summary("List Fax Media")
    @doc("""
      List all media for a fax.
      
      ${tokenPermissions<"_Fax_">}
      """)
    list(
      ...FaxesAccountSidPath,
      ...FaxSidPathForMedia,

      @query
      @doc("The page index to retrieve. Zero-indexed.")
      @minValue(0)
      @example(0)
      Page?: int32 = 0,

      @query
      @doc("The number of results per page. Default is 50, maximum is 1000.")
      @minValue(1)
      @maxValue(1000)
      @example(50)
      PageSize?: int32 = 50,

      @query
      @doc("Token for cursor-based pagination. Required when Page > 0.")
      @example("PAb3877c40da604998")
      PageToken?: string,
    ):
      | FaxMediaListResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422;

    @operationId("retrieve_medias")
    @summary("Retrieve Fax Media")
    @doc("""
      Retrieve media for a fax.
      
      ${tokenPermissions<"_Fax_">}
      """)
    @route("/{Sid}")
    read(...FaxesAccountSidPath, ...FaxSidPathForMedia, ...FaxSidPath):
      | FaxMediaResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404;

    @operationId("delete_fax_media")
    @summary("Delete Fax Media")
    @doc("""
      Delete media for a fax. Cannot delete media for a fax that is in progress (queued, processing, sending, or receiving).
      
      ${tokenPermissions<"_Fax_">}
      """)
    @delete
    @route("/{Sid}")
    delete(...FaxesAccountSidPath, ...FaxSidPathForMedia, ...FaxSidPath):
      | CompatibilityStatusCode204
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode409;
  }
}
