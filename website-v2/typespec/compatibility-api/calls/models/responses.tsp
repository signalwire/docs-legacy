import "./core.tsp";
import "../../_shared/pagination.tsp";

using TypeSpec.Http;

@doc("Response containing a list of calls.")
model CallListResponse {
  @doc("The URI of the current page.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Calls?Page=0&PageSize=50")
  uri: string;

  @doc("The URI of the first page.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Calls?Page=0&PageSize=50")
  first_page_uri: string;

  @doc("The URI of the next page.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Calls?Page=1&PageSize=50&PageToken=PAxxxxxxxxxx")
  next_page_uri: string | null;

  @doc("The URI of the previous page.")
  @example(null)
  previous_page_uri: string | null;

  @doc("The current page number.")
  @example(0)
  page: int32;

  @doc("The number of items per page.")
  @example(50)
  page_size: int32;

  @doc("List of calls.")
  calls: Call[];
}

@doc("Response containing a single call.")
model CallResponse {
  ...Call;
}

@doc("Response containing a single call recording.")
model CallRecordingResponse {
  ...CallRecording;
}

@doc("Response containing a single call stream.")
model CallStreamResponse {
  ...CallStream;
}
