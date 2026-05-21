import "./core.tsp";
import "../../_shared/enums.tsp";
import "../../_shared/const.tsp";

model ConferenceRoomListResponse {
  @doc("Object containing pagination links")
  links: ConferenceRoomAddressPaginationResponse;

  @doc("An array of objects containing the Conference Room data")
  data: ConferenceRoomResponse[];
}

model ConferenceRoomResponse {
  @doc("Unique ID of the Conference Room.")
  @example("993ed018-9e79-4e50-b97b-984bd5534095")
  @format("uuid")
  id: uuid;

  @doc("Unique ID of the Project.")
  @example("1313fe58-5e14-4c11-bbe7-6fdfa11fe780")
  @format("uuid")
  project_id: uuid;

  @doc("Display name of the Conference Room Fabric Resource")
  @example("Reception")
  display_name: string;

  @doc("Type of the Fabric Resource")
  @example(FabricResponseType.ConferenceRoom)
  type: FabricResponseType.ConferenceRoom;

  @doc("Date and time when the resource was created.")
  @example(UTC_TIME_EXAMPLE)
  created_at: utcDateTime;

  @doc("Date and time when the resource was updated.")
  @example(UTC_TIME_EXAMPLE)
  updated_at: utcDateTime;

  @doc("Conference Room data.")
  conference_room: ConferenceRoom;
}

model ConferenceRoomPagainationResponse {
  @doc("Link of the current page")
  @example("https://example.signalwire.com/api/fabric/resources/conference_rooms?page_number=0&page_size=50&type=conference_room")
  self: url;

  @doc("Link to the first page")
  @example("https://example.signalwire.com/api/fabric/resources/conference_rooms?page_size=50&type=conference_room")
  first: url;

  @doc("Link to the next page")
  @example("https://example.signalwire.com/api/fabric/resources/conference_rooms?page_number=1&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=conference_room")
  next?: url;

  @doc("Link to the previous page")
  @example("https://example.signalwire.com/api/fabric/resources/conference_rooms?page_number=0&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=conference_room")
  prev?: url;
}
