// Import necessary modules or types
import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./subscriber-sip-endpoint";
import "./subscriber-addresses";
import "./subscriber-tokens";
import "./guest-tokens";
import "./invite-tokens";
import "./refresh-tokens";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "./models/errors.tsp";
import "../tags.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

// Define the API path for subscribers
@route("/resources/subscribers")
namespace FabricAPI.Subscribers {
  @tag(SUBSCRIBERS_TAG)
  @friendlyName("Subscribers")
  interface Subscribers {
    @operationId("list_subscribers")
    @summary("List Subscribers")
    @doc("""
      Retrieve a list of all subscribers
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list():
      | SubscriberListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("create_subscriber")
    @summary("Create Subscriber")
    @doc("""
      Create a new Subscriber
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @post
    create(@body body: SubscriberRequest):
      | {
          @statusCode statusCode: 201;
          @body subscriber: SubscriberResponse;
        }
      | StatusCode401
      | StatusCode404
      | SubscriberCreateStatusCode422
      | StatusCode500;

    @operationId("get_subscriber")
    @summary("Get Subscriber")
    @doc("""
      Fetch an existing Subscriber
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    get(...SubscriberPathID):
      | {
          @statusCode statusCode: 200;
          @body body: SubscriberResponse;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("update_subscriber")
    @summary("Update Subscriber")
    @doc("""
      Update an existing Subsriber
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @put
    update(...SubscriberPathID, ...SubscriberRequest):
      | {
          @statusCode statusCode: 200;
          @body body: SubscriberResponse;
        }
      | StatusCode401
      | StatusCode404
      | SubscriberUpdateStatusCode422
      | StatusCode500;

    @operationId("delete_subscriber")
    @summary("Delete Subscriber")
    @doc("""
      Delete an existing Subscriber
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @delete
    delete(...SubscriberPathID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
