import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "./models/errors.tsp";
import "../../types";
import "../tags.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/logs")
namespace FaxAPI.Logs {
  @tag(LOGS_TAG)
  @friendlyName("Logs")
  interface Logs {
    @operationId("list_fax_logs")
    @summary("List Logs")
    @doc("""
      List the available logs.
      
      ${tokenPermissions<"_Fax_">}
      """)
    list(...LogListRequest):
      | LogListResponse
      | StatusCode400
      | StatusCode401
      | FaxLogsListStatusCode422
      | StatusCode500;

    @operationId("get_fax_log")
    @summary("Find a Log by ID")
    @doc("""
      Find a log by ID.
      
      ${tokenPermissions<"_Fax_">}
      """)
    read(...LogPathID):
      | LogResponse
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | FaxLogShowStatusCode422
      | StatusCode500;
  }
}
