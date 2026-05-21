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

@route("/resources/dialogflow_agents")
namespace FabricAPI.DialogflowAgents {
  @tag(AI_DIALOGFLOW_TAG)
  interface DialogflowAgents {
    @operationId("list_dialogflow_agents")
    @summary("List Dialogflow Agents")
    @doc("""
      A list of Dialogflow Agents
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list():
      | DialogflowAgentListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("get_dialogflow_agent")
    @summary("Get Dialogflow Agent")
    @doc("""
      Returns a Dialogflow Agent by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    read(...DialogflowAgentPathID):
      | {
          @statusCode statusCode: 200;
          @body dialogflow_agent: DialogflowAgentResponse;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("update_dialogflow_agent")
    @summary("Update Dialogflow Agent")
    @doc("""
      Updates a Dialogflow Agent by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @put
    update(
      ...DialogflowAgentPathID,
      @body request: DialogflowAgentUpdateRequest,
    ):
      | {
          @statusCode statusCode: 200;
          @body dialogflow_agent: DialogflowAgentResponse;
        }
      | StatusCode401
      | StatusCode404
      | DialogflowAgentUpdateStatusCode422
      | StatusCode500;

    @operationId("delete_dialogflow_agent")
    @summary("Delete Dialogflow Agent")
    @doc("""
      Deletes a Dialogflow Agent by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @delete
    delete(...DialogflowAgentPathID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
