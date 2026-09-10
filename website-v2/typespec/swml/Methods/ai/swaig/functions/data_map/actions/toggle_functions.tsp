@summary("toggle_functions Action")
model ToggleFunctionsAction {
  @summary("toggle_functions")
  @doc("Whether to toggle the functions on or off.")
  toggle_functions: {
    @doc("Whether to activate or deactivate the functions. Default is `true`")
    @example(true)
    active: boolean | SWMLVar;

    @doc("The function names to toggle.")
    @example("Discount")
    function: string | string[];
  }[];
}
