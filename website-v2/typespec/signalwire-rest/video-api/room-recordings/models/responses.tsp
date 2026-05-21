import "@typespec/http";
import "../../_shared/models.tsp";
import "../../room-sessions/models/core.tsp";

using TypeSpec.Http;

@doc("Room recording response.")
model RoomRecordingResponse {
  @statusCode statusCode: 200;
  @body body: RoomRecording;
}

@doc("List room recordings response.")
model ListRoomRecordingsResponse {
  @doc("Pagination links.")
  links: PaginationLinks;

  @doc("List of room recordings.")
  data: RoomRecording[];
}

@doc("List room recording events response.")
model ListRoomRecordingEventsResponse {
  @doc("Pagination links.")
  links: PaginationLinks;

  @doc("List of room recording events.")
  data: RoomSessionEvent[];
}
