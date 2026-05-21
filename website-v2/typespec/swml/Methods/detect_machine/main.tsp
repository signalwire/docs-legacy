import "../../Shared/Types/main.tsp";

@summary("detect_machine Method")
model DetectMachine {
  @doc("""
    A detection method that combines AMD (Answering Machine Detection) and fax detection.
    Detect whether the user on the other end of the call is a machine (fax, voicemail, etc.) or a human.
    The detection result(s) will be sent to the specified status_url as a POST request
    and will also be saved in the detect_result variable.
    """)
  detect_machine: {
    @doc("If `true`, stops detection on beep / end of voicemail greeting. Default `false`.")
    @example(true)
    detect_message_end?: boolean | SWMLVar = false;

    @doc("Comma-separated string of detectors to enable. Valid values: `amd`, `fax`.")
    @example("amd,fax")
    detectors?: string = "amd,fax";

    @doc("How long to wait for voice to finish. Default `1.0`.")
    @minValue(0.0)
    @example(1.0)
    end_silence_timeout?: float | SWMLVar = 1.0;

    @doc("How long to wait for initial voice before giving up. Default `4.5`.")
    @minValue(0.0)
    @example(4.5)
    initial_timeout?: float | SWMLVar = 4.5;

    @doc("How long to wait for voice to finish before firing READY event. Default is `end_silence_timeout`.")
    @minValue(0.0)
    @example(2.0)
    machine_ready_timeout?: float | SWMLVar;

    @doc("The number of seconds of ongoing voice activity required to classify as MACHINE. Default `1.25`.")
    @minValue(0.0)
    @example(1.25)
    machine_voice_threshold?: float | SWMLVar = 1.25;

    @doc("The minimum number of words that must be detected in a single utterance before classifying the call as MACHINE. Default `6`.")
    @minValue(0)
    @example(6)
    machine_words_threshold?: integer | SWMLVar = 6;

    @doc("The http(s) URL to deliver detector events to.")
    @example("https://example.com/amd-status")
    status_url?: url;

    @doc("The max time to run detector. Default `30.0` seconds.")
    @minValue(0.0)
    @example(30.0)
    timeout?: float | SWMLVar = 30.0;

    @doc("The tone to detect, will only receive remote side tone. Default `CED`.")
    @example("CED")
    tone?: "CED" | "CNG" = "CED";

    @doc("""
      If false, the detector will run asynchronously and status_url must be set.
      If true, the detector will wait for detection to complete before moving to the next SWML instruction.
      Default is `true`.
      """)
    @example(true)
    wait?: boolean | SWMLVar = true;
  };
}
