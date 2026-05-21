import "@typespec/json-schema";
import "./output.tsp";

using TypeSpec.JsonSchema;

@summary("Expression object")
model Expression {
  @doc("The actual input or value from the user or system.")
  @example("I want a refund")
  string: string;

  @doc("A regular expression pattern to validate or match the string.")
  @example("refund|return|money back")
  pattern: string;

  @doc("An object that contains a response and a list of actions to be performed upon a expression match.")
  output: Output;
}
