@summary("hold Action")
model HoldAction {
  @doc("""
    Places the caller on hold while playing hold music (configured via params.hold_music).
    During hold, speech detection is paused and the AI agent will not respond to the caller.
    The value specifies the hold timeout in seconds.
    Can be a number or an object with timeout property.
    """)
  @summary("hold")
  @maxValue(900)
  @example(120)
  hold: int32 | SWMLVar | {
    @doc("The duration to hold the caller in seconds. Can be a number or an object with timeout property.")
    @maxValue(900)
    @example(300)
    timeout?: int32 | SWMLVar = 300;
  };
}
