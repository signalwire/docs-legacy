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

@route("/subscribers/tokens/refresh")
namespace FabricAPI.SubscriberRefreshTokens {
  @tag(SUBSCRIBERS_TOKENS_TAG)
  @friendlyName("Refresh Token")
  interface RefreshTokens {
    @operationId("refresh_subscriber_token")
    @summary("Exchange a refresh token for a new subscriber access token")
    @doc("""
      Exchanges a valid refresh token for a new subscriber access token and a new refresh token. The new access token is valid for 2 hours, and the new refresh token is valid for 2 hours and 5 minutes.
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @post
    create(...SubscriberRefreshTokenRequest):
      | {
          @statusCode statusCode: 201;
          @body subscriber_refresh_token: SubscriberRefreshTokenResponse;
        }
      | StatusCode401
      | StatusCode404
      | RefreshTokenStatusCode422
      | StatusCode500;
  }
}
