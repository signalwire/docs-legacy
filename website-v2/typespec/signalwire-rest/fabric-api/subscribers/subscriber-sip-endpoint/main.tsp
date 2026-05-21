import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "./models/errors.tsp";
import "../../../types";
import "../../tags.tsp";
import "../../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/{fabric_subscriber_id}/sip_endpoints")
namespace FabricAPI.Subscribers.SipEndpoints {
  @tag(SUBSCRIBER_SIP_ENDPOINT_TAG)
  @friendlyName("SIP Endpoints")
  interface SubscriberSipEndpoint {
    @operationId("list_subscriber_sip_endpoints")
    @summary("List Subscriber SIP Endpoints")
    @doc("""
      A list of Sip Endpoints of the Subscriber
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list(...FabricSubscriberID):
      | SubscriberSipEndpointListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("get_subscriber_sip_endpoint")
    @summary("Get Subscriber SIP Endpoint")
    @doc("""
      Returns a Subscriber Sip Endpoint by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    read(...SIPEndpointID, ...FabricSubscriberID):
      | {
          @statusCode statusCode: 200;
          @body subscriber_sip_endpoint: SubscriberSIPEndpoint;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("create_subscriber_sip_endpoint")
    @summary("Create Subscriber SIP Endpoint")
    @doc("""
      Creates a Subscriber Sip Endpoint
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @post
    create(...FabricSubscriberID, @body body: SubscriberSipEndpointRequest):
      | {
          @statusCode statusCode: 201;
          @body subscriber_sip_endpoint: SubscriberSIPEndpoint;
        }
      | StatusCode401
      | StatusCode404
      | SipEndpointCreateStatusCode422
      | StatusCode500;

    @operationId("update_subscriber_sip_endpoint")
    @summary("Update Subscriber SIP Endpoint")
    @doc("""
      Updates a Subscriber Sip Endpoint by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @patch(#{ implicitOptionality: true })
    update(
      ...SIPEndpointID,
      ...FabricSubscriberID,
      @body body: SubscriberSipEndpointRequest,
    ):
      | {
          @statusCode statusCode: 200;
          @body subscriber_sip_endpoint: SubscriberSIPEndpoint;
        }
      | StatusCode401
      | StatusCode404
      | SipEndpointUpdateStatusCode422
      | StatusCode500;

    @operationId("delete_subscriber_sip_endpoint")
    @summary("Delete Subscriber SIP Endpoint")
    @doc("""
      Deletes a Subscriber Sip Endpoint by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @delete
    delete(...SIPEndpointID, ...FabricSubscriberID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
