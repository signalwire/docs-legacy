import "../../Methods";
import "./headers.tsp";
import "@typespec/json-schema";

using TypeSpec.JsonSchema;

union ValidConfirmMethods {
  Cond,
  Set,
  Unset,
  Hangup,
  Play,
  Prompt,
  global.Record,
  RecordCall,
  StopRecordCall,
  Tap,
  StopTap,
  SendDigits,
  SendSMS,
  Denoise,
  StopDenoise,
}

enum CallStatus {
  created,
  ringing,
  answered,
  ended,
}

@summary("ConnectSwitch object")
model ConnectSwitch {
  @doc("Name of the variable whose value needs to be compared. If not provided, it will check the `connect_result` variable.")
  @example("connect_result")
  variable?: string;

  @doc("Object of values mapped to array of instructions to execute")
  case: {
    ...TypeSpec.Record<SWMLMethod[]>;
  };

  @doc("Array of instructions to execute if no cases match")
  default?: SWMLMethod[];
}

@summary("ConnectDeviceBase object")
model ConnectDeviceBase {
  @doc("The caller ID to use when dialing the number.")
  @example("+15551234567")
  from?: string;

  @doc("Custom SIP headers to add to INVITE. It Has no effect on calls to phone numbers.")
  headers?: ConnectHeaders[];

  @doc("""
    Comma-separated string of codecs to offer.
    It has no effect on calls to phone numbers.
    Based on SignalWire settings.
    """)
  @example("PCMU,PCMA,OPUS")
  codecs?: string;

  @doc("""
    If true, WebRTC media is offered to the SIP endpoint.
    It has no effect on calls to phone numbers.
    Default is `false`.
    """)
  @example(true)
  webrtc_media?: boolean | SWMLVar = false;

  @doc("""
    Time, in seconds, to set the SIP `Session-Expires` header in INVITE.
    Must be a positive, non-zero number.
    It has no effect on calls to phone numbers.
    Based on SignalWire settings.
    """)
  @minValue(1)
  @example(1800)
  session_timeout?: integer | SWMLVar = 0;

  @doc("Array of URIs to play as ringback tone. If not specified, plays audio from the provider.")
  @example(#["https://example.com/ringback.mp3"])
  ringback?: string[];

  @doc("""
    Action to take based on the result of the call. This will run once the peer leg of the call has ended.
    Will use the switch method when the return_value is an object, and will use the cond method when the return_value is an array.
    """)
  result?: ConnectSwitch | Cond.cond;

  @doc("""
    Time, in seconds, to wait for the call to be answered.
    Default is 60 seconds.
    """)
  @example(30)
  timeout?: integer | SWMLVar = 60;

  @doc("""
    Maximum duration, in seconds, allowed for the call.
    Default is `14400` seconds.
    """)
  @example(3600)
  max_duration?: integer | SWMLVar = 14400;

  @doc("""
    Delay answer until the B-leg answers.
    Default is `false`.
    """)
  @example(true)
  answer_on_bridge?: boolean | SWMLVar = false;

  @doc("""
    Confirmation to execute when the call is connected. Can be either:
    - A URL (string) that returns a SWML document
    - An array of SWML methods to execute inline
    """)
  @example("https://example.com/confirm.swml")
  confirm?: string | ValidConfirmMethods[];

  @doc("The amount of time, in seconds, to wait for the `confirm` URL to return a response")
  @example(30)
  confirm_timeout?: integer | SWMLVar;

  @doc("SIP username to use for authentication when dialing a SIP URI. Has no effect on calls to phone numbers.")
  @example("sipuser")
  username?: string;

  @doc("SIP password to use for authentication when dialing a SIP URI. Has no effect on calls to phone numbers.")
  @example("sippassword")
  password?: string;

  @doc("Encryption setting to use. **Possible values:** `mandatory`, `optional`, `forbidden`")
  @example("optional")
  encryption?: "mandatory" | "optional" | "forbidden" = "optional";

  @doc("Webhook URL to send call status change notifications to. Authentication can also be set in the URL in the format of `username:password@url`.")
  @example("https://example.com/call-status")
  call_state_url?: url;

  @doc("""
    SWML to execute after the bridge completes. This defines what should happen after the call is connected and the bridge ends.
    Can be either:
    - A URL (http or https) that returns a SWML document
    - An inline SWML document (as a JSON string)
    
    **Note:** This parameter is REQUIRED when connecting to a queue (when `to` starts with "queue:")
    """)
  @example("https://example.com/after-bridge.swml")
  transfer_after_bridge?: string | SWMLVar;

  @doc("""
    An array of call state event names to be notified about.
    Allowed event names are:
        - `created`
        - `ringing`
        - `answered`
        - `ended`
    """)
  call_state_events?: CallStatus[] = #[CallStatus.ended];

  @doc("""
    HTTP or HTTPS URL to deliver connect status events.
    These events report the overall status of the connect operation
    (connecting, connected, failed, disconnected) via a `calling.call.connect` event.
    """)
  @example("https://example.com/connect-status")
  status_url?: url;
}

@summary("Single Destination")
model ConnectDeviceSingle is ConnectDeviceBase {
  @doc("""
    Destination to dial. Can be:
    - Phone number in E.164 format (e.g., "+15552345678")
    - SIP URI (e.g., "sip:alice@example.com")
    - Call Fabric Resource address (e.g., "/public/test_room")
    - Queue (e.g., "queue:support")
    - WebSocket stream (e.g., "stream:wss://example.com/audio")
    """)
  @example("+15559876543")
  to: string;

  // Stream-specific properties (only apply when `to` starts with "stream:wss://")

  @doc("Stream name identifier. Only applies to stream destinations.")
  @example("my-stream")
  name?: string;

  @doc("""
    Audio codec for the stream. Supported values: `PCMU`, `PCMA`, `G722`, `L16`.
    Codec can include rate and ptime modifiers (e.g., `PCMU@40i`, `L16@24000h@40i`).
    Only applies to stream destinations.
    """)
  @example("PCMU")
  codec?: string;

  @doc("""
    Enable realtime mode for bidirectional audio.
    Only applies to stream destinations.
    """)
  @example(true)
  realtime?: boolean | SWMLVar = false;

  @doc("""
    HTTP method for the stream status webhook.
    Only applies to stream destinations.
    """)
  @example("POST")
  status_url_method?: "GET" | "POST" = "POST";

  @doc("Bearer token sent as an `Authorization` header during the WebSocket handshake. Only applies to stream destinations.")
  @example("my-secret-token")
  authorization_bearer_token?: string;

  @doc("Custom key-value pairs sent in the WebSocket start message. Only applies to stream destinations.")
  custom_parameters?: TypeSpec.Record<string>;
}

@summary("Serial Dialing")
model ConnectDeviceSerial is ConnectDeviceBase {
  serial: ConnectDeviceSingle[];
}

@summary("Parallel Dialing")
model ConnectDeviceParallel is ConnectDeviceBase {
  @doc("Array of destinations to dial simultaneously.")
  parallel: ConnectDeviceSingle[];
}

@summary("Serial-Parallel Dialing")
model ConnectDeviceSerialParallel is ConnectDeviceBase {
  @doc("""
    Array of arrays.
    Inner arrays contain destinations to dial simultaneously.
    Outer array attempts each parallel group in order.
    """)
  serial_parallel: ConnectDeviceSingle[][];
}

alias ConnectDevice =
  | ConnectDeviceSingle
  | ConnectDeviceSerial
  | ConnectDeviceParallel
  | ConnectDeviceSerialParallel;

@summary("connect Method")
model Connect {
  @doc("Connect to a phone number, SIP URI, Call Fabric resource, queue, or WebSocket stream.")
  @oneOf
  connect: ConnectDevice;
}
