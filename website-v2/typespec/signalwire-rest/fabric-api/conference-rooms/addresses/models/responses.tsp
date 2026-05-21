import "../../addresses/models/core.tsp";
import "../../../_shared/fabric-address";
import "../../../../types";

model ConferenceRoomAddressListResponse {
  @doc("An array of objects containing list of Conference Room Addresses")
  data: FabricAddressRoom[];

  @doc("Object containing pagination links")
  links: ConferenceRoomAddressPaginationResponse;
}

model ConferenceRoomAddressPaginationResponse {
  @doc("Link of the current page")
  @example("https://example.signalwire.com/api/fabric/resources/conference_room/016e5773-c197-4446-bcc2-9c48f14e2d0a/addresses?page_number=0&page_size=50&type=conference_room")
  self: url;

  @doc("Link to the first page")
  @example("https://example.signalwire.com/api/fabric/resources/conference_room/016e5773-c197-4446-bcc2-9c48f14e2d0a/addresses?page_number=0&page_size=50&type=conference_room")
  first: url;

  @doc("Link to the next page")
  @example("https://example.signalwire.com/api/fabric/resources/conference_room/016e5773-c197-4446-bcc2-9c48f14e2d0a/addresses?page_number=1&page_size=50&page_token=PA6581c1fa-d985-4c8f-b53e-2fee11b579ad&type=conference_room")
  next?: url;

  @doc("Link to the previous page")
  @example("https://example.signalwire.com/api/fabric/resources/conference_room/016e5773-c197-4446-bcc2-9c48f14e2d0a/addresses?page_number=0&page_size=50&page_token=PA6581c1fa-d985-4c8f-b53e-2fee11b579ad&type=conference_room")
  prev?: url;
}
