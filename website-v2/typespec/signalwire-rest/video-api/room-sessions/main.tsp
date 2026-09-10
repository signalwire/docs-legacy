import "@typespec/http";
import "@typespec/openapi";
import "../../types/status-codes";
import "../tags.tsp";
import "../_shared/errors.tsp";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/room_sessions")
namespace VideoAPI.RoomSessions {
  @tag(ROOM_SESSIONS_TAG)
  @friendlyName("Room Sessions")
  interface RoomSessions {
    @operationId("list_room_sessions")
    @summary("List Room Sessions")
    @doc("A list of past and in-progress Room Sessions.\n\n${tokenPermissions<"_Video_">}")
    list(...ListRoomSessionsRequest):
      | ListRoomSessionsResponse
      | StatusCode400
      | StatusCode401
      | VideoStatusCode422
      | StatusCode500;

    @operationId("get_room_session")
    @summary("Find a Room Session by ID")
    @doc("Find a Room Session by ID.\n\n${tokenPermissions<"_Video_">}")
    @route("/{id}")
    read(
      ...RoomSessionPathID,
    ): RoomSessionResponse | StatusCode400 | StatusCode401 | StatusCode404 | StatusCode500;

    @operationId("list_room_session_recordings")
    @summary("List a Room Session's Recordings")
    @doc("A list of Room Recordings for a particular Room Session.\n\n${tokenPermissions<"_Video_">}")
    @route("/{id}/recordings")
    listRecordings(
      ...RoomSessionPathID,
      ...ListRoomSessionRecordingsRequest,
    ):
      | ListRoomSessionRecordingsResponse
      | StatusCode400
      | StatusCode401
      | VideoStatusCode422
      | StatusCode500;

    @operationId("list_room_session_members")
    @summary("List a Room Session's Members")
    @doc("A list of Members for a particular Room Session.\n\n${tokenPermissions<"_Video_">}")
    @route("/{id}/members")
    listMembers(
      ...RoomSessionPathID,
      ...ListRoomSessionMembersRequest,
    ):
      | ListRoomSessionMembersResponse
      | StatusCode400
      | StatusCode401
      | VideoStatusCode422
      | StatusCode500;

    @operationId("list_room_session_events")
    @summary("List a Room Session's Events")
    @doc("A list of Events for a particular Room Session.\n\n${tokenPermissions<"_Video_">}")
    @route("/{id}/events")
    listEvents(
      ...RoomSessionPathID,
      ...ListRoomSessionEventsRequest,
    ):
      | ListRoomSessionEventsResponse
      | StatusCode400
      | StatusCode401
      | VideoStatusCode422
      | StatusCode500;
  }
}
