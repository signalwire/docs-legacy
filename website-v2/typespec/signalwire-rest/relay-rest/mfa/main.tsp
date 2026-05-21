import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "../../types";
import "../tags.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/mfa")
namespace RelayRestAPI.Mfa {
  @tag(MFA_TAG)
  @friendlyName("Multi-Factor Authentication")
  interface Mfa {
    @operationId("request_mfa_sms")
    @summary("Request a MFA token via text message")
    @doc("""
      Sends a multi-factor authentication code via SMS.
      
      ${tokenPermissions<"_Management_">}
      """)
    @route("/sms")
    @post
    sendSms(@body body: MfaRequest):
      | MfaResponse
      | StatusCode401
      | ValidationError
      | StatusCode500;

    @operationId("request_mfa_call")
    @summary("Request a MFA token via phone call")
    @doc("""
      Sends a multi-factor authentication code via voice call.
      
      ${tokenPermissions<"_Management_">}
      """)
    @route("/call")
    @post
    sendCall(@body body: MfaRequest):
      | MfaResponse
      | StatusCode401
      | ValidationError
      | StatusCode500;

    @operationId("verify_mfa_token")
    @summary("Verify a token")
    @doc("""
      Verifies a multi-factor authentication code.
      
      ${tokenPermissions<"_Management_">}
      """)
    @route("/{mfa_request_id}/verify")
    @post
    verify(...MfaRequestIdPath, @body body: MfaVerifyRequest):
      | MfaVerifyResponse
      | StatusCode401
      | ValidationError
      | StatusCode500;
  }
}
