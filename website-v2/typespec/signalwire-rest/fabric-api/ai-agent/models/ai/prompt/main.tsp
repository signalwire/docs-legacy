import "./contexts";

@summary("AIPromptBase")
model AIPromptBase {
  @doc("The instructions to send to the agent.")
  @example("Your name is Franklin and you are taking orders for Franklin's Pizza. Begin by greeting the caller, and ask if they'd like to place an order for pickup or delivery.")
  text: string;

  @doc("Randomness setting. Float value between 0.0 and 1.5. Closer to 0 will make the output less random.")
  @minValue(0.0)
  @maxValue(1.5)
  temperature?: float;

  @doc("Randomness setting. Alternative to `temperature`. Float value between 0.0 and 1.0. Closer to 0 will make the output less random.")
  @minValue(0.0)
  @maxValue(1.0)
  top_p?: float;

  @doc("""
    Threshold to fire a speech-detect event at the end of the utterance. Float value between 0.0 and 1.0.
    Decreasing this value will reduce the pause after the user speaks, but may introduce false positives.
    """)
  @minValue(0.0)
  @maxValue(1.0)
  confidence?: float;

  @doc("Aversion to staying on topic. Float value between -2.0 and 2.0. Positive values increase the model's likelihood to talk about new topics.")
  @minValue(-2.0)
  @maxValue(2.0)
  presence_penalty?: float;

  @doc("Aversion to repeating lines. Float value between -2.0 and 2.0. Positive values decrease the model's likelihood to repeat the same line verbatim.")
  @minValue(-2.0)
  @maxValue(2.0)
  frequency_penalty?: float;
}

@summary("prompt")
model AIPrompt is AIPromptBase {
  @doc("""
    An object that defines the context steps for the AI. The context steps are used to define the flow of the conversation.
    Every context object requires a `default` key, which is the default context to use at the beginning of the conversation.
    Additionally, more context steps can be defined as any other key in the object.
    """)
  contexts?: Contexts;
}

@summary("post_prompt")
model AIPostPrompt is AIPromptBase;
