import "@typespec/http";
import "@typespec/openapi";
import "../../../types";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "./models/errors.tsp";
import "../../tags.tsp";
import "../../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/subscribers/tokens")
namespace FabricAPI.SubscriberTokens {
  @tag(SUBSCRIBERS_TAG)
  interface SubscriberTokens {
    @operationId("create_subscriber_token")
    @summary("Create Subscriber Token")
    @doc("""
      Create a Subscriber Token
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    create(...SubscriberTokenRequest):
      | SubscriberTokenResponse
      | StatusCode401
      | StatusCode404
      | SubscriberTokenStatusCode422
      | StatusCode500;
  }
}
