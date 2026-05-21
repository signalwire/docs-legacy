import "./core.tsp";

model LogPaginationResponse {
  @doc("URL to current page")
  @example("https://example.signalwire.com/api/messaging/logs?page_number=0&page_size=50")
  self: string;

  @doc("URL to first page")
  @example("https://example.signalwire.com/api/messaging/logs?page_size=50")
  first: string;

  @doc("URL to next page (if available)")
  @example("https://example.signalwire.com/api/messaging/logs?page_number=1&page_size=50&page_token=PA6ad4c839-9329-43fe-83c6-fbe7c38583ff")
  next?: string;

  @doc("URL to previous page (if available)")
  @example("https://example.signalwire.com/api/messaging/logs?page_number=0&page_size=50&page_token=PA6ad4c839-9329-43fe-83c6-fbe7c38583ff")
  prev?: string;
}

model LogListResponse {
  @doc("Object containing pagination links")
  links: LogPaginationResponse;

  @doc("Array of message log entries")
  data: MessageLog[];
}

@doc("Response model for message log retrieve endpoint")
model LogRetrieveResponse is MessageLog;
