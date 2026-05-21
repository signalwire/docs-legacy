import "@typespec/json-schema";

using TypeSpec.JsonSchema;

@summary("native_functions")
enum SWAIGNativeFunction {
  @doc("Returns the current time for the time zone set in ai.local_tz.")
  check_time,

  @doc("Waits for the given time")
  wait_seconds,

  @doc("Use this function only when the user ask you to wait, hold on, or the equivalent. This will cause the AI to wait until the user speaks to it again.")
  wait_for_user,

  @doc("Adjust how long the agent will wait for the user to stop talking.")
  adjust_response_latency,
}
