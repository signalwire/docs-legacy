@summary("Pronounce object")
model Pronounce {
  @doc("The expression to replace.")
  @example("pizza")
  replace: string;

  @doc("The phonetic spelling of the expression.")
  @example("pissa")
  with: string;

  @doc("Whether the pronunciation replacement should ignore case.")
  ignore_case?: boolean;
}
