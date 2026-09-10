import "../../../types/status-codes";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "missing_required_parameter",
      message: "title is required",
      attribute: "title",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model CallFlowCreateStatusCode422 is StatusCode422;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "invalid_parameter_value",
      message: "document_version must be greater than current version",
      attribute: "document_version",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model CallFlowUpdateStatusCode422 is StatusCode422;
