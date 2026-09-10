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

@route("/resources/ai_agents/{ai_agent_id}/addresses")
namespace FabricAPI.AIAgent.Addresses {
  @tag(AI_CUSTOM_TAG)
  interface AIAgentAddresses {
    @operationId("list_ai_agent_addresses")
    @summary("List AI Agent Addresses")
    @doc("""
      This endpoint returns a list of addresses associated with a specific AI Agent.
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list(...AIAgentIDPath):
      | AIAgentAddressListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
