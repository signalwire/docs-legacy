import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/responses.tsp";
import "../../types";
import "../tags.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/recordings")
namespace RelayRestAPI.Recordings {
  @tag(RECORDINGS_TAG)
  @friendlyName("Recordings")
  interface Recordings {
    @operationId("list_recordings")
    @summary("List Relay Recordings")
    @doc("""
      Returns a list of your recordings.
      
      ${tokenPermissions<"_Voice_">}
      """)
    list():
      | RecordingListResponse
      | StatusCode401
      | StatusCode404
      | ValidationError
      | StatusCode500;

    @operationId("get_recording")
    @summary("Get Relay Recording")
    @doc("""
      Retrieves the details of a recording.
      
      ${tokenPermissions<"_Voice_">}
      """)
    read(...RecordingPathID):
      | RecordingResponse
      | StatusCode401
      | StatusCode404
      | ValidationError
      | StatusCode500;

    @operationId("delete_recording")
    @summary("Delete Relay Recording")
    @doc("""
      Deletes a recording.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @delete
    delete(...RecordingPathID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode401
      | StatusCode404
      | ValidationError
      | StatusCode500;
  }
}
