import "../../../types/status-codes";

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "not_a_valid_json",
      message: "Permissions must be valid JSON",
      attribute: "permissions",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model PubSubToken422Error is Types.StatusCodes.StatusCode422;
