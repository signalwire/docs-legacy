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
namespace MessageAPI.Logs {
  @tag(MESSAGE_LOGS_TAG)
  @friendlyName("Logs")
  interface Logs {
    @operationId("list_message_logs")
    @summary("List Logs")
    @doc("""
      List the available logs.

      ${tokenPermissions<"_Messaging_">}
      """)
    list(...LogListRequest):
      | LogListResponse
      | StatusCode400
      | StatusCode401
      | MessageLogsListStatusCode422
      | StatusCode500;

    @operationId("get_message_log")
    @summary("Find a Log by ID")
    @doc("""
      Find a log by ID.

      ${tokenPermissions<"_Messaging_">}
      """)
    retrieve(...LogPathID):
      | LogRetrieveResponse
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | MessageLogShowStatusCode422
      | StatusCode500;
  }
}
