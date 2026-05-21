import "../../Shared/Types/main.tsp";

@summary("record Method")
model Record {
  @summary("record")
  @doc("""
    Record the call audio in the foreground, pausing further SWML execution until recording ends.
    Use this, for example, to record voicemails.
    To record calls in the background in a non-blocking fashion, use the record_call method.
    """)
  record: {
    @doc("""
      If true, record in stereo.
      Default is `false`.
      """)
    @example(true)
    stereo?: boolean | SWMLVar = false;

    @doc("""
      The format to record in. Can be `wav`, `mp3`, or `mp4`.
      Default is `"wav"`.
      """)
    @example("mp3")
    format?: "wav" | "mp3" | "mp4" = "wav";

    @doc("""
      Direction of the audio to record: "speak" for what party says, "listen" for what party hears.
      Default is `"speak"`.
      """)
    @example("speak")
    direction?: "speak" | "listen" = "speak";

    @doc("String of digits that will stop the recording when pressed. Default is `\"#\"`.")
    @example("#")
    terminators?: string = "#";

    @doc("""
      Play a beep before recording.
      Default is `false`.
      """)
    @example(true)
    beep?: boolean | SWMLVar = false;

    @doc("""
      How sensitive the recording voice activity detector is to background noise.
      A larger value is more sensitive. Allowed values from 0.0 to 100.0.
      Default is `44.0`.
      """)
    @example(44.0)
    input_sensitivity?: float | SWMLVar = 44.0;

    @doc("""
      Time in seconds to wait for the start of speech.
      Default is `4.0` seconds.
      """)
    @example(4.0)
    initial_timeout?: float | SWMLVar = 4.0;

    @doc("""
      Time in seconds to wait in silence before ending the recording.
      Default is `5.0` seconds.
      """)
    @example(5.0)
    end_silence_timeout?: float | SWMLVar = 5.0;

    @doc("Maximum length of the recording in seconds.")
    @example(60)
    max_length?: float | SWMLVar;

    @doc("URL to send recording status events to.")
    @example("https://example.com/recording-status")
    status_url?: url;
  };
}
