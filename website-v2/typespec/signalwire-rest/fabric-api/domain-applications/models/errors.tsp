import "../../../types";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "missing_required_parameter",
      message: "name is required",
      attribute: "name",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model DomainApplicationCreateStatusCode422 is StatusCode422;
