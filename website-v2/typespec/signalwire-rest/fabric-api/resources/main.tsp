import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "./models/errors.tsp";
import "./addresses";
import "../../types";
import "../tags.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/resources")
namespace FabricAPI.Resources {
  @tag(RESOURCES_TAG)
  @friendlyName("Resources")
  interface Resources {
    @operationId("list_resources")
    @summary("List Resources")
    @doc("""
      A list of Fabric Resources
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list():
      | ResourceListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("get_resource")
    @summary("Get Resource")
    @doc("""
      Returns a Resource by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    read(...ResourcePathID):
      | {
          @statusCode statusCode: 200;
          @body resource: ResourceResponse;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("delete_resource")
    @summary("Delete Resource")
    @doc("""
      Deletes a Resource by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @delete
    delete(...ResourcePathID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
