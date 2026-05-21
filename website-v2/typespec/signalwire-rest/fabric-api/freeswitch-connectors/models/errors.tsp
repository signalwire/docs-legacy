import "../../../types/status-codes";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "missing_required_parameter",
      message: "host is required",
      attribute: "host",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model FreeswitchConnectorCreateStatusCode422 is StatusCode422;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "invalid_parameter_value",
      message: "port must be between 1 and 65535",
      attribute: "port",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model FreeswitchConnectorUpdateStatusCode422 is StatusCode422;
