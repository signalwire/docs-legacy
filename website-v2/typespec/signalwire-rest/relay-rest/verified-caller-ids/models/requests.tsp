import "./core.tsp";

using TypeSpec.Http;

@doc("Request body for creating a verified caller ID.")
model CreateVerifiedCallerIDRequest {
  @doc("String representing the phone number for the caller ID. This must be a valid, routeable phone number in [E.164 format](https://en.wikipedia.org/wiki/E.164) that is able to receive a voice phone call for verification.")
  @example("+15551234567")
  number: string;

  @doc("The name portion of the caller ID. If not provided, the default will be the formatted number.")
  @example("C-3P0")
  @maxLength(200)
  name?: string;

  @doc("The extension of the phone number for the caller ID. This is only used when placing the verification call.")
  @example("1234")
  extension?: string;
}

@doc("Request body for verifying a caller ID.")
model VerifyCallerIDRequest {
  @doc("The verification code received via call or SMS.")
  @example("123456")
  verification_code: string;
}

@doc("Request body for updating a verified caller ID.")
model UpdateVerifiedCallerIDRequest {
  @doc("The name portion of the caller ID.")
  @example("C-3P0")
  @maxLength(200)
  name: string;
}
