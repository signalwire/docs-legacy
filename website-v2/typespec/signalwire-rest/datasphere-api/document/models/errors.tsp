import "../../../types/status-codes";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "invalid_parameter",
      message: "Invalid chunking_strategy",
      attribute: "chunking_strategy",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model CreateStatusCode422 is StatusCode422;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "invalid_parameter",
      message: "Invalid tags",
      attribute: "tags",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model SearchStatusCode422 is StatusCode422;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "invalid_parameter",
      message: "Invalid tags",
      attribute: "tags",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model UpdateStatusCode422 is StatusCode422;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "invalid_parameter",
      message: "Invalid page_token",
      attribute: "page_token",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model ListStatusCode422 is StatusCode422;
