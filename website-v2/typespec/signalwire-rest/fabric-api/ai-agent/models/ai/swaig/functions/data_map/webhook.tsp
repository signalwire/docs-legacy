import "./expression.tsp";

@summary("Webhook object")
model Webhook {
  @doc("An array of objects that define external API calls.")
  @summary("webhooks")
  webhooks: {
    @doc("A list of expressions to be evaluated upon matching.")
    expressions?: Expression[];

    @doc("A string or array of strings that represent the keys to be used for error handling. This will match the key(s) in the response from the API call.")
    @example("failed")
    error_keys?: string | string[];

    @doc("The endpoint for the external service or API.")
    @example("https://example.com")
    url: string;

    @doc("Iterates over an array of objects and processes a output based on each element in the array. Works similarly to JavaScript's forEach method.")
    foreach?: {
      @doc("The key to be used to access the current element in the array.")
      @example("success")
      input_key: string;

      @doc("The key that can be referenced in the output of the `foreach` iteration. The values that are stored from `append` will be stored in this key.")
      @example("deliverer")
      output_key: string;

      @doc("The max amount of elements that are iterated over in the array. This will start at the beginning of the array.")
      @example(5)
      max?: integer;

      @doc("""
        The values to append to the output_key.
        Properties from the object can be referenced and added to the output_key by using the following syntax:
        \${this.property_name}.
        The `this` keyword is used to reference the current object in the array.
        """)
      append: string;
    };

    @doc("Any necessary headers for the API call.")
    headers?: {
      ...TypeSpec.Record<unknown>;
    };

    @doc("The HTTP method (GET, POST, etc.) for the API call.")
    method?: "GET" | "POST" | "PUT" | "DELETE";

    @doc("A boolean to determine if the input arguments should be passed as parameters.")
    input_args_as_params?: boolean;

    @doc("An object of any necessary parameters for the API call. The key is the parameter name and the value is the parameter value.")
    params?: {
      ...TypeSpec.Record<unknown>;
    };

    @doc("A string or array of strings that represent the `arguments` that are required to make the webhook request.")
    require_args?: string | string[];

    ...Output;
  }[];
}
