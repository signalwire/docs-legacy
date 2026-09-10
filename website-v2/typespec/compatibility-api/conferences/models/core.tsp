using TypeSpec.Http;

model ConferencesAccountSidPath {
  @doc("The unique identifier for the account that created this conference.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  @format("uuid")
  @path
  AccountSid: string;
}

model ConferenceSidPath {
  @doc("The unique identifier for this conference.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  @format("uuid")
  @path
  Sid: string;
}

model ConferenceSidPathForParticipant {
  @doc("The unique identifier for the conference this participant is in.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  @format("uuid")
  @path
  ConferenceSid: string;
}

model ParticipantCallSidPath {
  @doc("The unique identifier for the Participant call connected to this conference.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  @format("uuid")
  @path
  CallSid: string;
}

@doc("Conference region.")
enum ConferenceRegion {
  Us1: "us1",
  Us2: "us2",
  Ie1: "ie1",
  De1: "de1",
  Sg1: "sg1",
  Br1: "br1",
  Au1: "au1",
  Jp1: "jp1",
}

@doc("Conference status.")
enum ConferenceStatus {
  Init: "init",
  InProgress: "in-progress",
  Completed: "completed",
}

@doc("Conference participant status.")
enum ParticipantStatus {
  Completed: "completed",
  InProgress: "in-progress",
}

@doc("Conference subresource URIs.")
model ConferenceSubresourceUris {
  @doc("Links to the participants.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Conferences/b3877c40-da60-4998-90ad-b792e98472cf/Participants.json")
  participants: string;

  @doc("Links to the recordings.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Conferences/b3877c40-da60-4998-90ad-b792e98472cf/Recordings.json")
  recordings: string;
}

@doc("Conference model.")
model Conference {
  @doc("The unique identifier for this conference.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472cf")
  sid: string;

  @doc("The unique identifier for the account that created this conference.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  account_sid: string;

  @doc("The date, in RFC 2822 format, this conference was created.")
  @example("Mon, 24 Sept 2018 21:00:00 +0000")
  date_created: string;

  @doc("The date, in RFC 2822 format, this conference was updated.")
  @example("Tue, 25 Sept 2018 20:00:00 +0000")
  date_updated: string;

  @doc("A description, up to 64 characters, of the conference room.")
  @example("My Conference Room")
  friendly_name: string;

  @doc("The status of this conference.")
  status: ConferenceStatus;

  @doc("The version of the SignalWire API.")
  @example("2010-04-01")
  api_version: string;

  @doc("The region where this conference audio was mixed.")
  @example("us1")
  region: string;

  @doc("The URI for this conference.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Conferences/b3877c40-da60-4998-90ad-b792e98472cf.json")
  uri: string;

  @doc("The links to associated subresources.")
  subresource_uris: ConferenceSubresourceUris;
}

@doc("Conference participant model.")
model ConferenceParticipant {
  @doc("The unique identifier for the account that created this conference.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  account_sid: string;

  @doc("The unique identifier for the Participant call connected to this conference.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472ca")
  call_sid: string;

  @doc("The unique identifier of the participant who is being coached.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472co")
  call_sid_to_coach: string | null;

  @doc("Whether the participant is coaching another call.")
  @example(false)
  coaching: boolean;

  @doc("The unique identifier for the conference this participant is in.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472cf")
  conference_sid: string;

  @doc("The date, in RFC 2822 format, this conference participant was created.")
  @example("Mon, 24 Sept 2018 21:00:00 +0000")
  date_created: string;

  @doc("The status of the conference call.")
  status: ParticipantStatus;

  @doc("The date, in RFC 2822 format, this conference participant was updated.")
  @example("Tue, 25 Sept 2018 20:00:00 +0000")
  date_updated: string;

  @doc("Whether or not a conference ends when a participant leaves the conference call.")
  @example(false)
  end_conference_on_exit: boolean;

  @doc("Whether or not a participant is muted.")
  @example(false)
  muted: boolean;

  @doc("Whether or not a participant is on hold.")
  @example(false)
  hold: boolean;

  @doc("Whether or not a conference will begin when this participant enters the conference call.")
  @example(true)
  start_conference_on_enter: boolean;

  @doc("The URI for this conference participant.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Conferences/b3877c40-da60-4998-90ad-b792e98472cf/Participants/b3877c40-da60-4998-90ad-b792e98472ca.json")
  uri: string;
}

@doc("Conference stream status.")
enum ConferenceStreamStatus {
  @doc("Stream is queued and waiting to start.")
  Queued: "queued",

  @doc("Stream is currently active.")
  InProgress: "in-progress",

  @doc("Stream has been stopped.")
  Stopped: "stopped",
}

@doc("Conference stream model.")
model ConferenceStream {
  @doc("The unique identifier for the account.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  account_sid: string;

  @doc("The unique identifier for the conference.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472cf")
  conference_sid: string;

  @doc("The date, in RFC 2822 GMT format, this stream was updated.")
  @example("Tue, 25 Sept 2018 20:00:00 +0000")
  date_updated: string;

  @doc("The name of the stream. May be null if not specified when creating the stream.")
  @example("my_conference_stream")
  name: string | null;

  @doc("The unique identifier for the stream.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472st")
  sid: string;

  @doc("The status of the stream.")
  status: ConferenceStreamStatus;

  @doc("The URI for the stream.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Conferences/b3877c40-da60-4998-90ad-b792e98472cf/Streams/b3877c40-da60-4998-90ad-b792e98472st.json")
  uri: string;
}

model ConferenceStreamSidPath {
  @doc("The unique identifier for the stream.")
  @example("b3877c40-da60-4998-90ad-b792e98472st")
  @format("uuid")
  @path
  Sid: string;
}

model ConferenceRecordingSidPath {
  @doc("The unique identifier for the recording.")
  @example("19e436af-5688-4307-b03b-bdb2b42b8142")
  @format("uuid")
  @path
  Sid: string;
}

@doc("Recording source for conference recordings.")
enum ConferenceRecordingSource {
  Conference: "Conference",
  StartConferenceRecording: "StartConferenceRecording",
}

@doc("Recording status.")
enum ConferenceRecordingStatus {
  Queued: "queued",
  InProgress: "in-progress",
  Paused: "paused",
  Resumed: "resumed",
  Completed: "completed",
  Absent: "absent",
  Stopped: "stopped",
}

@doc("Recording subresource URIs.")
model ConferenceRecordingSubresourceUris {
  @doc("The URI for transcriptions.")
  @example("/api/laml/2010-04-01/Accounts/720796a0-8ee9-4350-83bd-2d07a3121f1e/Recordings/19e436af-5688-4307-b03b-bdb2b42b8142/Transcriptions.json")
  transcriptions: string;
}

@doc("Conference recording model.")
model ConferenceRecording {
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

  @doc("The unique identifier for the call. Always null for conference recordings.")
  @example(null)
  call_sid: string | null;

  @doc("The unique identifier for the conference that is associated with this recording.")
  @format("uuid")
  @example("43bb71ee-553f-4074-bb20-8e2747647cce")
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
  duration: int32;

  @doc("The cost for the recording.")
  @example("-0.0025")
  price: string | null;

  @doc("The currency of the price of the recording.")
  @example("USD")
  price_unit: string;

  @doc("How the recording was made.")
  source: ConferenceRecordingSource;

  @doc("The status of the recording.")
  status: ConferenceRecordingStatus;

  @doc("Further details about a failed recording.")
  @example(null)
  error_code: string | null;

  @doc("The URI of the recording.")
  @example("/api/laml/2010-04-01/Accounts/720796a0-8ee9-4350-83bd-2d07a3121f1e/Conferences/43bb71ee-553f-4074-bb20-8e2747647cce/Recordings/19e436af-5688-4307-b03b-bdb2b42b8142.json")
  uri: string;

  @doc("Subresource URIs.")
  subresource_uris: ConferenceRecordingSubresourceUris;

  @doc("Encryption details. Always null.")
  @example(null)
  encryption_details: string | null;

  @doc("Whether leading and trailing silence is trimmed from a recording.")
  @example("do-not-trim")
  trim: string;
}
