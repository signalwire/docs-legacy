import "./core.tsp";
import "./enums.tsp";

model ConferenceRoomCreateRequest {
  @doc("The name of the Conference Room")
  @example("coffee_cafe")
  name: string;

  @doc("Display name of the Conference Room")
  @example("Reception")
  @maxLength(200)
  display_name?: string;

  @doc("The descrption of the Conference Room")
  @example("This room is for coffee, no shop talk")
  @maxLength(3000)
  description?: string;

  @doc("The time users are allowed to start joining the conference. Joining before this time will result in failure to join the conference.")
  @example(UTC_TIME_EXAMPLE)
  join_from?: utcDateTime;

  @doc("The time users are allowed to until the conference is locked. Attempting to join the conference after the set time will result in failure to join the conference.")
  @example(UTC_TIME_EXAMPLE)
  join_until?: utcDateTime;

  @doc("Maximum number of members allowed in the conference room")
  @example(30)
  @minValue(0)
  @maxValue(300)
  max_members?: int32;

  @doc("The viudeo quality of the Conference Room.")
  @example("1080p")
  quality?: "1080p" | "720p" = "720p";

  @doc("The time to remove all participants from the conference.")
  @example(UTC_TIME_EXAMPLE)
  remove_at?: utcDateTime;

  @doc("The amount of time in seconds to remove a particpant from a conference after they join.")
  @minValue(0)
  @maxValue(200000)
  remove_after_seconds_elapsed?: int32;

  @doc("The video layout of the conference.")
  @example(Layout.Layout_Grid_Reponsive)
  layout?: Layout;

  @doc("Starts recording when the conference starts.")
  @example(true)
  record_on_start?: boolean;

  @doc("Enables live video room previews for the conference.")
  @example(true)
  enable_room_previews: boolean;

  @doc("Metadata of the conference.")
  @example(#{ foo: "bar" })
  meta?: {
    ...TypeSpec.Record<unknown>;
  };

  @doc("Syncs the participants audio and video.")
  @example(true)
  sync_audio_video?: boolean;

  @doc("Plays a tone when a participant joins or leaves the conference.")
  @example(true)
  tone_on_entry_and_exit?: boolean;

  @doc("Turns the conference video off when the participant joins the room if `true`.")
  @example(true)
  room_join_video_off?: boolean;

  @doc("Turns the participants video off when the participant joins the room if `true`.")
  @example(true)
  user_join_video_off?: boolean;
}

model ConferenceRoomUpdateRequest {
  @doc("The name of the Conference Room")
  @example("coffee_cafe")
  name?: string;

  @doc("Display name of the Conference Room")
  @example("Reception")
  @maxLength(200)
  display_name?: string;

  @doc("The descrption of the Conference Room")
  @example("This room is for coffee, no shop talk")
  @maxLength(3000)
  description?: string;

  @doc("The time users are allowed to start joining the conference. Joining before this time will result in failure to join the conference.")
  @example(UTC_TIME_EXAMPLE)
  join_from?: utcDateTime;

  @doc("The time users are allowed to until the conference is locked. Attempting to join the conference after the set time will result in failure to join the conference.")
  @example(UTC_TIME_EXAMPLE)
  join_until?: utcDateTime;

  @doc("Maximum number of members allowed in the conference room")
  @example(30)
  @minValue(0)
  @maxValue(300)
  max_members?: int32;

  @doc("The viudeo quality of the Conference Room.")
  @example("1080p")
  quality?: "1080p" | "720p" = "720p";

  @doc("The time to remove all participants from the conference.")
  @example(UTC_TIME_EXAMPLE)
  remove_at?: utcDateTime;

  @doc("The amount of time in seconds to remove a particpant from a conference after they join.")
  @minValue(0)
  @maxValue(200000)
  remove_after_seconds_elapsed?: int32;

  @doc("The video layout of the conference.")
  @example(Layout.Layout_Grid_Responsive_Mobile)
  layout?: Layout = Layout.Layout_Grid_Reponsive;

  @doc("Starts recording when the conference starts.")
  @example(true)
  record_on_start?: boolean;

  @doc("Enables live video room previews for the conference.")
  @example(true)
  enable_room_previews: boolean;

  @doc("Metadata of the conference.")
  @example(#{ foo: "bar" })
  meta?: {
    ...TypeSpec.Record<unknown>;
  };

  @doc("Syncs the participants audio and video.")
  @example(true)
  sync_audio_video: boolean;

  @doc("Plays a tone when a participant joins or leaves the conference.")
  @example(true)
  tone_on_entry_and_exit?: boolean;

  @doc("Turns the conference video off when the participant joins the room if `true`.")
  @example(true)
  room_join_video_off?: boolean;

  @doc("Turns the participants video off when the participant joins the room if `true`.")
  @example(true)
  user_join_video_off?: boolean;
}
