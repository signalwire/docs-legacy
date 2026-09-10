import "../../../types/status-codes";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "missing_required_parameter",
      message: "token is required",
      attribute: "token",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model EmbedTokenCreateStatusCode422 is StatusCode422;
