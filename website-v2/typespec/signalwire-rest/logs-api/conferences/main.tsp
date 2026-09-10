import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "./models/errors.tsp";
import "../../types";
import "../../../_shared/auth.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@useAuth(SignalWireBasicAuth)
@route("/conferences")
namespace LogsAPI.Conferences {
  @tag(CONFERENCES_TAG)
  @friendlyName("Conferences")
  interface Conferences {
    @operationId("list_conferences")
    @summary("List Conferences")
    @doc("""
      A list of Conferences.
      
      ${tokenPermissions<"_Voice_ or _Video_">}
      """)
    list(...ConferenceLogListRequest):
      | ConferencesResponse
      | StatusCode401
      | ConferenceLogsStatusCode422
      | StatusCode500;
  }
}
