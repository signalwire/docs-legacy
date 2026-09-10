import "@typespec/http";

using TypeSpec.Http;

@doc("Request parameters for listing message logs")
model LogListRequest {
  @doc("Include logs for deleted activity.")
  @example(false)
  @query
  include_deleted?: boolean = false;

  @doc("Return logs for activity prior to this date.")
  @example("2022-04-30")
  @query
  created_before?: string;

  @doc("Return logs for activity on this date.")
  @example("2022-04-30")
  @query
  created_on?: string;

  @doc("Return logs for activity after this date.")
  @example("2022-04-30")
  @query
  created_after?: string;

  @doc("Specify the number of results to return on a single page. The default page size is `50` and the maximum is `1000`.")
  @example(20)
  @query
  @minValue(1)
  @maxValue(1000)
  page_size?: int32 = 50;

  @doc("Page number to retrieve. Requires `page_token` when greater than `0`.")
  @example(0)
  @query
  @minValue(0)
  page_number?: int32 = 0;

  @doc("Token for cursor-based pagination. Required when `page_number` is greater than `0`. The token is returned in pagination links.")
  @example("PAbff61159-faab-48b3-959a-3021a8f5beca")
  @query
  page_token?: string;
}
