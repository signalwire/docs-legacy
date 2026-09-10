import "../../../../types/status-codes";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "missing_required_parameter",
      message: "Required parameter is missing",
      attribute: "reference",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model SubscriberTokenStatusCode422 is StatusCode422;
