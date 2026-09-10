import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/responses.tsp";
import "../../../types";
import "../../tags.tsp";
import "../../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/resources/conference_room/{id}/addresses")
namespace FabricAPI.ConferenceRoom.Addresses {
  @tag(CONFERENCE_ROOM_TAG)
  interface ConferenceRoomAddresses {
    @operationId("list_conference_room_addresses")
    @summary("List Conference Room Addresses")
    @doc("""
      This endpoint returns a list of addresses associated with a specific Conference Room.
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list(...ConferenceRoomAddressPathID):
      | ConferenceRoomAddressListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
