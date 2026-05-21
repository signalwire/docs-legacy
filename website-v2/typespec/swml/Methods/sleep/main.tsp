import "@typespec/json-schema";
import "../../Shared/Types/main.tsp";
using TypeSpec.JsonSchema;

@summary("sleep Method")
model Sleep {
  @summary("sleep")
  @doc("Pause execution for a specified duration.")
  sleep: {
    @doc("""
      The amount of time to sleep in milliseconds.
      Must be a positive integer. Can also be set to `-1` for the sleep to never end.
      """)
    @minValue(-1)
    @example(5000)
    duration: integer | SWMLVar;
  } | integer | SWMLVar;
}
