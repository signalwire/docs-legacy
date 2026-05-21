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

@route("/resources/{id}/phone_routes")
namespace FabricAPI.PhoneRoutes {
  @tag(PHONE_ROUTES_TAG)
  @friendlyName("Phone Routes")
  interface PhoneRoutes {
    @operationId("assign_resource_phone_route")
    @summary("Assign a Resource to a Phone Route")
    @doc("""
      This endpoint assigns a specific resource to a phone route, allowing inbound calls & messages to be handled by the resource.
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @post
    assign(...PhoneRoutePathID, @body request: PhoneRouteAssignRequest):
      | {
          @statusCode statusCode: 200;
          @body phone_route: PhoneRouteResponse;
        }
      | StatusCode401
      | StatusCode404
      | PhoneRouteCreateStatusCode422
      | StatusCode500;
  }
}
