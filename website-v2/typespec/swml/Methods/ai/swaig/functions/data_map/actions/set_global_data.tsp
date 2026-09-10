@summary("set_global_data Action")
model SetGlobalDataAction {
  @doc("A JSON object containing any global data, as a key-value map. This action sets the data in the `global_data` to be globally referenced.")
  @summary("set_global_data")
  @example(#{ order_id: "ord_456", customer_tier: "premium" })
  set_global_data: {
    ...TypeSpec.Record<unknown>;
  };
}
