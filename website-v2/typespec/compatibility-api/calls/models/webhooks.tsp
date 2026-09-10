import "../../../_shared/webhook/decorator.tsp";

@summary("Voice status callback")
@doc("""
  Payload sent by SignalWire to your Voice Status Callback URL when the status of a call changes.

  Configure this callback using the `StatusCallback` and `StatusCallbackEvent` parameters when
  [creating a call via the API](/compatibility-api/rest/create-a-call) or using
  [Dial](/compatibility-api/cxml/voice/dial) with
  [Number](/compatibility-api/cxml/voice/number-noun),
  [SIP](/compatibility-api/cxml/voice/sip-noun), or
  [Conference](/compatibility-api/cxml/voice/conference-noun).

  Use `StatusCallbackEvent` to receive every call progress event — not just the final status —
  along with current call state and all parameters below.
  """)
model VoiceStatusCallbackPayload {
  @doc("The unique ID of the project this call is associated with.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  AccountSid: string;

  @doc("""
    The version of the SignalWire API.
    Incoming calls use the API version placed on the number called.
    Outgoing calls use the version of the REST API request.
    """)
  @example("2010-04-01")
  ApiVersion: string;

  @doc("The average time between packets for the inbound stream.")
  @example(20)
  AudioInAveragePtime: int32;

  @doc("The number of DTMF packets in the inbound media stream.")
  @example(0)
  AudioInDtmfPacketCount: int32;

  @doc("""
    The number of incoming packets removed from the jitter buffer due to buffer overflow or underflow,
    causing these packets to be discarded or lost.
    """)
  @example(2)
  AudioInFlushPacketCount: int32;

  @doc("The maximum variance of jitter for incoming audio RTP packets.")
  @example(8)
  AudioInJitterMaxVariance: int32;

  @doc("The minimum variance of jitter for incoming audio RTP packets.")
  @example(1)
  AudioInJitterMinVariance: int32;

  @doc("The largest jitter buffer size recorded for incoming audio RTP packets during the session.")
  @example(4)
  AudioInLargestJbSize: int32;

  @doc("A mean opinion score on a scale of 1–5 that helps determine audio quality.")
  @example("4.3")
  AudioInMos: string;

  @doc("The number of audio packets received in the inbound media stream.")
  @example(1842)
  AudioInMediaPacketCount: int32;

  @doc("""
    Increased with every packet not received at a given ptime.
    Increases with every lost packet from the inbound stream.
    """)
  @example(1)
  AudioInSkipPacketCount: int32;

  @doc("The total number of DTMF packets generated in the outbound media stream.")
  @example(0)
  AudioOutDtmfPacketCount: int32;

  @doc("The number of audio packets sent in the outbound media stream.")
  @example(1840)
  AudioOutMediaPacketCount: int32;

  @doc("The source of the status callback.")
  @example("call-progress-events")
  CallbackSource: string;

  @doc("The duration, in seconds, of the finished call. Only present on the `completed` event.")
  @example(94)
  CallDuration?: int32;

  @doc("The name of the caller. Only available if Caller ID lookup is enabled.")
  @example("Jane Smith")
  CallerName?: string;

  @doc("A unique identifier for the call.")
  @example("b3877c40-da60-4998-90ad-b792e98472ca")
  CallSid: string;

  @doc("""
    The status of the call.

    | Status | Description |
    |--------|-------------|
    | `initiated` | The initial dial has begun. |
    | `ringing` | The call is ringing. |
    | `in-progress` | The call was answered and is in progress. |
    | `queued` | The call is ready and in line to initiate. |
    | `failed` | The call could not be completed. Usually occurs when the phone number does not exist. |
    | `busy` | The caller encountered a busy signal. |
    | `no-answer` | The call ended without an answer. |
    | `completed` | The call was answered and ended normally. |
    | `canceled` | The REST API canceled the call while it was ringing or queued. |
    """)
  @example("completed")
  CallStatus: "initiated" | "ringing" | "in-progress" | "queued" | "failed" | "busy" | "no-answer" | "completed" | "canceled";

  @doc("""
    The direction of the call.
    - `outbound-dial`: calls launched through the Dial verb.
    - `outbound-api`: calls launched through the REST API.
    - `inbound`: inbound calls.
    """)
  @example("outbound-api")
  Direction: "outbound-dial" | "outbound-api" | "inbound";

  @doc("The number this call was forwarded from.")
  @example("+15550001111")
  ForwardedFrom?: string;

  @doc("The phone number that sent this call, in E.164 format.")
  @example("+15551234567")
  From: string;

  @doc("A unique identifier for the call that created this call.")
  @example("b3877c40-da60-4998-90ad-b792e98472pa")
  ParentCallSid?: string;

  @doc("The duration, in seconds, of the recording.")
  @example(94)
  RecordingDuration?: int32;

  @doc("The unique identifier for the audio recording.")
  @example("b3877c40-da60-4998-90ad-b792e984re01")
  RecordingSid?: string;

  @doc("The URL of the recorded audio call.")
  @example("https://example.signalwire.com/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Recordings/b3877c40-da60-4998-90ad-b792e984re01")
  RecordingUrl?: string;

  @doc("""
    The order in which events occur, starting at 0.
    Although events are fired in order, they each take time and may not appear in the order you expect.
    """)
  @example(4)
  SequenceNumber: int32;

  @doc("A textual description of the result of the SIP INVITE request, indicating success or failure with additional details.")
  @example("OK")
  SipInviteResultPhrase?: string;

  @doc("The numeric SIP response code received for the INVITE request, indicating the outcome of the call attempt. See the [list of SIP response codes](https://en.wikipedia.org/wiki/List_of_SIP_response_codes) for possible values.")
  @example("200")
  SipResultCode?: string;

  @doc("The timestamp, in RFC 2822 format, of when the event occurred.")
  @example("Thu, 04 Apr 2024 18:32:15 +0000")
  Timestamp: string;

  @doc("The phone number of the call recipient, in E.164 format.")
  @example("+15559876543")
  To: string;
}

@summary("Recording status callback")
@doc("""
  Payload sent by SignalWire to your `RecordingStatusCallback` URL when a recording status event occurs.

  Recordings are not always available immediately — especially at high call volumes. This callback lets
  your app react as soon as a recording is ready, whether that means uploading it to external storage,
  sending it via email, or forwarding the URL via SMS.

  Configure `RecordingStatusCallback` when
  [creating a call via the API](/compatibility-api/rest/create-a-call) or when using
  [Dial](/compatibility-api/cxml/voice/dial),
  [Conference](/compatibility-api/cxml/voice/conference-noun), or
  [Record](/compatibility-api/cxml/voice/record).

  Use `RecordingStatusCallbackEvent` to request callbacks for specific events. If omitted, only the
  `completed` event is sent. Possible values: `in-progress`, `completed`, `absent`.

  | Status | Description |
  |--------|-------------|
  | `in-progress` | The recording has begun. |
  | `completed` | The file is available for access. |
  | `absent` | The recording was too short or the call was silent — no audio was detected. |
  """)
model RecordingStatusCallbackPayload {
  @doc("The unique ID of the project this call is associated with.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  AccountSid: string;

  @doc("A unique identifier for the call. May be used to later retrieve this call from the REST API.")
  @example("b3877c40-da60-4998-90ad-b792e98472ca")
  CallSid: string;

  @doc("The unique identifier for the recording.")
  @example("b3877c40-da60-4998-90ad-b792e984re01")
  RecordingSid: string;

  @doc("The URL for the audio recording.")
  @example("https://example.signalwire.com/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Recordings/b3877c40-da60-4998-90ad-b792e984re01")
  RecordingUrl: string;

  @doc("""
    The status of the recording.
    - `in-progress`: Recording has begun.
    - `completed`: File is available.
    - `absent`: Recording was too short or no audio was detected.
    """)
  @example("completed")
  RecordingStatus: "in-progress" | "completed" | "absent";

  @doc("The duration, in seconds, of the recording.")
  @example(94)
  RecordingDuration: int32;

  @doc("The number of channels in the recording.")
  @example(1)
  RecordingChannels: int32;

  @doc("The type of call that initiated the recording.")
  @example("RecordVerb")
  RecordingSource: string;
}
