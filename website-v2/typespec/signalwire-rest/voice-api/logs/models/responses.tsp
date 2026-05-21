import "@typespec/http";
import "./core.tsp";

using TypeSpec.Http;

@doc("Pagination links for voice log list responses")
model LogPaginationResponse {
  @doc("URL of the current page.")
  @example("https://example.signalwire.com/api/voice/logs?page_number=0&page_size=50")
  self: string;

  @doc("URL of the first page.")
  @example("https://example.signalwire.com/api/voice/logs?page_size=50")
  first: string;

  @doc("URL of the next page. Absent on the last page.")
  @example("https://example.signalwire.com/api/voice/logs?page_number=1&page_size=50&page_token=PA2fa20774-64a1-41d3-a88a-1c61f563d0e7")
  next?: string;

  @doc("URL of the previous page. Absent on the first page.")
  @example("https://example.signalwire.com/api/voice/logs?page_number=0&page_size=50&page_token=PA2fa20774-64a1-41d3-a88a-1c61f563d0e7")
  prev?: string;
}

@doc("Response model for voice log list endpoint")
model LogListResponse {
  @doc("Pagination links")
  links: LogPaginationResponse;

  @doc("Array of voice log entries")
  data: VoiceLog[];
}

@doc("Response model for voice log retrieve endpoint")
model LogRetrieveResponse {
  @statusCode statusCode: 200;
  @body body: VoiceLog;
}

@doc("Response model for log events list endpoint")
model LogEventsListResponse {
  @doc("Array of event entries for the log")
  data: LogEvent[];
}
