import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "../../../types";
import "../../tags.tsp";
import "../../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/resources/call_flow/{id}/versions")
namespace FabricAPI.CallFlow.Versions {
  @tag(CALL_FLOWS_TAG)
  interface CallFlowVersions {
    @operationId("list_call_flow_versions")
    @summary("List Call Flow Versions")
    @doc("""
      Returns a list of versions of a Call Flow.
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list(...CallFlowVersionPathID):
      | CallFlowVersionListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("deploy_call_flow_version")
    @summary("Deploy a Call Flow Version")
    @doc("""
      Deploys a specific version of a Call Flow.
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @post
    deploy(
      ...CallFlowVersionPathID,
      @body request: CallFlowVersionDeployRequest,
    ):
      | {
          @statusCode statusCode: 201;
          @body response: CallFlowVersionDeployResponse;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode422
      | StatusCode500;
  }
}
