import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/responses.tsp";
import "./models/webhooks.tsp";
import "../_shared/errors.tsp";
import "../tags.tsp";
import "../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@webhook("transcriptionStatusCallback", TranscriptionStatusCallbackPayload, "Recording Transcriptions")
@route("/Accounts/{AccountSid}/Transcriptions")
namespace CompatibilityAPI.Transcriptions {
  @tag(TRANSCRIPTIONS_TAG)
  @friendlyName("Recording Transcriptions")
  interface Transcriptions {
    @operationId("list_transcriptions")
    @summary("List all Transcriptions")
    @doc("""
      List all transcriptions. Results are returned as a paginated list ordered by creation date (newest first).
      
      ${tokenPermissions<"_Voice_">}
      """)
    list(
      ...TranscriptionsAccountSidPath,

      @query
      @doc("Filter by transcriptions created on this exact date (RFC 2822 format).")
      @example("Wed, 26 Sep 2018 00:00:00 +0000")
      DateCreated?: string,

      @query("DateCreated<")
      @doc("Filter by transcriptions created before this date (RFC 2822 format).")
      @example("Thu, 27 Sep 2018 00:00:00 +0000")
      DateCreatedBefore?: string,

      @query("DateCreated>")
      @doc("Filter by transcriptions created after this date (RFC 2822 format).")
      @example("Tue, 25 Sep 2018 00:00:00 +0000")
      DateCreatedAfter?: string,

      @query
      @doc("The page number to retrieve (zero-indexed).")
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
      @doc("Token for cursor-based pagination. Required when navigating to pages beyond the first.")
      @example("PAb3877c40-da60-4998-90ad-b792e98472tr")
      PageToken?: string,
    ):
      | TranscriptionListResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422;

    @operationId("retrieve_transcription")
    @summary("Retrieve a Transcription")
    @doc("""
      Retrieve a single recording transcription.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @route("/{Sid}")
    read(...TranscriptionsAccountSidPath, ...TranscriptionSidPath):
      | TranscriptionResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404;

    @operationId("delete_transcription")
    @summary("Delete a Recording Transcription")
    @doc("""
      Delete a recording transcription from your account. If the delete is successful, a 204 response, with no body, will be returned.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @delete
    @route("/{Sid}")
    delete(...TranscriptionsAccountSidPath, ...TranscriptionSidPath):
      | CompatibilityStatusCode204
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422;
  }
}
