import "../../../../types";

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
model ResourceSubSipEndpointCreateStatusCode422 is StatusCode422;
