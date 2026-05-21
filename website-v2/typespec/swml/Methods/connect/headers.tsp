@summary("ConnectHeaders object")
model ConnectHeaders {
  @doc("The name of the header.")
  @example("X-Custom-Header")
  name: string;

  @doc("The value of the header.")
  @example("custom-value")
  value: string;
}
