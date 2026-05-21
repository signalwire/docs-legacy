import "../../../types/status-codes";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "missing_required_parameter",
      message: "Name can't be blank",
      attribute: "name",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model AIAgentCreateStatusCode422 is StatusCode422;

model AIAgentUpdateStatusCode422 is AIAgentCreateStatusCode422;
