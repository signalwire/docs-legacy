import "../../../types/status-codes";

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "missing_required_parameter",
      message: "A required parameter is missing from the request. Please refer to the technical reference for a complete list of parameters.",
      attribute: "ttl",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model ChatToken422Error is Types.StatusCodes.StatusCode422;
