import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/responses.tsp";
import "../_shared/errors.tsp";
import "../tags.tsp";
import "../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@route("/Accounts/{AccountSid}/Recordings")
namespace CompatibilityAPI.Recordings {
  @tag(RECORDINGS_TAG)
  @friendlyName("Recordings")
  interface Recordings {
    @operationId("list_recordings")
    @summary("List all Recordings")
    @doc("""
      List all recordings. Results are returned as a paginated list ordered by creation date (newest first).
      
      ${tokenPermissions<"_Voice_">}
      """)
    list(
      ...RecordingsAccountSidPath,

      @query
      @doc("Filter by recordings created on this exact date (RFC 2822 format).")
      @example("Wed, 26 Sep 2018 00:00:00 +0000")
      DateCreated?: string,

      @query("DateCreated<")
      @doc("Filter by recordings created before this date (RFC 2822 format).")
      @example("Thu, 27 Sep 2018 00:00:00 +0000")
      DateCreatedBefore?: string,

      @query("DateCreated>")
      @doc("Filter by recordings created after this date (RFC 2822 format).")
      @example("Tue, 25 Sep 2018 00:00:00 +0000")
      DateCreatedAfter?: string,

      @query
      @doc("Filter by recordings associated with a specific call.")
      @format("uuid")
      @example("43bb71ee-553f-4074-bb20-8e2747647cce")
      CallSid?: string,

      @query
      @doc("Filter by recordings associated with a specific conference.")
      @format("uuid")
      @example("b3877c40-da60-4998-90ad-b792e98472cf")
      ConferenceSid?: string,

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
      @example("PA19e436af-5688-4307-b03b-bdb2b42b8142")
      PageToken?: string,
    ):
      | RecordingListResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422;

    @operationId("retrieve_recording")
    @summary("Retrieve a Recording")
    @doc("""
      Retrieve a single recording media or its metadata.
      
      This endpoint supports two different access methods with different authentication requirements:
      
      ## Public Access (No Authentication Required)
      
      Recording audio files can be accessed directly without authentication. This is useful for external applications
      to embed recording URLs without exposing SignalWire API credentials. SignalWire recording URLs are long
      and random, making them difficult to guess or exploit unless you reveal the URL.
      
      **Retrieve WAV file**
      
      When a recording URI has no extension or a `.wav` extension, the request
      will return a binary WAV version of the recording file.
      
      `GET https://example.signalwire.com/api/laml/2010-04-01/Accounts/{AccountSid}/Recordings/{Sid}`
      
      `GET https://example.signalwire.com/api/laml/2010-04-01/Accounts/{AccountSid}/Recordings/{Sid}.wav`
      
      **Retrieve MP3 file**
      
      Setting an extension of ".mp3" on the URI returns a binary MP3 version
      of the recording. For example:
      
      `GET https://example.signalwire.com/api/laml/2010-04-01/Accounts/{AccountSid}/Recordings/{Sid}.mp3`
      
      ## Authenticated Access (Voice Scope Required)
      
      **Retrieve Metadata**
      
      A recording's metadata, such as duration, cost, time, can be returned by
      setting the Recording URI's extension to `.json`. This requires authentication
      with a Voice-scoped API token.
      
      `GET https://example.signalwire.com/api/laml/2010-04-01/Accounts/{AccountSid}/Recordings/{Sid}.json`
      
      #### Permissions
      
      The API token used to authenticate must have the following scopes enabled to make a successful request: _Voice_.
      
      This permission is only required for authenticated requests to retrieve recording metadata (.json extension).
      
      [Learn more about API scopes](/docs/platform/your-signalwire-api-space).
      """)
    @route("/{Sid}")
    read(...RecordingsAccountSidPath, ...RecordingSidPath):
      | RecordingResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404;

    @operationId("delete_recording")
    @summary("Delete a Recording.")
    @doc("""
      Delete recording. If the delete is successful, a 204 response, with no body, will be returned.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @delete
    @route("/{Sid}")
    delete(...RecordingsAccountSidPath, ...RecordingSidPath):
      | CompatibilityStatusCode204
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422;
  }
}
