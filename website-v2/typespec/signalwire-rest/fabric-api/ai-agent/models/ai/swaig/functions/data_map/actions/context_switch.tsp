@summary("ContextSwitchAction object")
model ContextSwitchAction {
  @doc("A JSON object containing the context to switch to. Default is not set.")
  @summary("context_switch")
  context_switch: {
    @doc("The instructions to send to the agent. Default is not set.")
    system_prompt: string;

    @doc("Whether to consolidate the context. Default is `false`.")
    consolidate?: boolean;

    @doc("""
      A string serving as simulated user input for the AI Agent.
      During a context_switch in the AI's prompt, the user_prompt offers the AI pre-established context or guidance.
      Default is not set
      """)
    user_prompt?: string;
  };
}
