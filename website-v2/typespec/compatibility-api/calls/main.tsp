import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "../_shared/errors.tsp";
import "../tags.tsp";
import "../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@route("/Accounts/{AccountSid}/Calls")
namespace CompatibilityAPI.Calls {
  @tag(CALLS_TAG)
  @friendlyName("Calls")
  interface Calls {
    @operationId("list_all_calls")
    @summary("List all Calls")
    @doc("""
      List all calls.
      
      ${tokenPermissions<"_Voice_">}
      """)
    list(
      ...CallsAccountSidPath,

      @query
      @doc("The time, in RFC 2822 GMT format, on which the call was terminated.")
      @example("Fri, 21 Sep 2018 10:00:00 +0000")
      EndTime?: string,

      @query("EndTime<")
      @doc("The time before which the call was terminated.")
      @example("Fri, 21 Sep 2018 10:00:00 +0000")
      EndTimeBefore?: string,

      @query("EndTime>")
      @doc("The time after which the call was terminated.")
      @example("Fri, 21 Sep 2018 10:00:00 +0000")
      EndTimeAfter?: string,

      @query
      @doc("The address that initiated the call.")
      @example("+13103384645")
      From?: string,

      @query
      @doc("The unique identifier for the call that created this call.")
      @format("uuid")
      @example("b3877c40-da60-4998-90ad-b792e98472af")
      ParentCallSid?: string,

      @query
      @doc("The time, in RFC 2822 GMT format, on which the call began.")
      @example("Wed, 19 Sep 2018 20:00:00 +0000")
      StartTime?: string,

      @query("StartTime<")
      @doc("The time before which the call began.")
      @example("Wed, 19 Sep 2018 20:00:00 +0000")
      StartTimeBefore?: string,

      @query("StartTime>")
      @doc("The time after which the call began.")
      @example("Wed, 19 Sep 2018 20:00:00 +0000")
      StartTimeAfter?: string,

      @query
      @doc("The status of the call.")
      @example("completed")
      Status?:
        | "queued"
        | "ringing"
        | "in-progress"
        | "canceled"
        | "completed"
        | "busy"
        | "failed"
        | "no-answer",

      @query
      @doc("The address that received the call.")
      @example("+13105678901")
      To?: string,

      @query
      @doc("The page number to retrieve. Page numbers are zero-indexed, so the first page is 0.")
      @minValue(0)
      @example(0)
      Page?: int32 = 0,

      @query
      @doc("The number of results to return per page. The default is 50, and the maximum is 1000.")
      @minValue(1)
      @maxValue(1000)
      @example(50)
      PageSize?: int32 = 50,

      @query
      @doc("A token used to retrieve a specific page of results. Must start with PA or PB.")
      @example("PAb3877c40da604998")
      PageToken?: string,
    ):
      | CallListResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422;

    @operationId("create_a_call")
    @summary("Create a Call")
    @doc("""
      Create a call.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @post
    create(
      ...CallsAccountSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: CreateCallRequest,
    ):
      | CallResponse
      | CompatibilityStatusCode400Array
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422;

    @operationId("retrieve_a_call")
    @summary("Retrieve a Call")
    @doc("""
      Retrieve a call.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @route("/{Sid}")
    read(...CallsAccountSidPath, ...CallSidPath):
      | CallResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404;

    @operationId("update_a_call")
    @summary("Update a Call")
    @doc("""
      Update a call.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @post
    @route("/{Sid}")
    update(
      ...CallsAccountSidPath,
      ...CallSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: UpdateCallRequest,
    ):
      | CallResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422
      | CompatibilityStatusCode503;

    @operationId("delete_a_call")
    @summary("Delete a Call")
    @doc("""
      Delete a call record from your account. If the delete is successful, a 204 response, with no body, will be returned.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @delete
    @route("/{Sid}")
    delete(...CallsAccountSidPath, ...CallSidPath):
      | CompatibilityStatusCode204
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422;
  }

  @tag(RECORDINGS_TAG)
  @friendlyName("Call Recordings")
  @route("/{CallSid}/Recordings")
  interface CallRecordings {
    @operationId("create_recording")
    @summary("Create a Recording")
    @doc("""
      Create a recording.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @post
    create(
      ...CallsAccountSidPath,
      ...CallSidPathForRecording,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: CreateCallRecordingRequest,
    ):
      | CallRecordingResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422
      | CompatibilityStatusCode503;

    @operationId("update_recording")
    @summary("Update a Recording")
    @doc("""
      Pause, resume or stop a Recording. You can control what happens while recording is paused (replace pause with silence or skip it).
      
      ${tokenPermissions<"_Voice_">}
      """)
    @post
    @route("/{Sid}")
    update(
      ...CallsAccountSidPath,
      ...CallSidPathForRecording,
      ...CallSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: UpdateCallRecordingRequest,
    ):
      | CallRecordingResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422
      | CompatibilityStatusCode503;
  }

  @tag(STREAMS_TAG)
  @friendlyName("Call Streams")
  @route("/{CallSid}/Streams")
  interface CallStreams {
    @operationId("create_stream")
    @summary("Create a Stream")
    @doc("""
      Create a stream.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @post
    create(
      ...CallsAccountSidPath,
      ...CallSidPathForRecording,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: CreateCallStreamRequest,
    ):
      | CallStreamResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422
      | CompatibilityStatusCode503;

    @operationId("update_stream")
    @summary("Stop a Stream")
    @doc("""
      Stop a Stream.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @post
    @route("/{Sid}")
    update(
      ...CallsAccountSidPath,
      ...CallSidPathForRecording,
      ...CallSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: UpdateCallStreamRequest,
    ):
      | CallStreamResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422
      | CompatibilityStatusCode503;
  }
}
