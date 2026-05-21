import "@typespec/json-schema";
import "../../Shared/Types/main.tsp";
using TypeSpec.JsonSchema;

@summary("TranslateDirection enum")
enum TranslateDirection {
  @doc("Translate the remote caller.")
  `remote-caller`,

  @doc("Translate the local caller.")
  `local-caller`,
}

@summary("Filter Presets")
@doc("""
  Preset translation filter values that adjust the tone or style of translated speech.
  
  - `polite` - Translates to a polite version, removing anything insulting while maintaining sentiment
  - `rude` - Translates to a rude and insulting version while maintaining sentiment
  - `professional` - Translates to sound professional, removing slang or lingo
  - `shakespeare` - Translates to sound like Shakespeare, speaking in iambic pentameter
  - `gen-z` - Translates to use Gen-Z slang and expressions
  """)
enum TranslationFilterPreset {
  polite,
  rude,
  professional,
  shakespeare,
  `gen-z`,
}

@summary("Custom Filter")
@doc("Custom translation filter with a prompt prefix. Use `prompt:` followed by your custom instructions (e.g., `prompt:Use formal business language`).")
@pattern("^prompt:.+$")
scalar CustomTranslationFilter extends string;

alias TranslationFilter = TranslationFilterPreset | CustomTranslationFilter;

@summary("StartAction object")
model StartAction {
  @doc("Starts live translation of the call. The translation will be sent to the specified URL.")
  start: {
    @doc("The webhook URL to be called.")
    @example("https://example.com/translation-webhook")
    webhook?: string;

    @doc("The language to translate from.")
    @example("en-US")
    from_lang: string;

    @doc("The language to translate to.")
    @example("es-ES")
    to_lang: string;

    @doc("The TTS voice you want to use for the source language.")
    @example("Polly.Joanna")
    from_voice?: string;

    @doc("The TTS voice you want to use for the target language.")
    @example("Polly.Lucia")
    to_voice?: string;

    @doc("Translation filter for the source language direction.")
    filter_from?: TranslationFilter;

    @doc("Translation filter for the target language direction.")
    filter_to?: TranslationFilter;

    @doc("Whether to enable live events.")
    @example(true)
    live_events?: boolean | SWMLVar;

    @doc("Whether to enable AI summarization.")
    @example(true)
    ai_summary?: boolean | SWMLVar;

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

    @doc("The direction of the call that should be translated.")
    direction: TranslateDirection[];

    @doc("The speech engine to use for speech recognition.")
    @example(SpeechEngine.google)
    speech_engine?: SpeechEngine = SpeechEngine.deepgram;

    @doc("The AI prompt that instructs how to summarize the conversation when `ai_summary` is enabled.")
    @example("Summarize the key points of this bilingual conversation.")
    ai_summary_prompt?: string;
  };
}

@oneOf
@summary("SummarizeAction union")
union SummarizeActionUnion {
  SummarizeAction,

  @doc("Summarizes the conversation as a string value.")
  "summarize",
}

@summary("SummarizeAction object")
model SummarizeAction {
  @doc("Summarizes the conversation as an object, allowing you to specify the webhook url and prompt for the summary.")
  summarize: {
    @doc("The webhook URL to be called.")
    @example("https://example.com/summary-webhook")
    webhook?: string;

    @doc("The AI prompt that instructs how to summarize the conversation.")
    @example("Provide a brief summary of the translated conversation.")
    prompt?: string;
  };
}

@summary("InjectAction object")
model InjectAction {
  @doc("Injects a message into the conversation to be translated and spoken to the specified party.")
  inject: {
    @doc("The message to be injected")
    @example("Please hold while I transfer you to a specialist.")
    message: string;

    @doc("The direction of the message.")
    direction: TranslateDirection;
  };
}

@oneOf
@summary("TranslateAction union")
union TranslateAction {
  StartAction,

  @doc("Stops live translation of the call.")
  "stop",

  SummarizeActionUnion,
  InjectAction,
}

@summary("live_translate Method")
model LiveTranslate {
  @summary("live_translate")
  @doc("Start live translation of the call. The translation will be sent to the specified webhook URL.")
  live_translate: {
    @doc("The action to perform during live translation.")
    action: TranslateAction;
  };
}
