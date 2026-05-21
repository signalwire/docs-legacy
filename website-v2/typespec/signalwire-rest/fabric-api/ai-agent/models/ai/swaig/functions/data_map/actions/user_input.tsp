@summary("UserInputAction object")
model UserInputAction {
  @summary("user_input")
  @doc("Used to inject text into the users queue as if they input the data themselves.")
  @example("I want a tasty Pizza.")
  user_input: string;
}
