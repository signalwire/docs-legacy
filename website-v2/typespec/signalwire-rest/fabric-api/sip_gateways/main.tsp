import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "./models/errors.tsp";
import "../../types";
import "./addresses";
import "../tags.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/resources/sip_gateways")
namespace FabricAPI.SipGateways {
  @tag(SIP_GATEWAY_TAG)
  @friendlyName("SIP Gateway")
  interface SipGateways {
    @operationId("list_sip_gateways")
    @summary("List SIP Gateways")
    @doc("""
      Returns a paginated list of SIP Gateways for the authenticated project.
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list():
      | SipGatewayListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("get_sip_gateway")
    @summary("Get SIP Gateway")
    @doc("""
      Returns an SIP Gateway by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    read(...SipGatewayID):
      | {
          @statusCode statusCode: 200;
          @body sip_gateway: SipGatewayResponse;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("create_sip_gateway")
    @summary("Create SIP Gateway")
    @doc("""
      Creates a SIP Gateway that can be used to dial external SIP entities.
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @post
    create(...SipGatewayRequest):
      | {
          @statusCode statusCode: 201;
          @body sip_gateway: SipGatewayResponse;
        }
      | StatusCode401
      | StatusCode404
      | SipGatewayCreateStatusCode422
      | StatusCode500;

    @operationId("update_sip_gateway")
    @summary("Update SIP Gateway")
    @doc("""
      Updates a SIP Gateway by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @patch(#{ implicitOptionality: true })
    update(...SipGatewayID, ...SipGatewayRequest):
      | {
          @statusCode statusCode: 200;
          @body sip_gateway: SipGatewayResponse;
        }
      | StatusCode401
      | StatusCode404
      | SipGatewayCreateStatusCode422
      | StatusCode500;

    @operationId("delete_sip_gateway")
    @summary("Delete SIP Gateway")
    @doc("""
      Deletes a SIP Gateway by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @delete
    delete(...SipGatewayID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
