@summary("ToggleFunctionsAction object")
model ToggleFunctionsAction {
  @summary("toggle_functions")
  @doc("Whether to toggle the functions on or off.")
  toggle_functions: {
    @doc("Whether to activate or deactivate the functions. Default is `true`")
    active: boolean;

    @doc("The function names to toggle.")
    @example("Discount")
    function: string | string[];
  }[];
}
