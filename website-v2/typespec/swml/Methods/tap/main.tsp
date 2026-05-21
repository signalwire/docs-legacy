import "../../Shared/Types/main.tsp";

@summary("tap Method")
model Tap {
  @summary("tap")
  @doc("Start background call tap. Media is streamed over Websocket or RTP to customer controlled URI.")
  tap: {
    @doc("Destination of the tap media stream: rtp://IP:port, ws://example.com, or wss://example.com.")
    @example("wss://example.com/tap-stream")
    uri: string;

    @doc("Identifier for this tap to use with `stop_tap`.")
    @example("tap_001")
    control_id?: string;

    @doc("""
      Direction of the audio to tap:
          `speak` for what party says,
          `listen` for what party hears,
          `both` for what party hears and says.
          Default is `"speak"`.
      """)
    @example("both")
    direction?: "speak" | "listen" | "both" = "speak";

    @doc("""
      Codec to use for the tap media stream.
      Possible Values: [`PCMU`, `PCMA`]
      Default is `"PCMU"`.
      """)
    @example("PCMU")
    codec?: "PCMU" | "PCMA" = "PCMU";

    @doc("""
      If `uri` is a `rtp://` this will set the packetization time of the media in milliseconds.
      Default is `20` milliseconds.
      """)
    @example(20)
    rtp_ptime?: integer | SWMLVar = 20;

    @doc("http or https URL to deliver tap status events")
    @example("https://example.com/tap-status")
    status_url?: url;
  };
}
