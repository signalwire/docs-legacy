import "./core.tsp";
import "../../../types/status-codes";

using Types.StatusCodes;
using TypeSpec.Http;

@doc("The status of the call throughout its lifecycle.")
enum CallResponseStatus {
  @doc("The call has been queued for processing.")
  queued,

  @doc("The call has been initiated but not yet created.")
  initiated,

  @doc("The call has been created in FreeSWITCH.")
  created,

  @doc("The call is ringing at the destination.")
  ringing,

  @doc("The call has been answered and is in progress.")
  answered,

  @doc("The call is in the process of being terminated.")
  ending,

  @doc("The call has been terminated.")
  ended,

  @doc("The call failed before reaching FreeSWITCH due to an error such as no available endpoints or spam blocking.")
  failed,

  @doc("The call was canceled before being answered.")
  canceled,

  @doc("The call has been completed successfully.")
  completed,
}

union CallResponse {
  CallLeg,
  FabricDeviceLeg,
}

@example(#{
  statusCode: 422,
  errors: #[
    #{
      type: "validation_error",
      code: "missing_required_parameter",
      message: "url must be a valid http or https url",
      attribute: "url",
      url: "https://signalwire.com/docs/apis/error-codes",
    }
  ],
})
model CallCreate422Error is Types.StatusCodes.StatusCode422;
