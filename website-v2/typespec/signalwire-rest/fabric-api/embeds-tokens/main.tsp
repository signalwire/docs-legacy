// Import necessary modules or types
import "@typespec/http";
import "@typespec/openapi";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "./models/errors.tsp";
import "../tags.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

// Define the API path for embeds
@useAuth({
  type: Http.AuthType.noAuth,
})
@route("/embeds/tokens")
@server("https://embeds.signalwire.com/api/fabric", "Embeds Endpoint")
namespace FabricAPI.EmbedsTokens {
  @tag(EMBEDS_TOKENS_TAG)
  @friendlyName("Embeds Tokens")
  interface EmbedsTokens {
    @operationId("create_embeds_token")
    @summary("Create Embeds Tokens")
    @doc("""
      Exchanges a public Click-to-Call (C2C) token for a short-lived, private embed guest token used to authorize a call. This allows secure activation of the C2C widget without exposing sensitive credentials.
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @post
    create(@body body: EmbedsTokensRequest):
      | {
          @statusCode statusCode: 201;
          @body subscriber: EmbedsTokensResponse;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode403
      | EmbedTokenCreateStatusCode422
      | StatusCode500;
  }
}
