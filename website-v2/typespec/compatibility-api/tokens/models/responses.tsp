import "./core.tsp";

using TypeSpec.Http;

@doc("Response containing a single token.")
model TokenResponse {
  ...Token;
}
