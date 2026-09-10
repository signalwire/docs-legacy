import "./output.tsp";

@summary("Expression object")
model Expression {
  @doc("An array of objects that define patterns and corresponding actions.")
  @summary("expressions")
  expressions: {
    @doc("The actual input or value from the user or system.")
    @example("I want a refund")
    string: string;

    @doc("A regular expression pattern to validate or match the string.")
    pattern: string;

    ...Output;
  }[];
}
