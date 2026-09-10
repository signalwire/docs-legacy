import "./core.tsp";

using TypeSpec.Http;

@doc("Response containing a list of transcriptions.")
model TranscriptionListResponse {
  @doc("The URI of the current page.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472ac/Transcriptions?Page=0&PageSize=50")
  uri: string;

  @doc("The URI of the first page.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472ac/Transcriptions")
  first_page_uri: string;

  @doc("The URI of the next page. Null if there are no more pages.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472ac/Transcriptions?Page=1&PageSize=50&PageToken=PAb3877c40-da60-4998-90ad-b792e98472tr")
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

  @doc("List of transcriptions.")
  transcriptions: Transcription[];
}

@doc("Response containing a single transcription.")
model TranscriptionResponse {
  ...Transcription;
}
