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
model CXMLWebhookCreateStatusCode422 is StatusCode422;

model CXMLWebhookUpdateStatusCode422 is CXMLWebhookCreateStatusCode422;
