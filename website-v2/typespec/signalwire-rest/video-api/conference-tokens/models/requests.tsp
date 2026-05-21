import "@typespec/http";

using TypeSpec.Http;

@doc("Query parameters for listing conference tokens.")
model ListConferenceTokensRequest {
  @query
  @doc("Page number to return. Requires `page_token` for values greater than 0.")
  @example(0)
  @minValue(0)
  page_number?: int32 = 0;

  @query
  @doc("Specify the number of results to return on a single page. The default page size is `50` and the maximum is `1000`.")
  @example(50)
  @minValue(1)
  @maxValue(1000)
  page_size?: int32 = 50;

  @query
  @doc("Token for cursor-based pagination. Required when `page_number` is greater than 0.")
  @example("PAb3877c40da604998")
  page_token?: string;
}
