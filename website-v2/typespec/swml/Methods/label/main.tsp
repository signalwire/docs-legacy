@summary("label Method")
model Label {
  @doc("Mark any point of the SWML section with a label so that goto can jump to it.")
  @example("greeting")
  label: string;
}
