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

@route("/resources/{id}/domain_applications")
namespace FabricAPI.DomainApplications {
  @tag(DOMAIN_APPLICATIONS_TAG)
  interface DomainApplications {
    @operationId("assign_resource_domain_application")
    @summary("Assign a resource as a call handler for a Domain Application.")
    @doc("""
      This endpoint assigns a specific resource to a Domain Application, allowing inbound calls to be handled by the resource.
      <Note>
      Currently only supports `calling` as a handler and automatically defaults to it.
      </Note>
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @post
    assign(
      ...DomainApplicationPathID,
      @body request: DomainApplicationAssignRequest,
    ):
      | {
          @statusCode statusCode: 200;
          @body domain_application: DomainApplicationResponse;
        }
      | StatusCode401
      | StatusCode404
      | DomainApplicationCreateStatusCode422
      | StatusCode500;
  }
}
