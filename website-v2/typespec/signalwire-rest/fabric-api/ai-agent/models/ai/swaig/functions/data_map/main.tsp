import "./output.tsp";
import "./expression.tsp";
import "./webhook.tsp";
import "@typespec/openapi3";

using TypeSpec.OpenAPI;

@oneOf
@summary("DataMap union")
union DataMap {
  @doc("An object that defines the output of the SWAIG function.")
  Output,

  @doc("An array of objects that define patterns and corresponding actions.")
  Expression,

  @doc("An array of objects that define external API calls.")
  Webhook,
}
