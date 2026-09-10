@summary("stop Action")
model StopAction {
  @summary("stop")
  @doc("Whether to stop the conversation.")
  @example(true)
  stop: boolean | SWMLVar;
}
