import "../../../types/status-codes/main.tsp";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "invalid_parameter",
      message: "Parameter value is invalid",
      attribute: "page_size",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model VoiceLogsListStatusCode422 is StatusCode422;
