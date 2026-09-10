@summary("UnsetMetaDataAction object")
model UnsetMetaDataAction {
  @summary("unset_meta_data")
  @doc("The key of the local data to unset from the `meta_data`. You can also reset the `meta_data` by passing in a new object.")
  @example("extra_cheese")
  unset_meta_data: string | {};
}
