import "@typespec/http";
import "@typespec/openapi";
import "../../types";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "./models/errors.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/tokens")
namespace ProjectAPI.Tokens {
  @tag(TOKENS_TAG)
  @friendlyName("Tokens")
  interface ProjectTokens {
    @operationId("create_token")
    @summary("Generate a new API Token")
    @doc("""
      Generate an API Token for a project to be used to authenticate requests within the project.
      
      ${tokenPermissions<"_Management_">}
      
      #### Token Permissions
      
      You must set the functions allowed by this API Token by selecting which types of requests this API Token is allowed to make.
      
      Valid options are: calling, chat, datasphere, fax, management, messaging, numbers, pubsub, storage, tasking, and video
      """)
    @post
    create(...CreateTokenRequest):
      | {
          @statusCode statusCode: 200;
          @body body: TokenResponse;
        }
      | StatusCode401
      | TokenStatusCode422
      | StatusCode500;

    @operationId("update_token")
    @summary("Update an API Token")
    @doc("""
      Update an API Token's name or permissions.
      
      ${tokenPermissions<"_Management_">}
      
      #### Token Permissions
      
      You can modify the functions allowed by this API Token by selecting which types of requests this API Token is allowed to make.
      
      Valid options are: calling, chat, datasphere, fax, management, messaging, numbers, pubsub, storage, tasking, and video
      """)
    @patch(#{ implicitOptionality: true })
    update(
      @path
      @format("uuid")
      @doc("The unique identifier of the token to update.")
      @example("ea14556a-984f-11ee-b9d1-0242ac120002")
      token_id: string,

      ...UpdateTokenRequest,
    ):
      | {
          @statusCode statusCode: 200;
          @body body: TokenResponse;
        }
      | StatusCode401
      | StatusCode404
      | TokenStatusCode422
      | StatusCode500;

    @operationId("delete_token")
    @summary("Delete an API Token")
    @doc("""
      Delete an API Token. This action cannot be undone.
      
      ${tokenPermissions<"_Management_">}
      """)
    @delete
    delete(
      @path
      @format("uuid")
      @doc("The unique identifier of the token that you want to delete.")
      @example("ea14556a-984f-11ee-b9d1-0242ac120002")
      token_id: string,
    ):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
