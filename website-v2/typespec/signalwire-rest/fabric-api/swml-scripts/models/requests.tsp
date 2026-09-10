import "./core.tsp";
import "../../_shared/const.tsp";

model SwmlScriptCreateRequest {
  @doc("Display name of the SWML Script")
  @example("Welcome Script")
  name: string;

  @doc("The contents of the SWML script.")
  @example(SWML_EXAMPLE)
  contents: string;

  @doc("URL to send status callbacks to")
  @example("https://example.com/status")
  @format("uri")
  status_callback_url?: url;
}

model SwmlScriptUpdateRequest {
  @doc("Display name of the SWML Script")
  @example("Welcome Script")
  display_name?: string;

  @doc("The contents of the SWML script.")
  @example(SWML_EXAMPLE)
  contents?: string;

  @doc("URL to send status callbacks to")
  @example("https://example.com/status")
  @format("uri")
  status_callback_url?: url;
}
