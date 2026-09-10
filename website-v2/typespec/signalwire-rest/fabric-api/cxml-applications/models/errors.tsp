import "../../../types/status-codes";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "missing_required_parameter",
      message: "display_name is required",
      attribute: "display_name",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model CxmlApplicationCreateStatusCode422 is StatusCode422;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "invalid_parameter_value",
      message: "voice_url must be a valid URL",
      attribute: "voice_url",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model CxmlApplicationUpdateStatusCode422 is StatusCode422;
