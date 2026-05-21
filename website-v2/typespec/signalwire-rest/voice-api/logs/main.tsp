import "@typespec/http";
import "@typespec/openapi";
import "../../types/status-codes/main.tsp";
import "../tags.tsp";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "./models/errors.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/logs")
namespace VoiceAPI.Logs {
  @tag(VOICE_LOGS_TAG)
  @friendlyName("Logs")
  interface Logs {
    @operationId("list_voice_logs")
    @summary("List Logs")
    @doc("""
      List the available logs.
      
      ${tokenPermissions<"_Voice_">}
      """)
    list(...LogListRequest):
      | LogListResponse
      | StatusCode400
      | StatusCode401
      | VoiceLogsListStatusCode422
      | StatusCode500;

    @operationId("get_voice_log")
    @summary("Find a Log by ID")
    @doc("""
      Find a log by ID.
      
      ${tokenPermissions<"_Voice_">}
      """)
    retrieve(...LogPathID):
      | LogRetrieveResponse
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | StatusCode422
      | StatusCode500;

    @operationId("list_voice_log_events")
    @summary("List Log Events")
    @doc("""
      List all events for a specific log.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @route("/{id}/events")
    listEvents(...LogPathID):
      | LogEventsListResponse
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | StatusCode422
      | StatusCode500;
  }
}
