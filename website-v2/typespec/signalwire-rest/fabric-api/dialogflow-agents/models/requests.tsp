import "./core.tsp";

model DialogflowAgentUpdateRequest {
  @doc("Name of the Dialogflow Agent")
  @example("Booking Assistant")
  name?: string;

  @doc("Whether to enable the 'say' feature")
  @example(true)
  say_enabled?: boolean;

  @doc("Default message to say")
  @example("Welcome to the Booking Assistant")
  say?: string;

  @doc("Voice to use for speech")
  @example("en-US-Wavenet-D")
  voice?: string;
}
