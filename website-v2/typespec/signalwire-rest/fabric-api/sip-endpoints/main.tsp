import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "./models/errors.tsp";
import "./addresses";
import "./resource";
import "../../types";
import "../tags.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/resources/sip_endpoints")
namespace FabricAPI.SipEndpoints {
  @tag(SIP_ENDPOINTS_TAG)
  @friendlyName("SIP Endpoints")
  @doc("SIP Endpoints API category.")
  interface SipEndpoints {
    @operationId("list_sip_endpoints")
    @summary("List SIP Endpoints")
    @doc("""
      A list of SIP Endpoints
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list():
      | SipEndpointListResponse[]
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("get_sip_endpoint")
    @summary("Get SIP Endpoint")
    @doc("""
      Returns a SIP Endpoint by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    read(...SipEndpointPathID):
      | {
          @statusCode statusCode: 200;
          @body sip_endpoint: SipEndpointResponse;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("create_sip_endpoint")
    @summary("Create SIP Endpoint")
    @doc("""
      Creates a SIP Endpoint
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @post
    create(@body request: SipEndpointCreateRequest):
      | {
          @statusCode statusCode: 200;
          @body sip_endpoint: SipEndpointResponse;
        }
      | StatusCode401
      | StatusCode404
      | ResourceSipEndpointCreateStatusCode422
      | StatusCode500;

    @operationId("update_sip_endpoint")
    @summary("Update SIP Endpoint")
    @doc("""
      Updates a SIP Endpoint by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @put
    update(...SipEndpointPathID, @body request: SipEndpointUpdateRequest):
      | {
          @statusCode statusCode: 200;
          @body sip_endpoint: SipEndpointResponse;
        }
      | StatusCode401
      | StatusCode404
      | ResourceSipEndpointUpdateStatusCode422
      | StatusCode500;

    @operationId("delete_sip_endpoint")
    @summary("Delete SIP Endpoint")
    @doc("""
      Deletes a SIP Endpoint by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @delete
    delete(...SipEndpointPathID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
