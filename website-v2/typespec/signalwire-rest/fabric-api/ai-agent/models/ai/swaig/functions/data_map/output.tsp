import "./actions";

@summary("Output object")
model Output {
  @doc("An object that defines the `response` or `action` to be taken when the webhook is successfully triggered.")
  @summary("output")
  output: {
    @doc("A static response text or message returned to the AI agents context.")
    @example("Order placed")
    response: string;

    @doc("A list of actions to be performed upon matching.")
    action?: Action[];
  };
}
