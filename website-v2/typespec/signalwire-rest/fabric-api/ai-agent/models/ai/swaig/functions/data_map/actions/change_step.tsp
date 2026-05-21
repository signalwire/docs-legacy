@summary("ChangeStepAction object")
model ChangeStepAction {
  @doc("The name of the step to switch to. The step must be defined in the current context's steps array.")
  @summary("change_step")
  change_step: string;
}
