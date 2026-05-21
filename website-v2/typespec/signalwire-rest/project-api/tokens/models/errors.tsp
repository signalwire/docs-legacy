import "../../../types/status-codes";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "invalid_parameter",
      message: "Name must be present",
      attribute: "name",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model TokenStatusCode422 is StatusCode422;
