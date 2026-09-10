@summary("includes")
model SWAIGIncludes {
  @doc("Remote functions to fetch and include in your AI application.")
  @example(#["transfer call", "notify kitchen"])
  functions: string[];

  @doc("URL to fetch remote functions and include in your AI application. Authentication can also be set in the url in the format of `username:password@url`.")
  @example("username:password@https://example.com")
  url: string;

  @doc("")
  meta_data?: {
    ...TypeSpec.Record<unknown>;
  };
}
