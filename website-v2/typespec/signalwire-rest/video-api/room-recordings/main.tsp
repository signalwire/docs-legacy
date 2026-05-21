import "@typespec/http";
import "@typespec/openapi";
import "../../types/status-codes";
import "../tags.tsp";
import "../_shared/models.tsp";
import "../_shared/errors.tsp";
import "../room-sessions/models/core.tsp";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/room_recordings")
namespace VideoAPI.RoomRecordings {
  @tag(ROOM_RECORDINGS_TAG)
  @friendlyName("Room Recordings")
  interface RoomRecordings {
    @operationId("list_room_recordings")
    @summary("List Room Recordings")
    @doc("A list of all Room Recordings.\n\n${tokenPermissions<"_Video_">}")
    list(...ListRoomRecordingsRequest):
      | ListRoomRecordingsResponse
      | StatusCode400
      | StatusCode401
      | VideoStatusCode422
      | StatusCode500;

    @operationId("get_room_recording")
    @summary("Find a Room Recording by ID")
    @doc("A detailed summary of a particular Room Recording.\n\n${tokenPermissions<"_Video_">}")
    @route("/{id}")
    read(
      ...RoomRecordingPathID,

      @query
      @doc("Generated media links will be valid for this many seconds. Default is 900 (15 minutes).")
      @minValueExclusive(0)
      @example(900)
      media_ttl?: int32,
    ):
      | RoomRecordingResponse
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | VideoStatusCode422
      | StatusCode500;

    @operationId("delete_room_recording")
    @summary("Delete a Room Recording")
    @doc("Delete a Room Recording.\n\n${tokenPermissions<"_Video_">}")
    @route("/{id}")
    @delete
    delete(
      ...RoomRecordingPathID,
    ):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | VideoStatusCode422
      | StatusCode500;

    @operationId("list_room_recording_events")
    @summary("List a Room Recording's Events")
    @doc("A list of Events for a particular Room Recording.\n\n${tokenPermissions<"_Video_">}")
    @route("/{id}/events")
    listEvents(
      ...RoomRecordingPathID,
      ...ListRoomRecordingEventsRequest,
    ):
      | ListRoomRecordingEventsResponse
      | StatusCode400
      | StatusCode401
      | VideoStatusCode422
      | StatusCode500;
  }
}
