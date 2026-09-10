import "@typespec/http";

using TypeSpec.Http;

@doc("Query parameters for listing room recordings.")
model ListRoomRecordingsRequest {
  @doc("Generated media links will be valid for this many seconds. Default is 900 (15 minutes).")
  @example(900)
  @query
  @minValueExclusive(0)
  media_ttl?: int32;

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

@doc("Query parameters for listing room recording events.")
model ListRoomRecordingEventsRequest {
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
