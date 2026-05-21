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

@route("/Accounts/{AccountSid}/Conferences")
namespace CompatibilityAPI.Conferences {
  @tag(CONFERENCES_TAG)
  @friendlyName("Conferences")
  interface Conferences {
    @operationId("list_all_conferences")
    @summary("List All Conferences")
    @doc("""
      The ability to read all of the conferences that are associated with your Account. This will be returned as a list of conferences.
      
      ${tokenPermissions<"_Voice_">}
      """)
    list(
      ...ConferencesAccountSidPath,

      @query
      @doc("Shows conferences that were created on the date provided. Format: YYYY-MM-DD.")
      @example("2024-01-15")
      DateCreated?: string,

      @query("DateCreated<")
      @doc("Shows conferences that were created before the date provided. Format: YYYY-MM-DD.")
      @example("2024-01-15")
      DateCreatedBefore?: string,

      @query("DateCreated>")
      @doc("Shows conferences that were created after the date provided. Format: YYYY-MM-DD.")
      @example("2024-01-01")
      DateCreatedAfter?: string,

      @query
      @doc("Shows conferences that were updated on the date provided. Format: YYYY-MM-DD.")
      @example("2024-01-15")
      DateUpdated?: string,

      @query("DateUpdated<")
      @doc("Shows conferences that were updated before the date provided. Format: YYYY-MM-DD.")
      @example("2024-01-15")
      DateUpdatedBefore?: string,

      @query("DateUpdated>")
      @doc("Shows conferences that were updated after the date provided. Format: YYYY-MM-DD.")
      @example("2024-01-01")
      DateUpdatedAfter?: string,

      @query
      @doc("A description, up to 64 characters, of the conference room.")
      @maxLength(64)
      @example("My Conference Room")
      FriendlyName?: string,

      @query
      @doc("The status of this conference.")
      @example(ConferenceStatus.InProgress)
      Status?: ConferenceStatus,

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
      @example("PAb3877c40da6049989ad0b792e98472cf")
      PageToken?: string,
    ):
      | ConferenceListResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422;

    @operationId("retrieve_conference")
    @summary("Retrieve a Conference")
    @doc("""
      Retrieve a single conference.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @route("/{Sid}")
    read(...ConferencesAccountSidPath, ...ConferenceSidPath):
      | ConferenceResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404;

    @operationId("update_conference")
    @summary("Update Conference")
    @doc("""
      Allows you to modify the properties of a conference.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @post
    @route("/{Sid}")
    update(
      ...ConferencesAccountSidPath,
      ...ConferenceSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body?: UpdateConferenceRequest,
    ):
      | ConferenceResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422
      | CompatibilityStatusCode503;
  }

  @tag(CONFERENCE_PARTICIPANTS_TAG)
  @friendlyName("Conference Participants")
  @route("/{ConferenceSid}/Participants")
  interface ConferenceParticipants {
    @operationId("list_all_participants")
    @summary("List all active Participants")
    @doc("""
      The ability to read all of the active participants that are associated with this conference call. This will be returned as a list of participants.
      
      ${tokenPermissions<"_Voice_">}
      """)
    list(
      ...ConferencesAccountSidPath,
      ...ConferenceSidPathForParticipant,

      @query
      @doc("Whether or not a participant is muted.")
      @example(false)
      Muted?: boolean,

      @query
      @doc("Whether or not a participant is on hold.")
      @example(false)
      Hold?: boolean,

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
      @example("PAb3877c40da6049989ad0b792e98472ca")
      PageToken?: string,
    ):
      | ConferenceParticipantListResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422;

