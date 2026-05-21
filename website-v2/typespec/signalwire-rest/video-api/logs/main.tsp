import "@typespec/http";
import "@typespec/openapi";
import "../../types/status-codes";
import "../tags.tsp";
import "../_shared/models.tsp";
import "../_shared/errors.tsp";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/logs")
namespace VideoAPI.Logs {
  @tag(LOGS_TAG)
  @friendlyName("Logs")
  interface Logs {
    @operationId("list_logs")
    @summary("List Logs")
    @doc("List the available logs.\n\n${tokenPermissions<"_Video_">}")
    list(...ListLogsRequest):
      | ListLogsResponse
      | StatusCode400
      | StatusCode401
      | StatusCode403
      | VideoStatusCode422
      | StatusCode500;

    @operationId("get_log")
    @summary("Find a Log by ID")
    @doc("Find a log by ID.\n\n${tokenPermissions<"_Video_">}")
    @route("/{id}")
    read(
      ...LogPathID,
    ):
      | LogResponse
      | StatusCode400
      | StatusCode401
      | StatusCode403
      | StatusCode404
      | VideoStatusCode422
      | StatusCode500;
  }
}
