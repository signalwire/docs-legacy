import "../../../../types/status-codes";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "invalid_parameter",
      message: "Address is invalid",
      attribute: "address_id",
      url: "https://signalwire.com/docs/rest/overview/error-codes#invalid_parameter",
    },
    #{
      type: "validation_error",
      code: "invalid_parameter",
      message: "Expires At must be an integer",
      attribute: "expires_at",
      url: "https://signalwire.com/docs/rest/overview/error-codes#invalid_parameter",
    },
    #{
      type: "validation_error",
      code: "invalid_parameter",
      message: "Expires At must be greater than 1733254773",
      attribute: "expires_at",
      url: "https://signalwire.com/docs/rest/overview/error-codes#invalid_parameter",
    }
  ],
})
model InviteTokenCreateStatusCode422 is StatusCode422;
