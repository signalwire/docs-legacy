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

@route("/rooms")
namespace VideoAPI.Rooms {
  @tag(ROOMS_TAG)
  @friendlyName("Rooms")
  interface Rooms {
    @operationId("create_room")
    @summary("Create a Room")
    @doc("Create a room.\n\n${tokenPermissions<"_Video_">}")
    @post
    create(@body body: CreateRoomRequest):
      | RoomResponse
      | StatusCode400
      | StatusCode401
      | VideoStatusCode422
      | StatusCode500;

    @operationId("list_rooms")
    @summary("List Rooms")
    @doc("List rooms.\n\n${tokenPermissions<"_Video_">}")
    list(
      @query
      @doc("Specifies whether or not to include information about the room's active session (if any).")
      @example(true)
      include_active_session?: boolean,

      @query
      @doc("Return rooms with a join_from date on or after this date. Expects RFC 3339 datetime or date string.")
      @example("2022-01-01T00:00:00Z")
      starts_after?: string,

      @query
      @doc("Return rooms with a join_until date on or before this date. Expects RFC 3339 datetime or date string.")
      @example("2022-12-31T23:59:59Z")
      ends_before?: string,

      @query
      @doc("Page number to return. Requires `page_token` for values greater than 0.")
      @example(0)
      @minValue(0)
      page_number?: int32 = 0,

      @query
      @doc("Specify the number of results to return on a single page. The default page size is `50` and the maximum is `1000`.")
      @example(50)
      @minValue(1)
      @maxValue(1000)
      page_size?: int32 = 50,

      @query
      @doc("Token for cursor-based pagination. Required when `page_number` is greater than 0.")
      @example("PAb3877c40da604998")
      page_token?: string,
    ):
      | ListRoomsResponse
      | StatusCode400
      | StatusCode401
      | VideoStatusCode422
      | StatusCode500;

    @operationId("get_room_by_name")
    @summary("Find a Room by Name")
    @doc("Find a room by name.\n\n${tokenPermissions<"_Video_">}")
    @route("/{name}")
    getByName(
      @path
      @doc("Unique name of the room.")
      @example("my_room")
      name: string,

      @query
      @doc("Specifies whether or not to include information about the room's active session (if any).")
      @example(true)
      include_active_session?: boolean,
    ):
      | RoomResponse
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | VideoStatusCode422
      | StatusCode500;

    @operationId("get_room")
    @summary("Find a Room by ID")
    @doc("Find a room by ID.\n\n${tokenPermissions<"_Video_">}")
    @route("/{id}")
    read(
      @path
      @format("uuid")
      @doc("Unique ID of the room.")
      @example("c22d24f6-5a47-4597-9a23-c7d01e696b92")
      id: string,

      @query
      @doc("Specifies whether or not to include information about the room's active session (if any).")
      @example(true)
      include_active_session?: boolean,
    ):
      | RoomResponse
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | VideoStatusCode422
      | StatusCode500;

    @operationId("update_room")
    @summary("Update a Room")
    @doc("Update a room.\n\n${tokenPermissions<"_Video_">}")
    @route("/{id}")
    @put
    update(
      @path
      @format("uuid")
      @doc("Unique ID of the room.")
      @example("c22d24f6-5a47-4597-9a23-c7d01e696b92")
      id: string,

      @body body: UpdateRoomRequest,
    ):
      | RoomResponse
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | VideoStatusCode422
      | StatusCode500;

    @operationId("delete_room")
    @summary("Delete a Room")
    @doc("Delete a room.\n\n${tokenPermissions<"_Video_">}")
    @route("/{id}")
    @delete
    delete(
      @path
      @format("uuid")
      @doc("Unique ID of the room.")
      @example("c22d24f6-5a47-4597-9a23-c7d01e696b92")
      id: string,
    ):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
