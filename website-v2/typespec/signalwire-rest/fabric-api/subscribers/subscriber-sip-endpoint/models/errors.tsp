import "../../../../types/status-codes";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "invalid_parameter",
      message: "Ciphers are invalid",
      attribute: "ciphers",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model SipEndpointCreateStatusCode422 is StatusCode422;

model SipEndpointUpdateStatusCode422 is SipEndpointCreateStatusCode422;
