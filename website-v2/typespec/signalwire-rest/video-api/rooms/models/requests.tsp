import "./core.tsp";
import "../../_shared/models.tsp";

@doc("Common room properties shared between create and update requests.")
model RoomRequestProperties {
  @doc("Display name of the room. Maximum of 200 characters. Defaults to the value of name.")
  @example("My Room's Name")
  @maxLength(200)
  display_name?: string;

  @doc("Description of the room. Maximum of 3000 characters.")
  @example("This room will be used for full company all hands meetings")
  @maxLength(3000)
  description?: string;

  @doc("The maximum number of members in the room at a time. Must be at least 1 to a maximum of 300.")
  @example(20)
  @minValue(1)
  @maxValue(300)
  max_members?: int32 = 20;

  @doc("The room's resolution.")
  @example(VideoQuality.`720p`)
  quality?: VideoQuality = VideoQuality.`720p`;

  @doc("Room does not accept new participants before this time. Expects RFC 3339 datetime: `2022-01-01T23:59:60Z`. Date only: `2022-01-01` will be converted to `2022-01-01T00:00:00Z`.")
  @example(utcDateTime.fromISO("2022-01-01T00:00:00Z"))
  join_from?: utcDateTime;

  @doc("Room stops accepting new participants at this time, but keeps running until all participants leave. Expects RFC 3339 datetime: `2022-01-01T23:59:60Z`. Date only: `2022-01-01` will be converted to `2022-01-01T00:00:00Z`.")
  @example(utcDateTime.fromISO("2022-12-31T23:59:59Z"))
  join_until?: utcDateTime;

  @doc("Remove users from the room at this time. Expects RFC 3339 datetime: `2022-01-01T23:59:60Z`. Date only: `2022-01-01` will be converted to `2022-01-01T00:00:00Z`.")
  @example(utcDateTime.fromISO("2022-12-31T23:59:59Z"))
  remove_at?: utcDateTime;

  @doc("Remove users after they are in the room for N seconds.")
  @example(120)
  @minValue(1)
  @maxValue(200000)
  remove_after_seconds_elapsed?: int32;

  @doc("The room's initial layout.")
  @example(RoomLayout.`grid-responsive`)
  layout?: RoomLayout = RoomLayout.`grid-responsive`;

  @doc("Specifies whether to start recording a Room Session when one is started for this Room.")
  @example(false)
  record_on_start?: boolean = false;

  @doc("Whether a video with a preview of the content of the room is to be generated.")
  @example(false)
  enable_room_previews?: boolean = false;

  @doc("User-defined metadata for the room. Must be a valid JSON object. Maximum of 2000 characters when serialized.")
  @example(#{})
  meta?: Record<unknown>;

  @doc("Enable/disable jitter buffer audio-video sync.")
  @example(true)
  sync_audio_video?: boolean;
}

@doc("Request body for creating a room.")
model CreateRoomRequest {
  @doc("A named unique identifier for the room. Allowed characters: `A-Za-z0-9_-`. Maximum of 100 characters.")
  @example("my_room")
  @maxLength(100)
  @pattern("^[A-Za-z0-9_\\-]+$")
  name: string;

  ...RoomRequestProperties;
}

@doc("Request body for updating a room.")
model UpdateRoomRequest {
  ...RoomRequestProperties;
}
