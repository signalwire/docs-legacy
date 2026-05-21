@summary("set_meta_data Action")
model SetMetaDataAction {
  @summary("set_meta_data")
  @doc("A JSON object containing any metadata, as a key-value map. This action sets the data in the `meta_data` to be referenced locally in the function.")
  @example(#{ last_action: "lookup", retry_count: 2 })
  set_meta_data: {
    ...TypeSpec.Record<unknown>;
  };
}
