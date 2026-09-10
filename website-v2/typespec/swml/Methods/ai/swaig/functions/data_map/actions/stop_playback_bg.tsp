@summary("stop_playback_bg Action")
model StopPlaybackBGAction {
  @summary("stop_playback_bg")
  @doc("Whether to stop the background audio file.")
  @example(true)
  stop_playback_bg: boolean | SWMLVar;
}
