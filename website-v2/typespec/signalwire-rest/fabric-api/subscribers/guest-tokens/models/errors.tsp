import "../../../../types/status-codes";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "must_belong_to_project",
      message: "The addresses must belong to the project",
      attribute: "allowed_addresses",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model GuestTokenCreateStatusCode422 is StatusCode422;
