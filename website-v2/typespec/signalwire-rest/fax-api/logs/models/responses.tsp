import "./core.tsp";

model LogResponse {
  ...FaxLog;
}

model LogListResponse {
  @doc("Object containing pagination links")
  links: LogPaginationResponse;

  @doc("Array of log data")
  data: FaxLog[];
}

model LogPaginationResponse {
  @doc("URL for the current page of results.")
  @example("https://example.signalwire.com/api/fax/logs?page_number=0&page_size=50")
  self: string;

  @doc("URL for the first page of results.")
  @example("https://example.signalwire.com/api/fax/logs?page_size=50")
  first: string;

  @doc("URL for the next page of results. Only present when more results are available.")
  @example("https://example.signalwire.com/api/fax/logs?page_number=1&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca")
  next?: string;

  @doc("URL for the previous page of results. Only present when on page 1 or later.")
  @example("https://example.signalwire.com/api/fax/logs?page_number=0&page_size=50&page_token=PBbff61159-faab-48b3-959a-3021a8f5beca")
  prev?: string;
}
