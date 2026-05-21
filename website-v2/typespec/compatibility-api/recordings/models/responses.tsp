import "./core.tsp";

using TypeSpec.Http;

@doc("Response containing a list of recordings.")
model RecordingListResponse {
  @doc("The URI of the current page.")
  @example("/api/laml/2010-04-01/Accounts/720796a0-8ee9-4350-83bd-2d07a3121f1e/Recordings?Page=0&PageSize=50")
  uri: string;

  @doc("The URI of the first page.")
  @example("/api/laml/2010-04-01/Accounts/720796a0-8ee9-4350-83bd-2d07a3121f1e/Recordings")
  first_page_uri: string;

  @doc("The URI of the next page. Null if there are no more pages.")
  @example("/api/laml/2010-04-01/Accounts/720796a0-8ee9-4350-83bd-2d07a3121f1e/Recordings?Page=1&PageSize=50&PageToken=PA19e436af-5688-4307-b03b-bdb2b42b8142")
  next_page_uri: string | null;

  @doc("The URI of the previous page. Null if this is the first page.")
  @example(null)
  previous_page_uri: string | null;

  @doc("The current page number (zero-indexed).")
  @example(0)
  page: int32;

  @doc("The number of items per page.")
  @example(50)
  page_size: int32;

  @doc("List of recordings.")
  recordings: Recording[];
}

@doc("Response containing a single recording.")
model RecordingResponse {
  ...Recording;
}
