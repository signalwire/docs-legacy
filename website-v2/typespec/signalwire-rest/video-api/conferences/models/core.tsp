import "@typespec/http";
import "../../_shared/models.tsp";

using TypeSpec.Http;

@doc("Conference size options.")
enum ConferenceSize {
  @doc("Small conference (up to 10 members)")
  small,

  @doc("Medium conference (up to 50 members)")
  medium,

  @doc("Large conference (up to 300 members)")
  large,
}

model ConferencePathID {
  @path
  @format("uuid")
  @doc("Unique ID of the video conference.")
  @example("c22d24f6-5a47-4597-9a23-c7d01e696b92")
  id: string;
}

@doc("Theme color properties for a conference.")
model ConferenceThemeColors {
  @doc("CTA buttons and selected items color (dark theme).")
  @example("#044EF4")
  dark_primary: string | null;

  @doc("Main background color (dark theme).")
  @example("#FFFFFF")
  dark_background: string | null;

  @doc("Main foreground color (dark theme).")
  @example("#1D2127")
  dark_foreground: string | null;

  @doc("Success indication color (dark theme).")
  @example("#17BB58")
  dark_success: string | null;

  @doc("Error indication color (dark theme).")
  @example("#F42C50")
  dark_negative: string | null;

  @doc("CTA buttons and selected items color (light theme).")
  @example("#044EF4")
  light_primary: string | null;

  @doc("Main background color (light theme).")
  @example("#FFFFFF")
  light_background: string | null;

  @doc("Main foreground color (light theme).")
  @example("#1D2127")
  light_foreground: string | null;

  @doc("Success indication color (light theme).")
  @example("#17BB58")
  light_success: string | null;

  @doc("Error indication color (light theme).")
  @example("#F42C50")
  light_negative: string | null;
}

@doc("Video conference response object.")
model Conference {
  @doc("Unique ID of the video conference.")
  @format("uuid")
  @example("c22d24f6-5a47-4597-9a23-c7d01e696b92")
  id: string;

  @doc("A named unique identifier for the conference. Allowed characters: `A-Za-z0-9_-`.")
  @example("my_conference")
  name: string;

  @doc("Display name of the video conference. Maximum of 200 characters.")
  @example("My Conference's Name")
  display_name: string | null;

  @doc("Description of the conference. Maximum of 3000 characters.")
  @example("This conference will be used for full company all hands meetings")
  description: string | null;

  @doc("Conference does not accept new participants before this time.")
  @example(utcDateTime.fromISO("2022-01-01T00:00:00Z"))
  join_from: utcDateTime | null;

  @doc("Conference stops accepting new participants at this time, but keeps running until all participants leave.")
  @example(utcDateTime.fromISO("2022-12-31T23:59:59Z"))
  join_until: utcDateTime | null;

  @doc("The conference's resolution.")
  @example(VideoQuality.`720p`)
  quality: VideoQuality;

  @doc("The conference's initial layout.")
  @example(VideoLayout.`grid-responsive`)
  layout: VideoLayout;

  @doc("The size of the video conference.")
  @example(ConferenceSize.medium)
  size: ConferenceSize | null;

  @doc("Whether to start recording when a conference session begins.")
  @example(false)
  record_on_start: boolean;

  @doc("Whether a tone is played when a member enters or exits the conference.")
  @example(true)
  tone_on_entry_and_exit: boolean;

  @doc("Whether participants join with video off by user setting.")
  @example(false)
  user_join_video_off: boolean;

  @doc("Whether participants join with video off by room setting.")
  @example(false)
  room_join_video_off: boolean;

  @doc("Whether group chat is enabled for conference participants.")
  @example(true)
  enable_chat: boolean;

  @doc("Whether a preview video of the conference content is generated.")
  @example(false)
  enable_room_previews: boolean | null;

  ...ConferenceThemeColors;

  @doc("User-defined metadata for the conference.")
  @example(null)
  meta: Record<unknown> | null;

  @doc("Timestamp when the conference was created.")
  @example(utcDateTime.fromISO("2022-01-01T10:00:00Z"))
  created_at: utcDateTime;

  @doc("Timestamp when the conference was last updated.")
  @example(utcDateTime.fromISO("2022-01-01T11:00:00Z"))
  updated_at: utcDateTime;

  @doc("Active session information. Only present when requested via the `include_active_session` query parameter.")
  active_session?: ActiveSession;
}
