import "../../../types/status-codes";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "missing_required_parameter",
      message: "username is required",
      attribute: "username",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model ResourceSipEndpointCreateStatusCode422 is StatusCode422;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "invalid_parameter_value",
      message: "encryption must be one of: disabled, optional, required",
      attribute: "encryption",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model ResourceSipEndpointUpdateStatusCode422 is StatusCode422;
