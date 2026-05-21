@summary("unset Method")
model Unset {
  @summary("unset")
  @doc("""
    Unset specified variables. The variables may have been set using the set method
    or as a byproduct of other statements or methods.
    Accepts a single variable name as a string or an array of variable names.
    """)
  @example("temp_data")
  unset: string | string[];
}
