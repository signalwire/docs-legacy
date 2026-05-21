import "@typespec/http";
import "@typespec/openapi";
import "../types";
import "../../_shared/auth.tsp";
import "./conferences";
import "./tags.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@tagMetadata(CONFERENCES_TAG, CONFERENCES_TAG_METADATA)
@service(#{ title: "Logs API" })
@server(
  "https://{space_name}.signalwire.com/api/logs/",
  "Endpoint",
  {
    space_name: string = "{Your_Space_Name}",
  }
)
@useAuth(SignalWireBasicAuth)
@doc("API to manage and query log data for SignalWire.")
namespace LogsAPI;
