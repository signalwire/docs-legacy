import "../../../types/status-codes";

using Types.StatusCodes;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "missing_required_parameter",
      message: "display_name is required",
      attribute: "display_name",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model ConferenceRoomCreateStatusCode422 is StatusCode422;

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "invalid_parameter_value",
      message: "max_members must be greater than 0",
      attribute: "max_members",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model ConferenceRoomUpdateStatusCode422 is StatusCode422;
