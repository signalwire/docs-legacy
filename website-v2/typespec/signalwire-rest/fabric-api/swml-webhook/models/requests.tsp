model SWMLWebhookCreateRequest {
  @doc("Name of the SWML Webhook.")
  @example("My SWML Webhook")
  name?: string;

  @doc("Used for of the SWML Webhook.")
  @example(UsedForType.Calling)
  used_for?: UsedForType.Calling = UsedForType.Calling;

  @doc("Primary request url of the SWML Webhook.")
  @example("https://primary.com")
  primary_request_url: url;

  @doc("Primary request method of the SWML Webhook.")
  @example(UrlMethodType.Get)
  primary_request_method?: UrlMethodType.Get | UrlMethodType.Post = UrlMethodType.Post;

  @doc("Fallback request url of the SWML Webhook.")
  @example("https://fallback.com")
  fallback_request_url?: url;

  @doc("Fallback request method of the SWML Webhook.")
  @example(UrlMethodType.Get)
  fallback_request_method?: UrlMethodType.Get | UrlMethodType.Post = UrlMethodType.Post;

  @doc("Status callback url of the SWML Webhook.")
  @example("https://callback.com")
  status_callback_url?: url;

  @doc("Status callback method of the SWML Webhook.")
  @example(UrlMethodType.Get)
  status_callback_method?: UrlMethodType.Get | UrlMethodType.Post = UrlMethodType.Post;
}

model SWMLWebhookUpdateRequest {
  @doc("Name of the SWML Webhook.")
  @example("My SWML Webhook")
  name?: string;

  @doc("Used for of the SWML Webhook.")
  @example(UsedForType.Calling)
  used_for?: UsedForType.Calling = UsedForType.Calling;

  @doc("Primary request url of the SWML Webhook.")
  @example("https://primary.com")
  primary_request_url?: url;

  @doc("Primary request method of the SWML Webhook.")
  @example(UrlMethodType.Get)
  primary_request_method?: UrlMethodType.Get | UrlMethodType.Post = UrlMethodType.Post;

  @doc("Fallback request url of the SWML Webhook.")
  @example("https://fallback.com")
  fallback_request_url?: url;

  @doc("Fallback request method of the SWML Webhook.")
  @example(UrlMethodType.Get)
  fallback_request_method?: UrlMethodType.Get | UrlMethodType.Post = UrlMethodType.Post;

  @doc("Status callback url of the SWML Webhook.")
  @example("https://callback.com")
  status_callback_url?: url;

  @doc("Status callback method of the SWML Webhook.")
  @example(UrlMethodType.Get)
  status_callback_method?: UrlMethodType.Get | UrlMethodType.Post = UrlMethodType.Post;
}
