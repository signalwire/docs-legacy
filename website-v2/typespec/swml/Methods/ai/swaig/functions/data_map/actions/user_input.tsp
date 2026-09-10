@summary("user_input Action")
model UserInputAction {
  @summary("user_input")
  @doc("Used to inject text into the users queue as if they input the data themselves.")
  @example("I would like to speak to a manager")
  user_input: string;
}
