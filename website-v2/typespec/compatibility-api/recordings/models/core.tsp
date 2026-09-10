using TypeSpec.Http;

model RecordingsAccountSidPath {
  @doc("The unique identifier for the account that is associated with this recording.")
  @example("720796a0-8ee9-4350-83bd-2d07a3121f1e")
  @format("uuid")
  @path
  AccountSid: string;
}

model RecordingSidPath {
  @doc("The unique identifier for the recording.")
  @example("19e436af-5688-4307-b03b-bdb2b42b8142")
  @format("uuid")
  @path
  Sid: string;
}

@doc("Recording source.")
enum RecordingSource {
  DialVerb: "DialVerb",
  Conference: "Conference",
  OutBoundApi: "OutBoundApi",
  Trunking: "Trunking",
  RecordVerb: "RecordVerb",
  StartCallRecordingApi: "StartCallRecordingApi",
  StartConferenceRecording: "StartConferenceRecording",
}

@doc("Recording status.")
enum RecordingStatus {
  Queued: "queued",
  InProgress: "in-progress",
  Paused: "paused",
  Resumed: "resumed",
  Completed: "completed",
  Absent: "absent",
  Stopped: "stopped",
}

@doc("Recording subresource URIs.")
model RecordingSubresourceUris {
  @doc("The URI for transcriptions.")
  @example("/api/laml/2010-04-01/Accounts/720796a0-8ee9-4350-83bd-2d07a3121f1e/Recordings/19e436af-5688-4307-b03b-bdb2b42b8142/Transcriptions.json")
  transcriptions: string;
}

@doc("Recording model.")
model Recording {
  @doc("The unique identifier for the recording.")
  @format("uuid")
  @example("19e436af-5688-4307-b03b-bdb2b42b8142")
  sid: string;

  @doc("The unique identifier for the account that is associated with this recording.")
  @format("uuid")
  @example("720796a0-8ee9-4350-83bd-2d07a3121f1e")
  account_sid: string;

  @doc("The version of the SignalWire API.")
  @example("2010-04-01")
  api_version: string;

  @doc("The unique identifier for the call that is associated with this recording. Null if this is a conference recording.")
  @format("uuid")
  @example("43bb71ee-553f-4074-bb20-8e2747647cce")
  call_sid: string | null;

  @doc("The unique identifier for the conference that is associated with this recording. Null if this is a call recording.")
  @format("uuid")
  @example(null)
  conference_sid: string | null;

  @doc("The number of channels in a recording (singular key). Returns '1' for mono or '2' for stereo.")
  @example("1")
  channel: "1" | "2";

  @doc("The number of channels in a recording. Returns '1' for mono or '2' for stereo.")
  @example("1")
  channels: "1" | "2";

  @doc("The date, in RFC 2822 format, this recording was created.")
  @example("Tue, 25 Sep 2018 23:00:00 +0000")
  date_created: string;

  @doc("The date, in RFC 2822 format, this recording was updated.")
  @example("Wed, 26 Sep 2018 23:00:04 +0000")
  date_updated: string;

  @doc("The time, in RFC 2822 format, this recording started.")
  @example("Tue, 25 Sep 2018 23:00:00 +0000")
  start_time: string | null;

  @doc("The time, in RFC 2822 format, this recording ended.")
  @example("Wed, 26 Sep 2018 23:00:04 +0000")
  end_time: string | null;

  @doc("The length, in seconds, of the recording.")
  @example(4)
  @minValue(0)
  duration: int32;

  @doc("The cost for the recording.")
  @example("-0.0025")
  price: string | null;

  @doc("The currency of the price of the recording.")
  @example("USD")
  price_unit: string;

  @doc("How the recording was made.")
  source: RecordingSource;

  @doc("The status of the recording.")
  status: RecordingStatus;

  @doc("Further details about a failed recording.")
  @example(null)
  error_code: string | null;

  @doc("The URI of the recording.")
  @example("/api/laml/2010-04-01/Accounts/720796a0-8ee9-4350-83bd-2d07a3121f1e/Recordings/19e436af-5688-4307-b03b-bdb2b42b8142.json")
  uri: string;

  @doc("Subresource URIs.")
  subresource_uris: RecordingSubresourceUris;

  @doc("Encryption details. Always null.")
  @example(null)
  encryption_details: string | null;

  @doc("Whether leading and trailing silence is trimmed from a recording.")
  @example("do-not-trim")
  trim: string;
}
