import "../../Methods";

@summary("prompt Method")
model Prompt {
  @summary("prompt")
  @doc("""
    Play a prompt and wait for input. The input can be received either as digits from the keypad,
    or from speech, or both depending on what parameters are set.
    By default, only digit input is enabled. To enable speech input, set at least one speech parameter.
    To enable both digit and speech input, set at least one parameter for each.
    """)
  prompt: {
    @doc("""
      URL or array of URLs to play.
      Allowed URLs are:
          http:// or https:// - audio file to GET
          ring:[duration:]<country code> - ring tone to play. For example: ring:us to play single ring or ring:20.0:us to play ring for 20 seconds.
          say:<text to speak> - Sentence to say
          silence: <duration> - seconds of silence to play
      """)
    @example("say:Please press 1 for sales or 2 for support")
    play: play_url | play_url[] | SWMLVar | SWMLVar[];

    @doc("""
      Volume level for the audio file.
      Default is `0`.
      Valid range is -40 to 40.
      """)
    @minValue(-40.0)
    @maxValue(40.0)
    @example(0)
    volume?: float = 0;

    @doc("The voice to use for the text to speech.")
    @example("Polly.Joanna")
    say_voice?: string = "Polly.Salli";

    @doc("The language to use for the text to speech.")
    @example("en-US")
    say_language?: string = "en-US";

    @doc("The gender to use for the text to speech.")
    @example("female")
    say_gender?: string = "female";

    @doc("""
      Number of digits to collect.
      Default is `1`.
      """)
    @example(4)
    max_digits?: integer | SWMLVar = 1;

    @doc("""
      Digits that terminate digit collection.
      Default is not set.
      """)
    @example("#")
    terminators?: string;

    @doc("""
      Time in seconds to wait for next digit.
      Default is `5.0` seconds.
      """)
    @example(5.0)
    digit_timeout?: float | SWMLVar = 5.0;

    @doc("""
      Time in seconds to wait for start of input.
      Default is `5.0` seconds.
      """)
    @example(10.0)
    initial_timeout?: float | SWMLVar = 5.0;

    @doc("Max time in seconds to wait for speech result.")
    @example(15.0)
    speech_timeout?: float | SWMLVar;

    @doc("Time in seconds to wait for end of speech utterance.")
    @example(2.0)
    speech_end_timeout?: float | SWMLVar;

    @doc("Language to detect speech in.")
    @example("en-US")
    speech_language?: string;

    @doc("Expected words or phrases to help the speech recognition.")
    @example(#["sales", "support", "billing"])
    speech_hints?: string[] | SWMLVar[];

    @doc("""
      The engine that is selected for speech recognition. The engine must support the specified language.
      [Deepgram|Google| etc...] Default is not set (SignalWire picks the engine).
      """)
    @example("Deepgram")
    speech_engine?: string;

    @doc("http or https URL to deliver prompt status events")
    @example("https://example.com/prompt-status")
    status_url?: url;
  };
}
