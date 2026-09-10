import "./core.tsp";

@doc("Request body for creating a room token.")
model CreateRoomTokenRequest {
  @doc("Room's unique named identifier. Allowed characters: A-Za-z0-9_-. Up to 100 characters. The room does not have to exist when the token is created, but must exist prior to joining, or ensure auto_create_room is set to true.")
  @example("my_room")
  @maxLength(100)
  @pattern("^[A-Za-z0-9_-]+$")
  room_name: string;

  @doc("A display name to use for the user. Up to 100 characters. (If not supplied, a random alphanumeric string will be returned for each authorization with this token.)")
  @example("John Smith")
  @maxLength(100)
  user_name?: string;

  @doc("A list of permissions, which define what user can do once they join the room. If `join_as` is `audience`, permissions are set to an empty array regardless of the value provided.")
  @example(#[
    RoomTokenPermission.`room.self.audio_mute`,
    RoomTokenPermission.`room.self.audio_unmute`,
    RoomTokenPermission.`room.self.video_mute`,
    RoomTokenPermission.`room.self.video_unmute`,
    RoomTokenPermission.`room.self.deaf`,
    RoomTokenPermission.`room.self.undeaf`,
    RoomTokenPermission.`room.self.set_input_volume`,
    RoomTokenPermission.`room.self.set_output_volume`,
    RoomTokenPermission.`room.self.set_input_sensitivity`
  ])
  permissions?: RoomTokenPermission[] = #[
    RoomTokenPermission.`room.self.audio_mute`,
    RoomTokenPermission.`room.self.audio_unmute`,
    RoomTokenPermission.`room.self.video_mute`,
    RoomTokenPermission.`room.self.video_unmute`,
    RoomTokenPermission.`room.self.deaf`,
    RoomTokenPermission.`room.self.undeaf`,
    RoomTokenPermission.`room.self.set_input_volume`,
    RoomTokenPermission.`room.self.set_output_volume`,
    RoomTokenPermission.`room.self.set_input_sensitivity`,
    RoomTokenPermission.`room.self.screenshare`,
    RoomTokenPermission.`room.self.additional_source`
  ];

  @doc("The user can't join the room before this time. Expects RFC 3339 datetime: `2022-01-01T23:59:60Z`. Date only: `2022-01-01` will be converted to `2022-01-01T00:00:00Z`")
  @example(utcDateTime.fromISO("2022-01-01T00:00:00Z"))
  join_from?: utcDateTime;

  @doc("The user can't join the room after this time. Expects RFC 3339 datetime: `2022-01-01T23:59:60Z`. Date only: `2022-01-01` will be converted to `2022-01-01T00:00:00Z`")
  @example(utcDateTime.fromISO("2022-12-31T23:59:59Z"))
  join_until?: utcDateTime;

  @doc("Remove user from the room at this time. Expects RFC 3339 datetime: `2022-01-01T23:59:60Z`. Date only: `2022-01-01` will be converted to `2022-01-01T00:00:00Z`")
  @example(utcDateTime.fromISO("2022-12-31T23:59:59Z"))
  remove_at?: utcDateTime;

  @doc("Remove user after they are in the room for N seconds.")
  @example(900)
  @minValueExclusive(0)
  @maxValue(200000)
  remove_after_seconds_elapsed?: int32;

  @doc("Whether the user joins the room with their audio muted.")
  @example(false)
  join_audio_muted?: boolean = false;

  @doc("Whether the user joins the room with their video muted.")
  @example(false)
  join_video_muted?: boolean = false;

  @doc("By default, if the user tries to use this token to join a room that doesn't exist, it will be created with default configuration. Set this to false to require the room to exist beforehand.")
  @example(true)
  auto_create_room?: boolean = true;

  @doc("Whether to generate a video with a preview of the content of the room. This parameter has effect only if this token auto-creates the room, thus it will be ignored if the room already exists.")
  @example(true)
  enable_room_previews?: boolean = false;

  @doc("Display name used if a room is auto-created when the token joins. Maximum of 200 characters. Defaults to the value of room_name.")
  @example("My Room")
  @maxLength(200)
  room_display_name?: string;

  @doc("Whether to end the room session when the member using this token leaves the room.")
  @example(false)
  end_room_session_on_leave?: boolean = false;

  @doc("Whether the user should join as a member or as a non-interactive audience participant. Audience participants cannot send audio or video.")
  @example(JoinAsType.member)
  join_as?: JoinAsType = JoinAsType.member;

  @doc("Indicates what media the user is allowed to receive.")
  @example(MediaAllowedType.`video-only`)
  media_allowed?: MediaAllowedType = MediaAllowedType.all;

  @doc("Set the room meta. Maximum of 2000 characters when serialized to JSON.")
  @example(#{ topic: "team-meeting" })
  room_meta?: Record<unknown>;

  @doc("Set the member meta. Maximum of 2000 characters when serialized to JSON.")
  @example(#{ name: "John Smith" })
  meta?: Record<unknown>;

  @doc("Enable/disable jitter buffer audio-video sync.")
  @example(true)
  sync_audio_video?: boolean = false;
}
