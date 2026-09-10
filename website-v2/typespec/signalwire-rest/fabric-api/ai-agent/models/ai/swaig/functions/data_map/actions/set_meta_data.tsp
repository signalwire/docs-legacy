@summary("SetMetaDataAction object")
model SetMetaDataAction {
  @summary("set_meta_data")
  @doc("A JSON object containing any metadata, as a key-value map. This action sets the data in the `meta_data` to be referenced locally in the function.")
  @example(#{ extra_cheese: "Can't do", extra_large_pizza: "Only on Friday" })
  set_meta_data: {
    ...TypeSpec.Record<unknown>;
  };
}
