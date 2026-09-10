import "../ai";

union BedrockPickedParams {
  "hard_stop_time",
  "inactivity_timeout",
  "attention_timeout",
  "video_talking_file",
  "video_idle_file",
  "video_listening_file",
}

model BedrockParams {
  ...PickProperties<AIParams, BedrockPickedParams>;

  @doc("""
    A final prompt that is fed into the AI when the `hard_stop_time` is reached.
    """)
  @example("Thank you for calling. The maximum call time has been reached. Goodbye!")
  hard_stop_prompt?: string = "The time limit for this call has been reached. Please wrap up the conversation.";

  ...TypeSpec.Record<unknown>;
}
