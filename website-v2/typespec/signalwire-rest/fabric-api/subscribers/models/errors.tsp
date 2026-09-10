import "../../../types/status-codes";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "missing_required_parameter",
      message: "Required parameter is missing",
      attribute: "password",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model SubscriberCreateStatusCode422 is StatusCode422;

model SubscriberUpdateStatusCode422 is SubscriberCreateStatusCode422;
