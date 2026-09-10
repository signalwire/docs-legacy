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

@route("/resources/freeswitch_connectors")
namespace FabricAPI.FreeswitchConnectors {
  @tag(FREESWITCH_CONNECTOR_TAG)
  @friendlyName("FreeSWITCH Connectors")
  interface FreeswitchConnectors {
    @operationId("list_freeswitch_connectors")
    @summary("List FreeSWITCH Connectors")
    @doc("""
      A list of FreeSWITCH Connectors
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list():
      | FreeswitchConnectorListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("get_freeswitch_connector")
    @summary("Get FreeSWITCH Connector")
    @doc("""
      Returns a FreeSWITCH Connector by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    read(...FreeswitchConnectorPathID):
      | {
          @statusCode statusCode: 200;
          @body freeswitch_connector: FreeswitchConnectorResponse;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("create_freeswitch_connector")
    @summary("Create FreeSWITCH Connector")
    @doc("""
      Creates a FreeSWITCH Connector
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @post
    create(@body request: FreeswitchConnectorCreateRequest):
      | {
          @statusCode statusCode: 200;
          @body freeswitch_connector: FreeswitchConnectorResponse;
        }
      | StatusCode401
      | StatusCode404
      | FreeswitchConnectorCreateStatusCode422
      | StatusCode500;

    @operationId("update_freeswitch_connector")
    @summary("Update FreeSWITCH Connector")
    @doc("""
      Updates a FreeSWITCH Connector by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @put
    update(
      ...FreeswitchConnectorPathID,
      @body request: FreeswitchConnectorUpdateRequest,
    ):
      | {
          @statusCode statusCode: 200;
          @body freeswitch_connector: FreeswitchConnectorResponse;
        }
      | StatusCode401
      | StatusCode404
      | FreeswitchConnectorUpdateStatusCode422
      | StatusCode500;

    @operationId("delete_freeswitch_connector")
    @summary("Delete FreeSWITCH Connector")
    @doc("""
      Deletes a FreeSWITCH Connector by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @delete
    delete(...FreeswitchConnectorPathID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
