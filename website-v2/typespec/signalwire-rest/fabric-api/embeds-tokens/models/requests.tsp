import "@typespec/http";

using TypeSpec.Http;

model EmbedsTokensRequest {
  @doc("Click to Call Token")
  @example("c2c_7acc0e5e968706a032983cd80cdca219")
  token: string;
}
