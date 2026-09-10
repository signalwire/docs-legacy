using TypeSpec.Http;

@doc("Request body for updating a conference.")
model UpdateConferenceRequest {
  @doc("The status of this conference. Only 'completed' is allowed to end the conference.")
  @example("completed")
  Status?: "completed";

  @doc("The URL to send conference announcements to.")
  @format("uri")
  @example("https://your-api-endpoint.com/announce")
  AnnounceUrl?: string;

  @doc("Whether the request to `AnnounceUrl` is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  AnnounceMethod?: "GET" | "POST" = "POST";
}

@doc("Request body for updating a conference participant.")
model UpdateConferenceParticipantRequest {
  @doc("The URL to send conference announcements to.")
  @format("uri")
  @example("https://your-api-endpoint.com/announce")
  AnnounceUrl?: string;

  @doc("Whether the request to `AnnounceUrl` is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  AnnounceMethod?: "GET" | "POST" = "POST";

  @doc("Whether the participant is coaching another call. Requires `CallSidToCoach` to be set.")
  @example(false)
  Coaching?: boolean;

  @doc("The unique identifier of the participant who is being coached. Required when `Coaching` is true.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472co")
  CallSidToCoach?: string;

  @doc("Whether or not a participant is on hold.")
  @example(false)
  Hold?: boolean;

  @doc("Whether the request to `HoldUrl` is a `GET` or a `POST`. Default is `GET`.")
  @example("GET")
  HoldMethod?: "GET" | "POST" = "GET";

  @doc("The URL to send hold music to that will be played when participant is on hold.")
  @format("uri")
  @example("https://your-api-endpoint.com/hold-music")
  HoldUrl?: string;

  @doc("Whether or not a participant is muted.")
  @example(false)
  Muted?: boolean;

  @doc("The URL for wait music to be played while a conference is not yet started.")
  @format("uri")
  @example("https://your-api-endpoint.com/wait-music")
  WaitUrl?: string;

  @doc("Whether the request to `WaitUrl` is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  WaitMethod?: "GET" | "POST" = "POST";
}

@doc("Request body for creating a conference stream.")
model CreateConferenceStreamRequest {
  @doc("Unique name for the Stream, per Conference. It is used to stop a Stream by name.")
  @example("my_conference_stream")
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

  @doc("The audio codec to use for the stream.")
  @example("PCMU")
  StreamCodec?: "PCMU" | "PCMA" | "L16" | "L16@16000h" | "L16@24000h";

  @doc("Enable real-time streaming for the conference stream.")
  @example(true)
  StreamRealTime?: boolean;

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

@doc("Request body for updating a conference stream.")
model UpdateConferenceStreamRequest {
  @doc("The status of the stream. Only 'stopped' is allowed.")
  @example("stopped")
  Status: "stopped";
}

@doc("Request body for updating a conference recording.")
model UpdateConferenceRecordingRequest {
  @doc("The status of the recording.")
  @example("paused")
  Status: "paused" | "in-progress" | "stopped";

  @doc("What to do while recording is paused. Default is `silence`.")
  @example("silence")
  PauseBehavior?: "skip" | "silence" = "silence";
}
