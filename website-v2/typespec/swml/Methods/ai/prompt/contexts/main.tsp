import "./steps.tsp";
import "../../_shared/pom.tsp";
import "../../_shared/fillers.tsp";

using TypeSpec.JsonSchema;

@summary("contexts")
model Contexts {
  @doc("The default context to use at the beginning of the conversation. Additional context steps can be defined as any other key in the object.")
  default: ContextsObject;

  ...TypeSpec.Record<ContextsObject>;
}

model ContextObjectBase {
  @summary("steps")
  @doc("An array of step objects that define the conversation flow for this context. Steps execute sequentially unless otherwise specified.")
  steps: ContextSteps[];

  @doc("When `true`, resets conversation history to only the system prompt when entering this context. Useful for focused tasks that shouldn't be influenced by previous conversation. **Default:** `false`.")
  @example(true)
  isolated?: boolean = false;

  @doc("Language-specific filler phrases played when transitioning into this context. Helps provide smooth context switches.")
  enter_fillers?: FunctionFillers[];

  @doc("Language-specific filler phrases played when leaving this context. Ensures natural transitions out of specialized modes.")
  exit_fillers?: FunctionFillers[];
}

@summary("ContextsPOMObject")
model ContextsPOMObject is ContextObjectBase {
  @doc("An array of objects that define the POM for the context. POM is the Post-Prompt Object Model, which is used to define the flow of the conversation.")
  @minItems(1)
  pom?: POM[];
}

model ContextsTextObject is ContextObjectBase {
  @doc("The text to send to the agent.")
  @example("You are now helping the customer with their order.")
  text?: string;
}

union ContextsObject {
  ContextsPOMObject,
  ContextsTextObject,
}
