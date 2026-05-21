@summary("stop_tap Method")
model StopTap {
  @summary("stop_tap")
  @doc("Stop an active tap stream.")
  stop_tap: {
    @doc("""
      ID of the tap to stop.
      If not set, it will shut off the most recent tap session.
      """)
    @example("tap_001")
    control_id?: string;
  };
}
