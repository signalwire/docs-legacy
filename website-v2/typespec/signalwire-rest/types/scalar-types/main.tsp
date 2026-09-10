import "@typespec/http";

using TypeSpec.Http;

@format("uuid")
@doc("Universal Unique Identifier.")
scalar uuid extends string;

@format("jwt")
scalar jwt extends string;
