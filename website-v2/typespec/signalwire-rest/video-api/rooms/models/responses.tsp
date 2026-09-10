import "./core.tsp";
import "../../_shared/models.tsp";

@doc("Room response object.")
model RoomResponse {
  @doc("A unique identifier for the room.")
  @example("c22d24f6-5a47-4597-9a23-c7d01e696b92")
  @format("uuid")
  id: string;

  @doc("A named unique identifier for the room.")
  @example("my_room")
  name: string;

  @doc("Display name of the room.")
  @example("My Room's Name")
  display_name: string | null;

  @doc("Description of the room.")
  @example("This room will be used for full company all hands meetings")
  description: string | null;

  @doc("The maximum number of members in the room at a time.")
  @example(20)
  max_members: int32;

  @doc("The room's resolution.")
  @example(VideoQuality.`720p`)
  quality: VideoQuality;

  @doc("Frames per second parameter of room video quality.")
  @example(20)
  fps: int32;

  @doc("Room does not accept new participants before this time.")
  @example(utcDateTime.fromISO("2022-01-01T00:00:00Z"))
  join_from: utcDateTime | null;

  @doc("Room stops accepting new participants at this time.")
  @example(utcDateTime.fromISO("2022-12-31T23:59:59Z"))
  join_until: utcDateTime | null;

  @doc("Remove users from the room at this time.")
  @example(utcDateTime.fromISO("2022-12-31T23:59:59Z"))
  remove_at: utcDateTime | null;

  @doc("Remove users after they are in the room for N seconds.")
  @example(120)
  remove_after_seconds_elapsed: int32 | null;

  @doc("The room's initial layout.")
  @example(RoomLayout.`grid-responsive`)
  layout: RoomLayout;

  @doc("Specifies whether to start recording a Room Session when one is started for this Room.")
  @example(false)
  record_on_start: boolean;

  @doc("Whether a tone is played when participants enter or exit the room.")
  @example(true)
  tone_on_entry_and_exit: boolean;

  @doc("Whether the room's video is turned off when participants join.")
  @example(false)
  room_join_video_off: boolean;

  @doc("Whether a user's video is turned off when they join the room.")
  @example(false)
  user_join_video_off: boolean;

  @doc("Whether a video with a preview of the content of the room is to be generated.")
  @example(false)
  enable_room_previews: boolean | null;

  @doc("Enable/disable jitter buffer audio-video sync.")
  @example(true)
  sync_audio_video: boolean | null;

  @doc("User-defined metadata for the room.")
  @example(#{})
  meta: Record<unknown> | null;

  @doc("Whether hand raises are prioritized in the room layout.")
  @example(false)
  prioritize_handraise: boolean;

  @doc("Active session information for the room.")
  active_session?: ActiveSession;

  @doc("Timestamp when the room was created.")
  @example(utcDateTime.fromISO("2022-01-01T10:00:00Z"))
  created_at: utcDateTime;

  @doc("Timestamp when the room was last updated.")
  @example(utcDateTime.fromISO("2022-01-01T11:00:00Z"))
  updated_at: utcDateTime;
}

@doc("List rooms response.")
model ListRoomsResponse {
  @doc("Pagination links.")
  links: PaginationLinks;

  @doc("List of rooms.")
  data: RoomResponse[];
}
