@summary("return Method")
model Return {
  @summary("return")
  @doc("Return a value from an execute call or exit the script. The value can be any type.")
  @example(#{ status: "success", result: "completed" })
  `return`: unknown;
}
