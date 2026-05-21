import "../../../types/status-codes";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "invalid_parameter",
      message: "created_on is not a valid date or timestamp",
      attribute: "created_on",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model ConferenceLogsStatusCode422 is StatusCode422;
