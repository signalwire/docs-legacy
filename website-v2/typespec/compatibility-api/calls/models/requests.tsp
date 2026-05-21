import "./webhooks.tsp";

using TypeSpec.Http;

@doc("Request body for creating a call.")
model CreateCallRequest {
  @doc("The address that received the call. Can be a phone number in E.164 format, a SIP URI, or a client identifier.")
  @example("+13105678901")
  To: string;

  @doc("The address that initiated the call. Must be a phone number in E.164 format for PSTN calls.")
  @example("+13103384645")
  From: string;

  @doc("The URL to handle the call. Required if `ApplicationSid` and `Laml`/`Twiml` are not used.")
  @format("uri")
  @example("http://your-application.com/docs/voice.xml")
  Url?: string;

  @doc("The unique identifier of the application used to handle the call. Required if `Url` and `Laml`/`Twiml` are not used.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472ap")
  ApplicationSid?: string;

  // Commented out pending verification - may be internal only
  // @doc("Inline cXML/LAML document to execute. Required if `Url` and `ApplicationSid` are not used.")
  // @minLength(11)
  // @maxLength(4000)
  // @example("<Response><Say>Hello World</Say></Response>")
  // Laml?: string;

  @doc("Whether the request to `Url` is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  Method?: "GET" | "POST" = "POST";

  @doc("The URL SignalWire will request if errors occur when fetching the `Url`.")
  @format("uri")
  @example("https://your-api-endpoint.com/path")
  FallbackUrl?: string;

  @doc("Whether the request to `FallbackUrl` is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  FallbackMethod?: "GET" | "POST" = "POST";

  @webhook("voiceStatusCallback", VoiceStatusCallbackPayload)
  @doc("The URL SignalWire will send webhooks to on every requested `StatusCallbackEvent` event. See the [Voice status callback](/docs/compatibility-api/rest/calls/webhooks/voice-status-callback) webhook for the payload your URL will receive.")
  @format("uri")
  @example("https://your-api-endpoint.com/path")
  StatusCallback?: string;

  @doc("Whether the request to `StatusCallback` URL is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  StatusCallbackMethod?: "GET" | "POST" = "POST";

  @doc("The status events that trigger a SignalWire webhook. Valid values: initiated, ringing, answered, completed, ringing_forwarded, ringing_queued. Defaults to `completed`.")
  @example(#["initiated", "ringing", "answered", "completed"])
  StatusCallbackEvent?: string[] = #["completed"];

  @doc("The number, in E.164 format, or identifier of the caller. Used to override the From for caller ID purposes.")
  @example("+13102259067")
  CallerId?: string;

  @doc("The digits to press after a call is connected. Valid characters are 0-9, #, *, w (wait 0.5s), and W (wait 1s).")
  @pattern("^[\\d#*wW]{1,32}$")
  @maxLength(32)
  @example("1ww2")
  SendDigits?: string;

  @doc("The time in seconds SignalWire will wait before assuming the call has no answer. Default is `60` seconds.")
  @minValue(1)
  @maxValue(600)
  @example(60)
  Timeout?: int32 = 60;

  @doc("Whether a human or machine picked up the call. Default is `none`.")
  @example("Enable")
  MachineDetection?: "Enable" | "DetectMessageEnd" | "none" = "none";

  @doc("The time in seconds SignalWire will wait for machine detection before timing out. Default is `30` seconds.")
  @minValue(1)
  @maxValue(120)
  @example(30)
  MachineDetectionTimeout?: int32 = 30;

  @doc("How many milliseconds of voice to decide it is a machine. Default is `2400` milliseconds.")
  @minValue(1000)
  @maxValue(6000)
  @example(2400)
  MachineDetectionSpeechThreshold?: int32 = 2400;

  @doc("Number of milliseconds to wait for voice to finish. Default is `1200` milliseconds.")
  @minValue(500)
  @maxValue(5000)
  @example(1200)
  MachineDetectionSpeechEndThreshold?: int32 = 1200;

  @doc("Number of milliseconds to wait for initial voice before giving up. Default is `5000` milliseconds.")
  @minValue(2000)
  @maxValue(10000)
  @example(5000)
  MachineDetectionSilenceTimeout?: int32 = 5000;

  @doc("How many words to count to decide it is a machine. Default is `6`.")
  @minValue(1)
  @maxValue(100)
  @example(6)
  MachineWordsThreshold?: int32 = 6;

  @doc("Whether or not to execute machine detection asynchronously. Default is `false`.")
  @example(false)
  AsyncAmd?: boolean = false;

  @doc("Whether the request to `AsyncAmdStatusCallback` is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  AsyncAmdStatusCallbackMethod?: "GET" | "POST" = "POST";

  @doc("The URL to request when the machine detection is completed.")
  @format("uri")
  @example("https://your-api-endpoint.com/path")
  AsyncAmdStatusCallback?: string;

  @doc("Whether or not to report partial (interim) results to the callback url. Default is `false`.")
  @example(false)
  AsyncAmdPartialResults?: boolean = false;

  @doc("Whether or not to record a call. Default is `false`.")
  @example(false)
  Record?: boolean = false;

  @doc("The number of channels in the recording. Default is `mono`.")
  @example("mono")
  RecordingChannels?: "mono" | "dual" = "mono";

  @doc("Specifies whether to record the `inbound`, `outbound`, or `both` audio. Default is `both`.")
  @example("both")
  RecordingTrack?: "inbound" | "outbound" | "both" = "both";

  @webhook("recordingStatusCallback", RecordingStatusCallbackPayload, "Recordings")
  @doc("The URL to request when recording is available. See the [Recording status callback](/docs/compatibility-api/rest/recordings/webhooks/recording-status-callback) webhook for the payload your URL will receive.")
  @format("uri")
  @example("https://your-api-endpoint.com/path")
  RecordingStatusCallback?: string;

  @doc("Whether the request to `RecordingStatusCallback` URL is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  RecordingStatusCallbackMethod?: "GET" | "POST" = "POST";

  @doc("The recording status events that trigger a webhook. Space-separated list. Valid values: completed, in-progress, absent. Default is `completed`.")
  @example("completed")
  RecordingStatusCallbackEvent?: string = "completed";

  @doc("Whether leading and trailing silence is trimmed from a recording. Default is `trim-silence`.")
  @example("trim-silence")
  Trim?: "trim-silence" | "do-not-trim" = "trim-silence";

  @doc("The username to authenticate the caller when making an outbound SIP call.")
  @example("sipuser")
  SipAuthUsername?: string;

  @doc("The password to authenticate the caller when making an outbound SIP call.")
  @example("sippassword")
  SipAuthPassword?: string;

  @doc("The maximum price in USD acceptable for the call to be created. Format: up to 4 decimal places.")
  @pattern("^\\d+\\.?\\d{0,4}$")
  @example("0.0075")
  MaxPricePerMinute?: string;
}

@doc("Request body for updating a call.")
model UpdateCallRequest {
  @doc("The URL to handle the call.")
  @format("uri")
  @example("http://your-application.com/docs/voice.xml")
  Url?: string;

  @doc("Whether the request to `Url` is a `GET` or a `POST`.")
  @example("POST")
  Method?: "GET" | "POST";

  @doc("The status to update the call to.")
  @example("completed")
  Status?: "canceled" | "completed";

  @doc("The URL SignalWire will request if errors occur.")
  @format("uri")
  @example("https://your-api-endpoint.com/fallback")
  FallbackUrl?: string;

  @doc("Whether the request to `FallbackUrl` is a `GET` or a `POST`.")
  @example("POST")
  FallbackMethod?: "GET" | "POST";

  @doc("The URL SignalWire will send webhooks to.")
  @format("uri")
  @example("https://your-api-endpoint.com/status")
  StatusCallback?: string;

  @doc("Whether the request to `StatusCallback` is a `GET` or a `POST`.")
  @example("POST")
  StatusCallbackMethod?: "GET" | "POST";

  // Commented out pending verification - may be internal only
  // @doc("Inline cXML/LAML document to execute for redirecting the call.")
  // @minLength(11)
  // @maxLength(4000)
  // @example("<Response><Say>Hello World</Say></Response>")
  // Laml?: string;
}

@doc("Request body for creating a call stream.")
model CreateCallStreamRequest {
  @doc("Unique name for the Stream, per Call. It is used to stop a Stream by name.")
  @example("my_first_stream")
  Name?: string;

  @doc("This attribute can be one of inbound_track, outbound_track, both_tracks. Default is `both_tracks`.")
  @example("both_tracks")
  Track?: "inbound_track" | "outbound_track" | "both_tracks" = "both_tracks";

  @doc("Whether the request to `StatusCallback` URL is a `GET` or a `POST`. Default is `POST`.")
  @example("GET")
  StatusCallbackMethod?: "GET" | "POST" = "POST";

  @doc("The URL to request to when stream is available.")
  @format("uri")
  @example("https://your-api-endpoint.com/stream-status")
  StatusCallback?: string;

  @doc("Absolute or relative URL. A WebSocket connection to the url will be established and audio will start flowing towards the Websocket server. The only supported protocol is wss. For security reasons ws is NOT supported.")
  @format("uri")
  @example("wss://your-application.com/audiostream")
  Url: string;

  @doc("Custom parameter name to pass towards the WebSocket server. You can pass up to 99 custom parameters using `Parameter1.Name` through `Parameter99.Name`.")
  @example("FirstName")
  `Parameter1.Name`?: string;

  @doc("Custom parameter value to pass towards the WebSocket server. You can pass up to 99 custom parameters using `Parameter1.Value` through `Parameter99.Value`.")
  @example("Jane")
  `Parameter1.Value`?: string;

  @doc("Custom parameter name to pass towards the WebSocket server.")
  @example("LastName")
  `Parameter2.Name`?: string;

  @doc("Custom parameter value to pass towards the WebSocket server.")
  @example("Doe")
  `Parameter2.Value`?: string;

  @doc("Bearer token for authorization with the WebSocket server.")
  @example("your-bearer-token")
  AuthorizationBearerToken?: string;
}

@doc("Request body for updating a call stream.")
model UpdateCallStreamRequest {
  @doc("The status of the stream. Only 'stopped' is allowed.")
  @example("stopped")
  Status: "stopped";
}

@doc("Request body for creating a call recording.")
model CreateCallRecordingRequest {
  @doc("The number of channels in the recording. Can be `mono` (both legs of call recorded under one channel into one recording file) or `dual` (each leg of call recorded in separate channels into one recording file). Default is `mono`.")
  @example("mono")
  RecordingChannels?: "mono" | "dual" = "mono";

  @webhook("recordingStatusCallback", RecordingStatusCallbackPayload, "Recordings")
  @doc("The URL to request to when recording is available. See the [Recording status callback](/docs/compatibility-api/rest/recordings/webhooks/recording-status-callback) webhook for the payload your URL will receive.")
  @format("uri")
  @example("https://your-api-endpoint.com/recording-status")
  RecordingStatusCallback?: string;

  @doc("The different recording statuses. To specify multiple events, separate with a space. Valid values: completed, in-progress, absent. Default is `completed`.")
  @example("completed")
  RecordingStatusCallbackEvent?: string = "completed";

  @doc("Whether the request to `RecordingStatusCallback` URL is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  RecordingStatusCallbackMethod?: "GET" | "POST" = "POST";

  @doc("Specifies whether to record the `inbound` audio to SignalWire from the called party or the `outbound` audio from SignalWire to the called party or `both` the inbound and outbound audio. Default is `both`.")
  @example("both")
  RecordingTrack?: "inbound" | "outbound" | "both" = "both";

  @doc("Whether leading and trailing silence is trimmed from a recording. Default is `do-not-trim`.")
  @example("do-not-trim")
  Trim?: "trim-silence" | "do-not-trim" = "do-not-trim";
}

@doc("Request body for updating a call recording.")
model UpdateCallRecordingRequest {
  @doc("The status of the recording.")
  @example("paused")
  Status: "paused" | "in-progress" | "stopped";

  @doc("What to do while recording is paused. Default is `silence`.")
  @example("silence")
  PauseBehavior?: "skip" | "silence" = "silence";
}
