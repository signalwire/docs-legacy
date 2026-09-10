import "@typespec/json-schema";
import "./output.tsp";
import "./expression.tsp";
import "./webhook.tsp";

using TypeSpec.JsonSchema;

@summary("DataMap object")
model DataMap {
  @doc("""
    An object that contains a response and a list of actions to be performed upon a SWAIG function call.
    This functions like a return statement in a function.
    """)
  output?: Output;

  @doc("An array of objects that have pattern matching logic to process the user's input data. A user can define multiple expressions to match against the user's input data.")
  expressions?: Expression[];

  @doc("An array of objects that define external API calls.")
  webhooks?: Webhook[];
}
