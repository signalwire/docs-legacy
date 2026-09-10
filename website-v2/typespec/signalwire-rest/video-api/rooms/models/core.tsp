import "../../_shared/models.tsp";

@doc("The room's layout.")
enum RoomLayout {
  @doc("Responsive grid layout")
  `grid-responsive`,

  @doc("Responsive grid layout for mobile")
  `grid-responsive-mobile`,

  @doc("Highlight 1 responsive layout")
  `highlight-1-responsive`,

  @doc("1x1 layout")
  `1x1`,

  @doc("2x1 layout")
  `2x1`,

  @doc("2x2 layout")
  `2x2`,

  @doc("5up layout")
  `5up`,

  @doc("3x3 layout")
  `3x3`,

  @doc("4x4 layout")
  `4x4`,

  @doc("5x5 layout")
  `5x5`,

  @doc("6x6 layout")
  `6x6`,

  @doc("8x8 layout")
  `8x8`,

  @doc("10x10 layout")
  `10x10`,
}