    @operationId("retrieve_participant")
    @summary("Retrieve a Participant")
    @doc("""
      Retrieve a single participant.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @route("/{CallSid}")
    read(
      ...ConferencesAccountSidPath,
      ...ConferenceSidPathForParticipant,
      ...ParticipantCallSidPath,
    ):
      | ConferenceParticipantResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404;

    @operationId("update_participant")
    @summary("Update a Participant")
    @doc("""
      Update a participant.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @post
    @route("/{CallSid}")
    update(
      ...ConferencesAccountSidPath,
      ...ConferenceSidPathForParticipant,
      ...ParticipantCallSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: UpdateConferenceParticipantRequest,
    ):
      | ConferenceParticipantResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422;

    @operationId("delete_participant")
    @summary("Delete a Participant")
    @doc("""
      Deleting a participant will take them out of a conference call.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @delete
    @route("/{CallSid}")
    delete(
      ...ConferencesAccountSidPath,
      ...ConferenceSidPathForParticipant,
      ...ParticipantCallSidPath,
    ):
      | CompatibilityStatusCode204
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422;
  }

  @tag(CONFERENCE_RECORDINGS_TAG)
  @friendlyName("Conference Recordings")
  @route("/{ConferenceSid}/Recordings")
  interface ConferenceRecordings {
    @operationId("list_conference_recordings")
    @summary("List Conference Recordings")
    @doc("""
      List all recordings for a conference.
      
      ${tokenPermissions<"_Voice_">}
      """)
    list(
      ...ConferencesAccountSidPath,
      ...ConferenceSidPathForParticipant,

      @query
      @doc("Shows recordings that were created on the date provided. Format: YYYY-MM-DD.")
      @example("2024-01-15")
      DateCreated?: string,

      @query("DateCreated<")
      @doc("Shows recordings that were created before the date provided. Format: YYYY-MM-DD.")
      @example("2024-01-15")
      DateCreatedBefore?: string,

      @query("DateCreated>")
      @doc("Shows recordings that were created after the date provided. Format: YYYY-MM-DD.")
      @example("2024-01-01")
      DateCreatedAfter?: string,

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
      @example("PA19e436af56884307b03bbdb2b42b8142")
      PageToken?: string,
    ):
      | ConferenceRecordingListResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422;

    @operationId("get_conference_recording")
    @summary("Get a Conference Recording")
    @doc("""
      Get details for a specific conference recording.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @route("/{Sid}")
    read(
      ...ConferencesAccountSidPath,
      ...ConferenceSidPathForParticipant,
      ...ConferenceRecordingSidPath,
    ):
      | ConferenceRecordingResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404;

    @operationId("update_conference_recording")
    @summary("Update a Conference Recording")
    @doc("""
      Pause, resume or stop a conference recording. You can control what happens while recording is paused (replace pause with silence or skip it).
      
      ${tokenPermissions<"_Voice_">}
      """)
    @post
    @route("/{Sid}")
    update(
      ...ConferencesAccountSidPath,
      ...ConferenceSidPathForParticipant,
      ...ConferenceRecordingSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: UpdateConferenceRecordingRequest,
    ):
      | ConferenceRecordingResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422StringArray
      | CompatibilityStatusCode503;

    @operationId("delete_conference_recording")
    @summary("Delete a Conference Recording")
    @doc("""
      Delete a conference recording. If successful, a 204 response with no body will be returned.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @delete
    @route("/{Sid}")
    delete(
      ...ConferencesAccountSidPath,
      ...ConferenceSidPathForParticipant,
      ...ConferenceRecordingSidPath,
    ):
      | CompatibilityStatusCode204
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404;
  }

  @tag(CONFERENCE_STREAMS_TAG)
  @friendlyName("Conference Streams")
  @route("/{ConferenceSid}/Streams")
  interface ConferenceStreams {
    @operationId("create_conference_stream")
    @summary("Create a Conference Stream")
    @doc("""
      Create a stream for an existing conference.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @post
    create(
      ...ConferencesAccountSidPath,
      ...ConferenceSidPathForParticipant,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: CreateConferenceStreamRequest,
    ):
      | ConferenceStreamResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422StringArray;

    @operationId("update_conference_stream")
    @summary("Update Conference Stream")
    @doc("""
      Update an existing conference stream. Commonly used to stop/start streams or modify stream properties.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @post
    @route("/{Sid}")
    update(
      ...ConferencesAccountSidPath,
      ...ConferenceSidPathForParticipant,
      ...ConferenceStreamSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: UpdateConferenceStreamRequest,
    ):
      | ConferenceStreamResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422StringArray;
  }
}
