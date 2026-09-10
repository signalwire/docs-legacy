@summary("SayAction object")
model SayAction {
  @doc("A message to be spoken by the AI agent.")
  @summary("say")
  @example("Welcome to Franklin's Pizza.")
  say: string;
}
