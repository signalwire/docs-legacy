import "@typespec/http";
import "@typespec/openapi";
import "../../types/status-codes";
import "../tags.tsp";
import "../_shared/models.tsp";
import "../_shared/errors.tsp";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/room_tokens")
namespace VideoAPI.RoomTokens {
  @tag(ROOM_TOKENS_TAG)
  @friendlyName("Room Tokens")
  interface RoomTokens {
    @operationId("create_room_token")
    @summary("Generate a new Video Room Token")
    @doc("Generate a Room Token allowing a client to join a Room.\n\n${tokenPermissions<"_Video_">}")
    @post
    create(@body body: CreateRoomTokenRequest):
      | RoomTokenResponse
      | StatusCode400
      | StatusCode401
      | VideoStatusCode422
      | StatusCode500;
  }
}
