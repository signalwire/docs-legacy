import "./core.tsp";

@doc("Pagination links for conference log list responses.")
model ConferenceLogPaginationLinks {
  @doc("Link to the current page.")
  @example("https://example.signalwire.com/api/logs/conferences?page_number=0&page_size=50")
  self: string;

  @doc("Link to the first page.")
  @example("https://example.signalwire.com/api/logs/conferences?page_size=50")
  first: string;

  @doc("Link to the next page. Only present when there are more results.")
  @example("https://example.signalwire.com/api/logs/conferences?page_number=1&page_size=50&page_token=PAb9028451-b1d3-4690-b5d3-37b19d25f573")
  next?: string;

  @doc("Link to the previous page. Only present when not on the first page.")
  @example("https://example.signalwire.com/api/logs/conferences?page_number=0&page_size=50&page_token=PBb9028451-b1d3-4690-b5d3-37b19d25f573")
  prev?: string;
}

@doc("Response containing a list of conferences.")
model ConferencesResponse {
  @doc("Pagination links.")
  links: ConferenceLogPaginationLinks;

  @doc("A list of conference logs.")
  data: (CxmlConference | RelayConference | VideoRoomSessionConference)[];
}
