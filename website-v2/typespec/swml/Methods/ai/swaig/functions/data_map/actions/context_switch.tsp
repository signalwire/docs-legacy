@summary("context_switch Action")
model ContextSwitchAction {
  @doc("A JSON object containing the context to switch to. Default is not set.")
  @summary("context_switch")
  context_switch: {
    @doc("The instructions to send to the agent. Default is not set.")
    @example("You are now a billing specialist. Help the customer with their billing inquiry.")
    system_prompt: string;

    @doc("Whether to consolidate the context. Default is `false`.")
    @example(true)
    consolidate?: boolean | SWMLVar;

    @doc("""
      A string serving as simulated user input for the AI Agent.
      During a context_switch in the AI's prompt, the user_prompt offers the AI pre-established context or guidance.
      Default is not set
      """)
    @example("I need help with my recent invoice.")
    user_prompt?: string;
  };
}
