import "../../../types/status-codes";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "missing_required_parameter",
      message: "project_id is required",
      attribute: "project_id",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model DialogflowAgentCreateStatusCode422 is StatusCode422;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "invalid_parameter_value",
      message: "language_code must be a valid language code",
      attribute: "language_code",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model DialogflowAgentUpdateStatusCode422 is StatusCode422;
