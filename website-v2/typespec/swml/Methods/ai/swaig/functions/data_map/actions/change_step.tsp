@summary("change_step Action")
model ChangeStepAction {
  @doc("The name of the step to switch to. The step must be defined in the current context's steps array.")
  @summary("change_step")
  @example("confirm_order")
  change_step: string;
}
