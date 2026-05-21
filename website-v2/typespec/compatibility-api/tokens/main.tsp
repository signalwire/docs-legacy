import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "../_shared/errors.tsp";
import "../tags.tsp";
import "../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@route("/Accounts/{AccountSid}/tokens")
namespace CompatibilityAPI.Tokens {
  @tag(TOKENS_TAG)
  @friendlyName("Tokens")
  interface Tokens {
    @operationId("create_token")
    @summary("Generate a new API Token")
    @doc("""
      Generate an API Token for a project to be used to authenticate requests within the project.
      
      ${tokenPermissions<"_Management_">}
      """)
    @post
    create(
      ...TokensAccountSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: CreateTokenRequest,
    ):
      | TokenResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422Token;

    @operationId("update_token")
    @summary("Update an API Token")
    @doc("""
      Update an API Token's name or permissions.
      
      ${tokenPermissions<"_Management_">}
      """)
    @patch(#{ implicitOptionality: true })
    @route("/{token_id}")
    update(
      ...TokensAccountSidPath,
      ...TokenIdPath,
      @header contentType: "application/json",
      @body body: UpdateTokenRequest,
    ):
      | TokenResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422Token;

    @operationId("delete_token")
    @summary("Delete an API Token")
    @doc("""
      Delete an API Token. This action cannot be undone.
      
      ${tokenPermissions<"_Management_">}
      """)
    @delete
    @route("/{token_id}")
    delete(...TokensAccountSidPath, ...TokenIdPath):
      | CompatibilityStatusCode204
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404;
  }
}
