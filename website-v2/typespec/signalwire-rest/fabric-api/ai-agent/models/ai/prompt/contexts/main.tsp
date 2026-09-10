import "./steps.tsp";

@summary("contexts")
model Contexts {
  @doc("The default context to use at the beginning of the conversation. Additional context steps can be defined as any other key in the object.")
  default: ContextSteps;

  ...TypeSpec.Record<ContextSteps>;
}
