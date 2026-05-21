import "../../../types/status-codes";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "missing_required_parameter",
      message: "contents is required",
      attribute: "contents",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model SwmlScriptCreateStatusCode422 is StatusCode422;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "invalid_parameter_value",
      message: "contents must be valid SWML JSON",
      attribute: "contents",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model SwmlScriptUpdateStatusCode422 is StatusCode422;
