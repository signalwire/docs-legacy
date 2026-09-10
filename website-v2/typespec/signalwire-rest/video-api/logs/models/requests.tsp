import "@typespec/http";

using TypeSpec.Http;

@doc("Query parameters for listing logs.")
model ListLogsRequest {
  @query
  @doc("Include logs for deleted activity.")
  @example(false)
  include_deleted?: boolean = false;

  @query
  @doc("Return logs for activity prior to this date. Accepts date (YYYY-MM-DD) or ISO 8601 datetime formats.")
  @example("2022-04-30")
  created_before?: string;

  @query
  @doc("Return logs for activity on this date. Accepts date (YYYY-MM-DD) or ISO 8601 datetime formats.")
  @example("2022-04-30")
  created_on?: string;

  @query
  @doc("Return logs for activity after this date. Accepts date (YYYY-MM-DD) or ISO 8601 datetime formats.")
  @example("2022-04-30")
  created_after?: string;

  @query
  @doc("Page number to return.")
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
  @doc("Token for cursor-based pagination.")
  @example("PAb3877c40da604998")
  page_token?: string;
}
