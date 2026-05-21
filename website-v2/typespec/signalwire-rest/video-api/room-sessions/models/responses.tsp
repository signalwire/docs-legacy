import "@typespec/http";
import "./core.tsp";
import "../../_shared/models.tsp";

using TypeSpec.Http;

@doc("Room session summary, returned by the show endpoint. Omits list-only fields.")
model RoomSessionSummary
  is OmitProperties<RoomSession, "cost_in_dollars" | "enable_room_previews" | "locked_cover">;

@doc("Room session response.")
model RoomSessionResponse {
  @statusCode statusCode: 200;
  @body body: RoomSessionSummary;
}

@doc("List room sessions response.")
model ListRoomSessionsResponse {
  @doc("Pagination links.")
  links: PaginationLinks;

  @doc("List of room sessions.")
  data: RoomSession[];
}

@doc("List room session recordings response.")
model ListRoomSessionRecordingsResponse {
  @doc("Pagination links.")
  links: PaginationLinks;

  @doc("List of room recordings.")
  data: RoomRecording[];
}

@doc("List room session members response.")
model ListRoomSessionMembersResponse {
  @doc("Pagination links.")
  links: PaginationLinks;

  @doc("List of room session members.")
  data: RoomSessionMember[];
}

@doc("List room session events response.")
model ListRoomSessionEventsResponse {
  @doc("Pagination links.")
  links: PaginationLinks;

  @doc("List of room session events.")
  data: RoomSessionEvent[];
}
