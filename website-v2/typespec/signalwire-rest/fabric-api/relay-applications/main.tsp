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

@route("/resources/relay_applications")
namespace FabricAPI.RelayApplications {
  @tag(RELAY_APPLICATION_TAG)
  @friendlyName("Relay Applications")
  interface RelayApplications {
    @operationId("list_relay_applications")
    @summary("List Relay Applications")
    @doc("""
      A list of Relay Applications
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list():
      | RelayApplicationListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("get_relay_application")
    @summary("Get Relay Application")
    @doc("""
      Returns a Relay Application by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    read(...RelayApplicationPathID):
      | {
          @statusCode statusCode: 200;
          @body relay_application: RelayApplicationResponse;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("create_relay_application")
    @summary("Create Relay Application")
    @doc("""
      Creates a Relay Application
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @post
    create(@body request: RelayApplicationCreateRequest):
      | {
          @statusCode statusCode: 200;
          @body relay_application: RelayApplicationResponse;
        }
      | StatusCode401
      | StatusCode404
      | RelayApplicationCreateStatusCode422
      | StatusCode500;

    @operationId("update_relay_application")
    @summary("Update Relay Application")
    @doc("""
      Updates a Relay Application by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @put
    update(
      ...RelayApplicationPathID,
      @body request: RelayApplicationUpdateRequest,
    ):
      | {
          @statusCode statusCode: 200;
          @body relay_application: RelayApplicationResponse;
        }
      | StatusCode401
      | StatusCode404
      | RelayApplicationUpdateStatusCode422
      | StatusCode500;

    @operationId("delete_relay_application")
    @summary("Delete Relay Application")
    @doc("""
      Deletes a Relay Application by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @delete
    delete(...RelayApplicationPathID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
