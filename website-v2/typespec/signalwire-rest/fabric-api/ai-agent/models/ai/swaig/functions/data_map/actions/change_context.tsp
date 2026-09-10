@summary("ChangeContextAction object")
model ChangeContextAction {
  @doc("The name of the context to switch to. The context must be defined in the AI's prompt.contexts configuration.")
  @summary("change_context")
  change_context: string;
}
