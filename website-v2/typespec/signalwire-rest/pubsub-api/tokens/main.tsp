import "@typespec/http";
import "@typespec/openapi";
import "../../types";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "../tags.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/tokens")
namespace PubSubAPI.Tokens {
  @tag(TOKENS_TAG)
  @friendlyName("Tokens")
  interface PubSubTokens {
    @summary("Generate a new PubSub Token")
    @doc("""
      Generate a PubSub Token to be used to authenticate clients to the PubSub Service.
      
      ${tokenPermissions<"_PubSub_">}
      """)
    @post
    @operationId("create_token")
    create(...NewPubSubToken):
      | {
          @statusCode statusCode: 200;
          @body body: PubSubToken;
        }
      | StatusCode400
      | StatusCode401
      | PubSubToken422Error
      | StatusCode500;
  }
}
