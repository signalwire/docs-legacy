import "../../_shared/enums.tsp";

model CXMLWebhookCreateRequest {
  @doc("Name of the CXML Webhook.")
  @example("My CXML Webhook")
  name?: string;

  @doc("Used for of the CXML Webhook.")
  @example(UsedForType.Calling)
  used_for?: UsedForType = UsedForType.Calling;

  @doc("Primary request url of the CXML Webhook.")
  @example("https://primary.com")
  primary_request_url: url;

  @doc("Primary request method of the CXML Webhook.")
  @example(UrlMethodType.Get)
  primary_request_method?: UrlMethodType.Get | UrlMethodType.Post = UrlMethodType.Post;

  @doc("Fallback request url of the CXML Webhook.")
  @example("https://fallback.com")
  fallback_request_url?: url;

  @doc("Fallback request method of the CXML Webhook.")
  @example(UrlMethodType.Get)
  fallback_request_method?: UrlMethodType.Get | UrlMethodType.Post = UrlMethodType.Post;

  @doc("Status callback url of the CXML Webhook.")
  @example("https://callback.com")
  status_callback_url?: url;

  @doc("Status callback method of the CXML Webhook.")
  @example(UrlMethodType.Get)
  status_callback_method?: UrlMethodType.Get | UrlMethodType.Post = UrlMethodType.Post;
}

model CXMLWebhookUpdateRequest {
  @doc("Name of the CXML Webhook.")
  @example("My CXML Webhook")
  name?: string;

  @doc("Used for of the CXML Webhook.")
  @example(UsedForType.Calling)
  used_for?: UsedForType = UsedForType.Calling;

  @doc("Primary request url of the CXML Webhook.")
  @example("https://primary.com")
  primary_request_url?: url;

  @doc("Primary request method of the CXML Webhook.")
  @example(UrlMethodType.Get)
  primary_request_method?: UrlMethodType.Get | UrlMethodType.Post = UrlMethodType.Post;

  @doc("Fallback request url of the CXML Webhook.")
  @example("https://fallback.com")
  fallback_request_url?: url;

  @doc("Fallback request method of the CXML Webhook.")
  @example(UrlMethodType.Get)
  fallback_request_method?: UrlMethodType.Get | UrlMethodType.Post = UrlMethodType.Post;

  @doc("Status callback url of the CXML Webhook.")
  @example("https://callback.com")
  status_callback_url?: url;

  @doc("Status callback method of the CXML Webhook.")
  @example(UrlMethodType.Post)
  status_callback_method?: UrlMethodType.Get | UrlMethodType.Post = UrlMethodType.Post;
}
