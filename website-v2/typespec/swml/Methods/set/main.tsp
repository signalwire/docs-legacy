@summary("set Method")
model Set {
  @summary("set")
  @doc("""
    Set script variables to the specified values.
    Accepts an object mapping variable names to values.
    Variables set using set can be removed using unset.
    """)
  @example(#{ my_var: "hello", counter: 1, is_valid: true })
  set: {
    ...TypeSpec.Record<unknown>;
  };
}
