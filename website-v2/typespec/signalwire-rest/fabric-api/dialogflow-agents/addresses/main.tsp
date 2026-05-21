import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/responses.tsp";
import "../../../types";
import "../../tags.tsp";
import "../../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/resources/dialogflow_agents/{id}/addresses")
namespace FabricAPI.DialogflowAgent.Addresses {
  @tag(AI_DIALOGFLOW_TAG)
  interface DialogflowAgentAddresses {
    @operationId("list_dialogflow_agent_addresses")
    @summary("List Dialogflow Agent Addresses")
    @doc("""
      This endpoint returns a list of addresses associated with a specific Dialogflow Agent.
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list(...DialogflowAgentAddressPathID):
      | DialogflowAgentAddressListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
