import "@typespec/json-schema";
import "../../Shared/Types/main.tsp";
using TypeSpec.JsonSchema;

@summary("TranscribeDirection enum")
enum TranscribeDirection {
  @doc("Transcribe the remote caller.")
  `remote-caller`,

  @doc("Transcribe the local caller.")
  `local-caller`,
}

@summary("TranscribeStartAction object")
model TranscribeStartAction {
  @doc("Starts live transcription of the call. The transcription will be sent to the specified URL.")
  start: {
    @doc("Enables AI summarization of the transcription. The summary will be sent to the specified URL at the end of the conversation.")
    @example(true)
    ai_summary?: boolean | SWMLVar;

    @doc("The webhook URL the transcription will be sent to.")
    @example("https://example.com/transcription-webhook")
    webhook?: string;

    @doc("The language to transcribe.")
    @example("en-US")
    lang: string;

    @doc("Whether to enable live events.")
    @example(true)
    live_events?: boolean | SWMLVar;

    @doc("The timeout for speech recognition in milliseconds.")
    @example(30000)
    speech_timeout?: integer | SWMLVar = 60000;

    @doc("Voice activity detection silence time in milliseconds. Default depends on speech engine: `300` for Deepgram, `500` for Google.")
    @example(500)
    vad_silence_ms?: integer | SWMLVar = 300;

    @doc("Voice activity detection threshold (0-1800).")
    @example(400)
    vad_thresh?: integer | SWMLVar = 400;

    @doc("Debug level for logging (0-2).")
    @example(0)
    debug_level?: integer | SWMLVar = 0;

    @doc("The direction of the call that should be transcribed.")
    direction: TranscribeDirection[];

    @doc("The speech engine to use for speech recognition.")
    @example(SpeechEngine.google)
    speech_engine?: SpeechEngine = SpeechEngine.deepgram;

    @doc("The AI prompt that instructs how to summarize the conversation when `ai_summary` is enabled.")
    @example("Summarize the key points of this conversation.")
    ai_summary_prompt?: string;
  };
}

@oneOf
@summary("TranscribeSummarizeAction union")
union TranscribeSummarizeActionUnion {
  TranscribeSummarizeAction,

  @doc("Summarizes the conversation as a string value.")
  "summarize",
}

@summary("TranscribeSummarizeAction object")
model TranscribeSummarizeAction {
  @doc("Summarizes the conversation as an object, allowing you to specify the webhook url and prompt for the summary.")
  summarize: {
    @doc("The webhook URL to be called.")
    @example("https://example.com/summary-webhook")
    webhook?: string;

    @doc("The prompt for summarization.")
    @example("Provide a brief summary of the conversation including main topics discussed.")
    prompt?: string;
  };
}

@oneOf
@summary("TranscribeAction union")
union TranscribeAction {
  TranscribeStartAction,

  @doc("Stops live transcription of the call.")
  "stop",

  TranscribeSummarizeActionUnion,
}

@summary("live_transcribe Method")
model LiveTranscribe {
  @summary("live_transcribe")
  @doc("Start live transcription of the call. The transcription will be sent to the specified webhook URL.")
  live_transcribe: {
    @doc("The action to perform during live transcription.")
    action: TranscribeAction;
  };
}
