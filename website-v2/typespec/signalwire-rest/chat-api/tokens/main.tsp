import "@typespec/http";
import "@typespec/openapi";
import "../../types";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/tokens")
namespace ChatAPI.Tokens {
  @tag(TOKENS_TAG)
  @friendlyName("Tokens")
  interface ChatTokens {
    @operationId("create_chat_token")
    @summary("Generate a new Chat Token")
    @doc("""
      Generate a Chat Token to be used to authenticate clients to the Chat Service.
      
      ${tokenPermissions<"_Chat_">}
      """)
    create(...NewChatToken):
      | {
          @statusCode statusCode: 200;
          @body body: ChatToken;
        }
      | StatusCode400
      | StatusCode401
      | ChatToken422Error;
  }
}
