import "./core.tsp";
import "../../_shared/const.tsp";
import "../../_shared/enums.tsp";

model CXMLScriptCreateRequest {
  @doc("Display name of the cXML Script")
  @example("Reception Script")
  display_name: string;

  @doc("The cXML script contents")
  @example(CXML_EXAMPLE)
  contents: string;

  @doc("URL to send status callbacks to")
  @example("https://example.com/status")
  @format("uri")
  status_callback_url?: url;

  @doc("HTTP method to use for status callbacks")
  @example(UrlMethodType.Get)
  status_callback_method?: UrlMethodType.Get | UrlMethodType.Post;
}

model CXMLScriptUpdateRequest {
  @doc("Display name of the cXML Script")
  @example("Reception Script")
  display_name?: string;

  @doc("The cXML script contents")
  @example(CXML_EXAMPLE)
  contents?: string;

  @doc("URL to send status callbacks to")
  @example("https://example.com/status")
  @format("uri")
  status_callback_url?: url;

  @doc("HTTP method to use for status callbacks")
  @example(UrlMethodType.Get)
  status_callback_method?: UrlMethodType.Get | UrlMethodType.Post;
}
