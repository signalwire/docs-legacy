import "../../../types/status-codes";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "http_url_required",
      message: "This value must be an HTTP or HTTPS URL.",
      attribute: "status_callback_url",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model SwmlWebhookCreateStatusCode422 is StatusCode422;

model SwmlWebhookUpdateStatusCode422 is SwmlWebhookCreateStatusCode422;
