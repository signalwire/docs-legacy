@summary("PlaybackBGAction object")
model PlaybackBGAction {
  @doc("A JSON object containing the audio file to play.")
  @summary("playback_bg")
  playback_bg: {
    @doc("URL or filepath of the audio file to play.")
    @example("https://cdn.signalwire.com/default-music/welcome.mp3")
    file: url;

    @doc("Whether to wait for the audio file to finish playing before continuing. Default is `false`.")
    wait?: boolean;
  };
}
