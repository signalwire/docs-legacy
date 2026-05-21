@summary("stop_record_call Method")
model StopRecordCall {
  @summary("stop_record_call")
  @doc("Stop an active background recording.")
  stop_record_call: {
    @doc("""
      Identifier for the recording to stop.
      If not set, the last recording started will be stopped.
      """)
    @example("recording_001")
    control_id?: string;
  };
}
