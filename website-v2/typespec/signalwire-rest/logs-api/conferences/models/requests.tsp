using TypeSpec.Http;

@doc("Query parameters for listing conference logs.")
model ConferenceLogListRequest {
  @doc("Include logs for deleted activity.")
  @example(false)
  @query
  include_deleted?: boolean;

  @doc("Return logs for activity on this date. Accepts a date (YYYY-MM-DD) or ISO 8601 timestamp.")
  @example("2025-03-11")
  @query
  created_on?: string;

  @doc("Return logs for activity prior to this date. Accepts a date (YYYY-MM-DD) or ISO 8601 timestamp.")
  @example("2025-03-12")
  @query
  created_before?: string;

  @doc("Return logs for activity after this date. Accepts a date (YYYY-MM-DD) or ISO 8601 timestamp.")
  @example("2025-03-10")
  @query
  created_after?: string;

  @doc("The page number to retrieve (0-indexed).")
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

  @doc("Token for cursor-based pagination. Required when `page_number` > 0.")
  @example("PAb3877c40da604998")
  @query
  page_token?: string;
}
