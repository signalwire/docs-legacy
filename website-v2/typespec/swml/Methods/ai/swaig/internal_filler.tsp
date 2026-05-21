import "../_shared/fillers.tsp";

model SWAIGInternalFiller {
  @doc("Filler phrases played when the AI Agent is hanging up the call.")
  hangup?: FunctionFillers;

  @doc("Filler phrases played when the AI Agent is checking the time.")
  check_time?: FunctionFillers;

  @doc("Filler phrases played when the AI Agent is waiting for user input.")
  wait_for_user?: FunctionFillers;

  @doc("Filler phrases played during deliberate pauses or wait periods.")
  wait_seconds?: FunctionFillers;

  @doc("Filler phrases played when the AI Agent is adjusting response timing.")
  adjust_response_latency?: FunctionFillers;

  @doc("Filler phrases played when transitioning between conversation steps when utilizing `prompt.contexts`.")
  next_step?: FunctionFillers;

  @doc("Filler phrases played when switching between conversation contexts when utilizing `prompt.contexts`.")
  change_context?: FunctionFillers;

  @doc("Filler phrases played when the AI Agent is processing visual input. This function is enabled when `enable_vision` is set to `true` in `ai.params`.")
  get_visual_input?: FunctionFillers;

  @doc("Filler phrases played when the AI Agent is thinking or considering options. This is utilized when `enable_thinking` is set to `true` in `ai.params`.")
  get_ideal_strategy?: FunctionFillers;
}
