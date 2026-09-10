import "./core.tsp";

using TypeSpec.Http;

@doc("Request body for updating a short code.")
model UpdateShortCodeRequest {
  @doc("The name given to the short code.")
  @example("My Short Code")
  @maxLength(255)
  name: string;

  @doc("The message handler type for incoming messages.")
  message_handler: ShortCodeMessageHandler;

  @doc("The URL to send message requests to when using laml_webhooks handler.")
  @example("https://example.com/message")
  message_request_url?: string;

  @doc("The HTTP method to use for message requests. Defaults to POST.")
  message_request_method?: HttpMethod = HttpMethod.POST;

  @doc("The fallback URL for message requests.")
  @example("https://example.com/fallback")
  message_fallback_url?: string;

  @doc("The HTTP method to use for fallback requests. Defaults to POST.")
  message_fallback_method?: HttpMethod = HttpMethod.POST;

  @doc("The ID of the LāML application to handle messages when using laml_application handler.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  message_laml_application_id?: uuid;

  @doc("The Relay context to use when using relay_context handler.")
  @example("my-context")
  message_relay_context?: string;
}
