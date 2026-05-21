import "../../../types";

using TypeSpec.Http;
using Types;

model MfaRequestIdPath {
  @doc("The MFA request ID.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  mfa_request_id: uuid;
}

@doc("MFA request model.")
model MfaRequest {
  @doc("The E164 number to use as the destination.")
  @example("+14043287382")
  to: string;

  @doc("The E164 number from your account to use as the origin of the message. SignalWire will use a special verified number if not specified.")
  @example("+12029167968")
  from?: string;

  @doc("Specify a custom message to send before the token. The message must fit within one segment; either 160 characters or 70 characters when using non-GSM symbols.")
  @example("Here is your code")
  message?: string = "Your Personal Authorization Code is:";

  @doc("The number of characters in the token, from 4 to 20. Defaults to 6.")
  @example(6)
  token_length?: int32 = 6;

  @doc("The number of seconds the token is considered valid for. Defaults to 3600, with a maximum of 604800.")
  @example(3600)
  valid_for?: int32 = 3600;

  @doc("The number of allowed verification attempts, including the first one, from 1 to 20. Defaults to 3.")
  @example(3)
  max_attempts?: int32 = 3;

  @doc("Set to true or false, whether to include letters or just numbers in the token. Defaults to false (numbers only).")
  @example(false)
  allow_alphas?: boolean = false;
}

@doc("MFA response model.")
model MfaResponse {
  @doc("The MFA request ID. Save this for verification.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  id: uuid;

  @doc("Whether the request was successfully queued.")
  @example(true)
  success: boolean;

  @doc("The destination of the MFA request.")
  @example("+15554422333")
  to: string;

  @doc("Can be sms for a text message or call for a phone call.")
  @example("call")
  channel: string;
}

@doc("MFA verification request model.")
model MfaVerifyRequest {
  @doc("The token to verify.")
  @example("123456")
  token: string;
}

@doc("MFA verification response model.")
model MfaVerifyResponse {
  @doc("Whether the token was successfully verified by the API. When `max_attempts` are reached or the request is no longer valid, the endpoint will return a `404 Not Found`.")
  @example(true)
  success: boolean;
}
