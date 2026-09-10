import "../../../types";

using TypeSpec.Http;

model ConferenceRoomPathID {
  @doc("Unique ID of a Conference Room.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

model ConferenceRoom {
  @doc("The unique id of the Conference Room")
  @example("1bd571e4-5ea4-4a70-a3c8-2bab5d20e754")
  @format("uuid")
  id: uuid;

  @doc("The name of the Conference Room")
  @example("coffee_cafe")
  name: string;

  @doc("The descrption of the Conference Room")
  @example("This room is for coffee, no shop talk")
  @maxLength(3000)
  description: string;

  @doc("Display name of the Conference Room")
  @example("Reception")
  @maxLength(200)
  display_name: string;

  @doc("Maximum number of members allowed in the conference room")
  @example(30)
  @minValue(0)
  @maxValue(300)
  max_members: int32;

  @doc("The viudeo quality of the Conference Room.")
  @example("1080p")
  quality: "1080p" | "720p" = "720p";

  @doc("The frames-per-second (fps) of the participants videos in the conference.")
  @example(30)
  fps: 30 | 20;

  @doc("The time users are allowed to start joining the conference. Joining before this time will result in failure to join the conference.")
  @example(UTC_TIME_EXAMPLE)
  join_from: utcDateTime | null;

  @doc("The time users are allowed to until the conference is locked. Attempting to join the conference after the set time will result in failure to join the conference.")
  @example(UTC_TIME_EXAMPLE)
  join_until: utcDateTime | null;

  @doc("The time to remove all participants from the conference.")
  @example(UTC_TIME_EXAMPLE)
  remove_at: utcDateTime | null;

  @doc("The amount of time in seconds to remove a particpant from a conference after they join.")
  @minValue(0)
  @maxValue(200000)
  remove_after_seconds_elapsed: int32 | null;

  @doc("The video layout of the conference.")
  @example(Layout.Layout_Grid_Reponsive)
  layout: Layout;

  @doc("Starts recording when the conference starts.")
  @example(true)
  record_on_start: boolean;

  @doc("Plays a tone when a participant joins or leaves the conference.")
  @example(true)
  tone_on_entry_and_exit: boolean;

  @doc("Turns the conference video off when the participant joins the room if `true`.")
  @example(true)
  room_join_video_off: boolean;

  @doc("Turns the participants video off when the participant joins the room if `true`.")
  @example(true)
  user_join_video_off: boolean;

  @doc("Enables live video room previews for the conference.")
  @example(true)
  enable_room_previews: boolean;

  @doc("Syncs the participants audio and video.")
  @example(true)
  sync_audio_video: boolean | null;

  @doc("Metadata of the conference.")
  @example(#{ foo: "bar" })
  meta: {
    ...TypeSpec.Record<unknown>;
  };

  @doc("Indicator if the Conference Room will prioritize showing participants utilizing the hand raised feature.")
  @example(false)
  prioritize_handraise: boolean;
}
