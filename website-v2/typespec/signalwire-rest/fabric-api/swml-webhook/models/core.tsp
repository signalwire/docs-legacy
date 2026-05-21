import "./enums.tsp";
import "../../../types";

using TypeSpec.Http;

model SWMLWebhookID {
  @doc("Unique ID of a SWML Webhook.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

model SWMLWebhook {
  @doc("Unique ID of the SWML Webhook.")
  @example("a87db7ed-8ebe-42e4-829f-8ba5a4152f54")
  @format("uuid")
  id: uuid;

  @doc("Name of the SWML Webhook.")
  @example("My SWML Webhook")
  name: string;

  @doc("Used for of the SWML Webhook.")
  @example(UsedForType.Calling)
  used_for: UsedForType.Calling;

  @doc("Primary request url of the SWML Webhook.")
  @example("https://primary.com")
  primary_request_url: url;

  @doc("Primary request method of the SWML Webhook.")
  @example(UrlMethodType.Get)
  primary_request_method: UrlMethodType.Get | UrlMethodType.Post;

  @doc("Fallback request url of the SWML Webhook.")
  @example("https://fallback.com")
  fallback_request_url: url | null;

  @doc("Fallback request method of the SWML Webhook.")
  @example(UrlMethodType.Get)
  fallback_request_method: UrlMethodType.Get | UrlMethodType.Post;

  @doc("Status callback url of the SWML Webhook.")
  @example("https://callback.com")
  status_callback_url: url | null;

  @doc("Status callback method of the SWML Webhook.")
  @example(UrlMethodType.Post)
  status_callback_method: UrlMethodType.Get | UrlMethodType.Post;
}
