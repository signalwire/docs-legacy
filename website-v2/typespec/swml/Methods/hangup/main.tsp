@summary("hangup Method")
model Hangup {
  @doc("End the call with an optional reason.")
  @summary("hangup")
  hangup: {
    @doc("The reason for hanging up the call.")
    @example("busy")
    reason?: "hangup" | "busy" | "decline";
  };
}
