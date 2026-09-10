@summary("native_functions")
enum SWAIGNativeFunction {
  @doc("Returns the current time for the time zone set in ai.local_tz.")
  check_time,

  @doc("Waits for the given time")
  wait_seconds,
}
