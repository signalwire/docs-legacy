import "@typespec/json-schema";
import "./contexts";
import "../_shared/pom.tsp";
import "../../../Shared/Types/main.tsp";

using TypeSpec.JsonSchema;

model AIPromptBase {
  @doc("Limits the amount of tokens that the AI agent may generate when creating its response")
  @minValue(0)
  @maxValue(4096)
  @example(256)
  max_tokens?: int32 = 256;

  @doc("Randomness setting. Float value between 0.0 and 1.5. Closer to 0 will make the output less random. **Default:** `1.0`.")
  @minValue(0.0)
  @maxValue(1.5)
  @example(0.7)
  temperature?: float | SWMLVar = 1.0;

  @doc("Randomness setting. Alternative to `temperature`. Float value between 0.0 and 1.0. Closer to 0 will make the output less random. **Default:** `1.0`.")
  @minValue(0.0)
  @maxValue(1.0)
  @example(0.9)
  top_p?: float | SWMLVar = 1.0;

  @doc("""
    Threshold to fire a speech-detect event at the end of the utterance. Float value between 0.0 and 1.0.
    Decreasing this value will reduce the pause after the user speaks, but may introduce false positives.
    **Default:** `0.6`.
    """)
  @minValue(0.0)
  @maxValue(1.0)
  @example(0.6)
  confidence?: float | SWMLVar = 0.6;

  @doc("Aversion to staying on topic. Float value between -2.0 and 2.0. Positive values increase the model's likelihood to talk about new topics. **Default:** `0`.")
  @minValue(-2.0)
  @maxValue(2.0)
  @example(0.0)
  presence_penalty?: float | SWMLVar = 0;

  @doc("Aversion to repeating lines. Float value between -2.0 and 2.0. Positive values decrease the model's likelihood to repeat the same line verbatim. **Default:** `0`.")
  @minValue(-2.0)
  @maxValue(2.0)
  @example(0.0)
  frequency_penalty?: float | SWMLVar = 0;
}

@summary("Prompt with POM")
model AIPromptPom is AIPromptBase {
  @doc("""
    Prompt Object Model (POM) is a structured data format for composing, organizing, and rendering prompt instructions for AI agents.
    POM ensures that the prompt is structured in a way that is best for the AI agent to understand and execute.
    The first item in the array MUST be FirstPOMSection (with optional title).
    All subsequent items MUST be PomSection (with required title and body).
    """)
  @minItems(1)
  pom: POM[];

  @doc("""
    An object that defines the context steps for the AI. The context steps are used to define the flow of the conversation.
    Every context object requires a `default` key, which is the default context to use at the beginning of the conversation.
    Additionally, more context steps can be defined as any other key in the object.
    """)
  contexts?: Contexts;
}

@summary("Prompt with Text")
model AIPromptText is AIPromptBase {
  @doc("The instructions to send to the agent.")
  @example("Your name is Franklin and you are taking orders for Franklin's Pizza. Begin by greeting the caller, and ask if they'd like to place an order for pickup or delivery.")
  text: string;

  @doc("""
    An object that defines the context steps for the AI. The context steps are used to define the flow of the conversation.
    Every context object requires a `default` key, which is the default context to use at the beginning of the conversation.
    Additionally, more context steps can be defined as any other key in the object.
    """)
  contexts?: Contexts;
}

@summary("Post-Prompt with Text")
model AIPostPromptText is AIPromptBase {
  @doc("The instructions to send to the agent.")
  @example("Summarize the conversation and provide any follow-up action items.")
  text: string;
}

@summary("Post-Prompt with POM")
model AIPostPromptPom is AIPromptBase {
  @doc("The instructions to send to the agent.")
  @minItems(1)
  pom: POM[];
}

@oneOf
union AIPrompt {
  AIPromptText,
  AIPromptPom,
}

union AIPostPrompt {
  AIPostPromptText,
  AIPostPromptPom,
}
