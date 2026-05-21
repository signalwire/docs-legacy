import "../../../types/status-codes";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "account_error",
      code: "exceeds_history_logs_limit",
      message: "The value exceeds the 2025-02-09 date limit.",
      attribute: "created_before",
      url: "https://signalwire.com/docs/rest/overview/error-codes/#exceeds_history_logs_limit",
    }
  ],
})
model FaxLogsListStatusCode422 is StatusCode422;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "account_error",
      code: "exceeds_history_logs_limit",
      message: "The value exceeds the 2025-02-09 date limit.",
      attribute: "created_at",
      url: "https://signalwire.com/docs/rest/overview/error-codes/#exceeds_history_logs_limit",
    }
  ],
})
model FaxLogShowStatusCode422 is StatusCode422;
