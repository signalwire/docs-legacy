import "@typespec/http";
import "@typespec/openapi";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "./models/errors.tsp";
import "../../../types";
import "../../tags.tsp";
import "../../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/subscriber/invites")
namespace FabricAPI.SubscriberInviteTokens {
  @tag(SUBSCRIBERS_TOKENS_TAG)
  @friendlyName("Invite Token")
  interface InviteTokens {
    @operationId("create_subscriber_invite_token")
    @summary("Create a Subscriber Invite Token")
    @doc("""
      Creates a Subscriber Invite Token to be used for client-side API calls. The token is authorized using a subscriber's SAT (Subscriber Access Token)
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @post
    create(...SubscriberInviteTokenCreateRequest):
      | {
          @statusCode statusCode: 201;
          @body subscriber_invite_token: SubscriberInviteTokenCreateResponse;
        }
      | StatusCode401
      | StatusCode404
      | InviteTokenCreateStatusCode422
      | StatusCode500;
  }
}
