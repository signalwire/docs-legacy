@summary("defaults")
model SWAIGDefaults {
  @doc("Default URL to send status callbacks and reports to. Authentication can also be set in the url in the format of `username:password@url.`")
  @example("username:password@https://example.com")
  web_hook_url?: string;
}
