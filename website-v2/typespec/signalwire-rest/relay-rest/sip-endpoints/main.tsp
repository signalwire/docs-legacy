import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "../../types";
import "../tags.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/endpoints/sip")
namespace RelayRestAPI.SipEndpoints {
  @tag(SIP_ENDPOINTS_TAG)
  @friendlyName("SIP Endpoints")
  interface SipEndpoints {
    @operationId("list_sip_endpoints")
    @summary("List all SIP Endpoints.")
    @doc("""
      Returns a list of your SIP endpoints.
      
      ${tokenPermissions<"_Voice_">}
      """)
    list(...ListSipEndpointsQuery):
      | SipEndpointListResponse
      | StatusCode401
      | ValidationError
      | StatusCode500;

    @operationId("create_sip_endpoint")
    @summary("Create a SIP Endpoint")
    @doc("""
      Creates a new SIP endpoint.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @post
    create(@body body: CreateSipEndpointRequest):
      | SipEndpointResponse
      | StatusCode401
      | ValidationError
      | StatusCode500;

    @operationId("retrieve_sip_endpoint")
    @summary("Retrieve a SIP Endpoint")
    @doc("""
      Retrieves the details of a SIP endpoint.
      
      ${tokenPermissions<"_Voice_">}
      """)
    read(...SipEndpointPathID):
      | SipEndpointResponse
      | StatusCode401
      | StatusCode404
      | ValidationError
      | StatusCode500;

    @operationId("update_sip_endpoint")
    @summary("Update a SIP Endpoint")
    @doc("""
      Updates a SIP endpoint.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @put
    update(...SipEndpointPathID, @body body: UpdateSipEndpointRequest):
      | SipEndpointResponse
      | StatusCode401
      | StatusCode404
      | ValidationError
      | StatusCode500;

    @operationId("delete_sip_endpoint")
    @summary("Delete a SIP Endpoint")
    @doc("""
      Permanently deletes a SIP endpoint.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @delete
    delete(...SipEndpointPathID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
