import "./core.tsp";

@doc("Response containing a list of conferences.")
model ConferenceListResponse {
  @doc("The URI of the current page.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Conferences?PageToken=PA1234")
  uri: string;

  @doc("The URI of the first page.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Conferences")
  first_page_uri: string;

  @doc("The URI of the next page.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Conferences?Page=1&PageToken=PA5678")
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

  @doc("List of conferences.")
  conferences: Conference[];
}

@doc("Response containing a single conference.")
model ConferenceResponse {
  ...Conference;
}

@doc("Response containing a list of conference participants.")
model ConferenceParticipantListResponse {
  @doc("The URI of the current page.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Conferences/b3877c40-da60-4998-90ad-b792e98472cf/Participants?PageToken=PA1234")
  uri: string;

  @doc("The URI of the first page.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Conferences/b3877c40-da60-4998-90ad-b792e98472cf/Participants")
  first_page_uri: string;

  @doc("The URI of the next page.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Conferences/b3877c40-da60-4998-90ad-b792e98472cf/Participants?Page=1&PageToken=PA5678")
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

  @doc("List of participants.")
  participants: ConferenceParticipant[];
}

@doc("Response containing a single conference participant.")
model ConferenceParticipantResponse {
  ...ConferenceParticipant;
}

@doc("Response containing a single conference stream.")
model ConferenceStreamResponse {
  ...ConferenceStream;
}

@doc("Response containing a list of conference recordings.")
model ConferenceRecordingListResponse {
  @doc("The URI of the current page.")
  @example("/api/laml/2010-04-01/Accounts/720796a0-8ee9-4350-83bd-2d07a3121f1e/Conferences/43bb71ee-553f-4074-bb20-8e2747647cce/Recordings?PageToken=PA1234")
  uri: string;

  @doc("The URI of the first page.")
  @example("/api/laml/2010-04-01/Accounts/720796a0-8ee9-4350-83bd-2d07a3121f1e/Conferences/43bb71ee-553f-4074-bb20-8e2747647cce/Recordings")
  first_page_uri: string;

  @doc("The URI of the next page.")
  @example("/api/laml/2010-04-01/Accounts/720796a0-8ee9-4350-83bd-2d07a3121f1e/Conferences/43bb71ee-553f-4074-bb20-8e2747647cce/Recordings?Page=1&PageToken=PA5678")
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

  @doc("List of recordings.")
  recordings: ConferenceRecording[];
}

@doc("Response containing a single conference recording.")
model ConferenceRecordingResponse {
  ...ConferenceRecording;
}
