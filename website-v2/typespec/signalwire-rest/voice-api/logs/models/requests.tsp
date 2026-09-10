import "@typespec/http";

using TypeSpec.Http;

@doc("Request parameters for listing voice logs")
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

  @doc("Page number to return. Requires `page_token` for values greater than 0.")
  @example(0)
  @query
  @minValue(0)
  page_number?: int32 = 0;

  @doc("Specify the number of results to return on a single page. The default page size is `50` and the maximum is `1000`.")
  @example(50)
  @query
  @minValue(1)
  @maxValue(1000)
  page_size?: int32 = 50;

  @doc("Token for cursor-based pagination. Required when `page_number` is greater than 0.")
  @example("PAb3877c40da604998")
  @query
  page_token?: string;
}
