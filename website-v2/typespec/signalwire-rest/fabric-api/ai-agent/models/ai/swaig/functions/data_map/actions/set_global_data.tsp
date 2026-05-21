@summary("SetGlobalDataAction object")
model SetGlobalDataAction {
  @doc("A JSON object containing any global data, as a key-value map. This action sets the data in the `global_data` to be globally referenced.")
  @summary("set_global_data")
  @example(#{ small_size: "8 Inch", large_size: "12 Inch", closed: "Monday" })
  set_global_data: {
    ...TypeSpec.Record<unknown>;
  };
}
