@summary("HangupAction object")
model HangupAction {
  @doc("Whether to hang up the call. When set to `true`, the call will be terminated after the AI agent finishes speaking.")
  @summary("hangup")
  hangup: boolean;
}
