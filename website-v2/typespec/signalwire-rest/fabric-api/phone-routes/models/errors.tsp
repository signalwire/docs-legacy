import "../../../types";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "missing_required_parameter",
      message: "phone_number is required",
      attribute: "phone_number",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model PhoneRouteCreateStatusCode422 is StatusCode422;
