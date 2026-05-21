import "../../recordings/models/core.tsp";

using TypeSpec.Http;

model CallsAccountSidPath {
  @doc("The Project ID that uniquely identifies the Account.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  @format("uuid")
  @path
  AccountSid: string;
}

model CallSidPath {
  @doc("The unique identifier for the call.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  @format("uuid")
  @path
  Sid: string;
}

model CallSidPathForRecording {
  @doc("The unique identifier for the call.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  @format("uuid")
  @path
  CallSid: string;
}

@doc("Call status.")
enum CallStatus {
  Queued: "queued",
  Ringing: "ringing",
  InProgress: "in-progress",
  Canceled: "canceled",
  Completed: "completed",
  Busy: "busy",
  Failed: "failed",
  NoAnswer: "no-answer",
}

@doc("Call direction.")
enum CallDirection {
  Inbound: "inbound",
  Outbound: "outbound",
}

@doc("Who/what answered the call.")
enum AnsweredBy {
  Human: "human",
  Machine: "machine",
}

@doc("Stream status.")
enum StreamStatus {
  Queued: "queued",
  InProgress: "in-progress",
  Stopped: "stopped",
}

@doc("Stream track options.")
enum StreamTrack {
  InboundTrack: "inbound_track",
  OutboundTrack: "outbound_track",
  BothTracks: "both_tracks",
}

@doc("Call subresource URIs.")
model CallSubresourceUris {
  @doc("The URI for notifications. Always null.")
  @example(null)
  notifications: string | null;

  @doc("The URI for recordings.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Calls/b3877c40-da60-4998-90ad-b792e98472ca/Recordings.json")
  recordings: string;
}

@doc("Call model representing a voice call.")
model Call {
  @doc("The unique identifier for the call.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472ca")
  sid: string;

  @doc("The unique identifier for the account that created this call.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  account_sid: string;

  @doc("The date, in RFC 2822 GMT format, this call was created.")
  @example("Wed, 19 Sep 2018 20:00:00 +0000")
  date_created: string;

  @doc("The date, in RFC 2822 GMT format, this call was updated.")
  @example("Wed, 19 Sep 2018 21:00:00 +0000")
  date_updated: string;

  @doc("The unique identifier for the call that created this call.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  parent_call_sid: string | null;

  @doc("The address that received the call.")
  @example("+13105678901")
  to: string;

  @doc("The formatted number that received the call.")
  @example("(310) 567-8901")
  formatted_to: string;

  @doc("The formatted number that received the call. Alias for formatted_to.")
  @example("(310) 567-8901")
  to_formatted: string;

  @doc("The address that initiated the call.")
  @example("+13103384645")
  from: string;

  @doc("The formatted number that initiated the call.")
  @example("(310) 338-4645")
  formatted_from: string;

  @doc("The formatted number that initiated the call. Alias for formatted_from.")
  @example("(310) 338-4645")
  from_formatted: string;

  @doc("The unique identifier for the phone number.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472pn")
  phone_number_sid: string | null;

  @doc("The status of the call.")
  status: CallStatus;

  @doc("The time, in RFC 2822 GMT format, on which the call began.")
  @example("Wed, 19 Sep 2018 20:00:01 +0000")
  start_time: string | null;

  @doc("The time, in RFC 2822 GMT format, on which the call was terminated.")
  @example("Fri, 21 Sep 2018 10:00:00 +0000")
  end_time: string | null;

  @doc("The duration, in seconds, of the call.")
  @example(20)
  duration: int32;

  @doc("The charge for the call.")
  @example(0.003)
  price: float32 | null;

  @doc("The currency, in ISO 4127 format, for the price of the call.")
  @example("USD")
  price_unit: string;

  @doc("The direction of the call.")
  direction: CallDirection;

  @doc("Who/what the call was answered by.")
  answered_by: AnsweredBy | null;

  @doc("The version of the SignalWire API.")
  @example("2010-04-01")
  api_version: string;

  @doc("The number this call was forwarded from. Always null.")
  @example(null)
  forwarded_from: string | null;

  @doc("The caller name. Always null.")
  @example(null)
  caller_name: string | null;

  @doc("The URI for the call.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Calls/b3877c40-da60-4998-90ad-b792e98472ca.json")
  uri: string;

  @doc("A Map of available sub-resources.")
  subresource_uris: CallSubresourceUris;

  @doc("The annotation for the call. Always null.")
  @example(null)
  annotation: string | null;

  @doc("The group SID for the call. Always null.")
  @example(null)
  group_sid: string | null;

  @doc("The Mean Opinion Score for audio quality (1.0-5.0).")
  @example(4.5)
  audio_in_mos: float32 | null;

  @doc("The SIP result code for the call.")
  @example("200")
  sip_result_code: string | null;

  @doc("The average round-trip time for audio in milliseconds.")
  @example(50)
  audio_rtt_avg: int32 | null;

  @doc("The minimum round-trip time for audio in milliseconds.")
  @example(20)
  audio_rtt_min: int32 | null;

  @doc("The maximum round-trip time for audio in milliseconds.")
  @example(100)
  audio_rtt_max: int32 | null;

  @doc("The minimum outbound audio jitter in milliseconds.")
  @example(1)
  audio_out_jitter_min: int32 | null;

  @doc("The maximum outbound audio jitter in milliseconds.")
  @example(10)
  audio_out_jitter_max: int32 | null;

  @doc("The average outbound audio jitter in milliseconds.")
  @example(5)
  audio_out_jitter_avg: int32 | null;

  @doc("The number of outbound audio packets lost.")
  @example(0)
  audio_out_lost: int32 | null;
}

@doc("Call recording model.")
model CallRecording {
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

@doc("Call stream model.")
model CallStream {
  @doc("The unique identifier for the stream.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472st")
  sid: string;

  @doc("The unique identifier for the account.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  account_sid: string;

  @doc("The unique identifier for the call.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472ca")
  call_sid: string;

  @doc("The name of the stream.")
  @example("my_first_stream")
  name: string;

  @doc("The status of the stream.")
  status: StreamStatus;

  @doc("The date, in RFC 2822 GMT format, this stream was updated.")
  @example("Wed, 19 Sep 2018 21:00:00 +0000")
  date_updated: string;

  @doc("The URI for the stream.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Calls/b3877c40-da60-4998-90ad-b792e98472ca/Streams/b3877c40-da60-4998-90ad-b792e98472st.json")
  uri: string;
}
