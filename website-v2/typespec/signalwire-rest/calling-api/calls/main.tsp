import "@typespec/http";
import "@typespec/openapi";
import "../../types";
import "../../../_shared/alias/token-permissions.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "./models/examples.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/calls")
namespace CallingAPI.Calls {
  @tag(CALLS_TAG)
  @friendlyName("Calls")
  interface Calls {
    @summary("Send Call Commands")
    @doc("""
      Unified JSON-RPC style endpoint for executing call methods through command-based dispatch.
      Send a request with the appropriate `command` field to invoke the desired call operation.
      This endpoint provides a single interface for all call-related methods including creation, updates, termination, and AI conversation control.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @opExample(
      #{ parameters: userEventCallExample },
      #{
        title: "calling.user_event",
        description: "Fire a custom user event on an active call",
      }
    )
    @opExample(
      #{ parameters: transferCallExample },
      #{
        title: "calling.transfer",
        description: "Transfer an active call to a new destination",
      }
    )
    @opExample(
      #{ parameters: liveTranslateStartExample },
      #{
        title: "calling.live_translate",
        description: "Start real-time language translation between call participants",
      }
    )
    @opExample(
      #{ parameters: liveTranscribeStartExample },
      #{
        title: "calling.live_transcribe",
        description: "Start real-time speech-to-text transcription on an active call",
      }
    )
    @opExample(
      #{ parameters: aiMessageExample },
      #{
        title: "calling.ai_message",
        description: "Send a message to the AI conversation to modify behavior or add context",
      }
    )
    @opExample(
      #{ parameters: unholdCallExample },
      #{
        title: "calling.ai_unhold",
        description: "Resume an AI call that was previously put on hold",
      }
    )
    @opExample(
      #{ parameters: holdCallExample },
      #{
        title: "calling.ai_hold",
        description: "Put an active AI call on hold, pausing the conversation",
      }
    )
    @opExample(
      #{ parameters: hangupCallExample },
      #{
        title: "calling.end",
        description: "Terminate an active call immediately",
      }
    )
    @opExample(
      #{ parameters: updateCallExample },
      #{
        title: "update",
        description: "Modify an existing call's parameters in real-time",
      }
    )
    @opExample(
      #{ parameters: dialCallExample },
      #{
        title: "dial",
        description: "Initiate a new outbound call with the dial command",
      }
    )
    @post
    @operationId("call-commands")
    callCommand(@body request: CallRequest):
      | {
          @statusCode statusCode: 200;
          @body call: CallResponse;
        }
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | CallCreate422Error
      | StatusCode500;
  }
}
