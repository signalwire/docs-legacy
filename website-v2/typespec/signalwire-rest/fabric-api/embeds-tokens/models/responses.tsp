model EmbedsTokensResponse {
  @doc("Encrypted guest token.")
  @example("eyJhbGciOiJkaXIiLCJlbmMiOiJBMjU2R0NNIiwiY2giOiJwdWMubHZoLm1lIiwidHlwIjoiU0FUIn0..")
  @format("jwt")
  token: string;
}
