import "../../../types/status-codes";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "missing_required_parameter",
      message: "name is required",
      attribute: "name",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model RelayApplicationCreateStatusCode422 is StatusCode422;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "invalid_parameter_value",
      message: "webhook_url must be a valid URL",
      attribute: "webhook_url",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model RelayApplicationUpdateStatusCode422 is StatusCode422;
