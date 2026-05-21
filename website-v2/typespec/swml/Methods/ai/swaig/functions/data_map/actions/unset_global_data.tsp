@summary("unset_global_data Action")
model UnsetGlobalDataAction {
  @summary("unset_global_data")
  @doc("The key of the global data to unset from the `global_data`. You can also reset the `global_data` by passing in a new object.")
  @example("session_id")
  unset_global_data: string | {};
}
