import "@typespec/http";
import "./core.tsp";
import "../../_shared/models.tsp";

using TypeSpec.Http;

@doc("Theme color properties for creating a conference.")
model CreateConferenceThemeColors {
  @doc("CTA buttons and selected items color (dark theme).")
  @example("#044EF4")
  @pattern("^#[0-9a-fA-F]{6}$")
  dark_primary?: string = "#044EF4";

  @doc("Main background color (dark theme).")
  @example("#FFFFFF")
  @pattern("^#[0-9a-fA-F]{6}$")
  dark_background?: string = "#FFFFFF";

  @doc("Main foreground color (dark theme).")
  @example("#1D2127")
  @pattern("^#[0-9a-fA-F]{6}$")
  dark_foreground?: string = "#1D2127";

  @doc("Success indication color (dark theme).")
  @example("#17BB58")
  @pattern("^#[0-9a-fA-F]{6}$")
  dark_success?: string = "#17BB58";

  @doc("Error indication color (dark theme).")
  @example("#F42C50")
  @pattern("^#[0-9a-fA-F]{6}$")
  dark_negative?: string = "#F42C50";

  @doc("CTA buttons and selected items color (light theme).")
  @example("#044EF4")
  @pattern("^#[0-9a-fA-F]{6}$")
  light_primary?: string = "#044EF4";

  @doc("Main background color (light theme).")
  @example("#FFFFFF")
  @pattern("^#[0-9a-fA-F]{6}$")
  light_background?: string = "#FFFFFF";

  @doc("Main foreground color (light theme).")
  @example("#1D2127")
  @pattern("^#[0-9a-fA-F]{6}$")
  light_foreground?: string = "#1D2127";

  @doc("Success indication color (light theme).")
  @example("#17BB58")
  @pattern("^#[0-9a-fA-F]{6}$")
  light_success?: string = "#17BB58";

  @doc("Error indication color (light theme).")
  @example("#F42C50")
  @pattern("^#[0-9a-fA-F]{6}$")
  light_negative?: string = "#F42C50";
}

@doc("Theme color properties for updating a conference.")
model UpdateConferenceThemeColors {
  @doc("CTA buttons and selected items color (dark theme).")
  @example("#044EF4")
  @pattern("^#[0-9a-fA-F]{6}$")
  dark_primary?: string;

  @doc("Main background color (dark theme).")
  @example("#FFFFFF")
  @pattern("^#[0-9a-fA-F]{6}$")
  dark_background?: string;

  @doc("Main foreground color (dark theme).")
  @example("#1D2127")
  @pattern("^#[0-9a-fA-F]{6}$")
  dark_foreground?: string;

  @doc("Success indication color (dark theme).")
  @example("#17BB58")
  @pattern("^#[0-9a-fA-F]{6}$")
  dark_success?: string;

  @doc("Error indication color (dark theme).")
  @example("#F42C50")
  @pattern("^#[0-9a-fA-F]{6}$")
  dark_negative?: string;

  @doc("CTA buttons and selected items color (light theme).")
  @example("#044EF4")
  @pattern("^#[0-9a-fA-F]{6}$")
  light_primary?: string;

  @doc("Main background color (light theme).")
  @example("#FFFFFF")
  @pattern("^#[0-9a-fA-F]{6}$")
  light_background?: string;

  @doc("Main foreground color (light theme).")
  @example("#1D2127")
  @pattern("^#[0-9a-fA-F]{6}$")
  light_foreground?: string;

  @doc("Success indication color (light theme).")
  @example("#17BB58")
  @pattern("^#[0-9a-fA-F]{6}$")
  light_success?: string;

  @doc("Error indication color (light theme).")
  @example("#F42C50")
  @pattern("^#[0-9a-fA-F]{6}$")
  light_negative?: string;
}

@doc("Query parameters for listing conferences.")
model ListConferencesRequest {
  @doc("Return conferences with a `join_from` time on or after this timestamp. Accepts RFC 3339 datetime or Unix timestamp.")
  @example("2022-01-01T00:00:00Z")
  @query
  starts_after?: string;

  @doc("Return conferences with a `join_until` time on or before this timestamp. Accepts RFC 3339 datetime or Unix timestamp.")
  @example("2022-12-31T23:59:59Z")
  @query
  ends_before?: string;

  @doc("Specifies whether to include information about the conference's active session (if any).")
  @example(true)
  @query
  include_active_session?: boolean;

  @doc("Page number to return. Requires `page_token` for values greater than 0.")
  @example(0)
  @query
  @minValue(0)
  page_number?: int32 = 0;

  @doc("Specify the number of results to return on a single page. The default page size is `50` and the maximum is `1000`.")
  @example(50)
  @query
  @minValue(1)
  @maxValue(1000)
  page_size?: int32 = 50;

  @doc("Token for cursor-based pagination. Required when `page_number` is greater than 0.")
  @example("PAb3877c40da604998")
  @query
  page_token?: string;
}

@doc("Request body for creating a conference.")
model CreateConferenceRequest {
  @doc("A named unique identifier for the conference. Allowed characters: `A-Za-z0-9_-`. Maximum of 100 characters.")
  @maxLength(100)
  @pattern("^[A-Za-z0-9_-]+$")
  @example("my_conference")
  name?: string;

  @doc("Display name of the video conference. Maximum of 200 characters.")
  @maxLength(200)
  @example("My Conference's Name")
  display_name: string;

  @doc("Description of the conference. Maximum of 3000 characters.")
  @maxLength(3000)
  @example("This conference will be used for full company all hands meetings")
  description?: string;

  @doc("Conference does not accept new participants before this time. Expects RFC 3339 datetime: `2022-01-01T23:59:60Z`. Date only: `2022-01-01` will be converted to `2022-01-01T00:00:00Z`.")
  @example(utcDateTime.fromISO("2022-01-01T00:00:00Z"))
  join_from?: utcDateTime;

  @doc("Conference stops accepting new participants at this time, but keeps running until all participants leave. Expects RFC 3339 datetime: `2022-01-01T23:59:60Z`. Date only: `2022-01-01` will be converted to `2022-01-01T00:00:00Z`.")
  @example(utcDateTime.fromISO("2022-12-31T23:59:59Z"))
  join_until?: utcDateTime;

  @doc("The conference's resolution.")
  @example(VideoQuality.`720p`)
  quality?: VideoQuality = VideoQuality.`720p`;

  @doc("The conference's initial layout.")
  @example(VideoLayout.`grid-responsive`)
  layout?: VideoLayout = VideoLayout.`grid-responsive`;

  @doc("The size of the video conference.")
  @example(ConferenceSize.medium)
  size?: ConferenceSize = ConferenceSize.medium;

  @doc("Whether to start recording when a conference session begins.")
  @example(true)
  record_on_start?: boolean;

  @doc("Whether a preview video of the conference content is generated.")
  @example(true)
  enable_room_previews?: boolean;

  @doc("Whether group chat is enabled for conference participants.")
  @example(true)
  enable_chat?: boolean = true;

  ...CreateConferenceThemeColors;
}

@doc("Request body for updating a conference.")
model UpdateConferenceRequest {
  @doc("Display name of the video conference. Maximum of 200 characters.")
  @maxLength(200)
  @example("My Conference's Name")
  display_name: string;

  @doc("Description of the conference. Maximum of 3000 characters.")
  @maxLength(3000)
  @example("This conference will be used for full company all hands meetings")
  description?: string;

  @doc("Conference does not accept new participants before this time. Expects RFC 3339 datetime: `2022-01-01T23:59:60Z`. Date only: `2022-01-01` will be converted to `2022-01-01T00:00:00Z`.")
  @example(utcDateTime.fromISO("2022-01-01T00:00:00Z"))
  join_from?: utcDateTime;

  @doc("Conference stops accepting new participants at this time, but keeps running until all participants leave. Expects RFC 3339 datetime: `2022-01-01T23:59:60Z`. Date only: `2022-01-01` will be converted to `2022-01-01T00:00:00Z`.")
  @example(utcDateTime.fromISO("2022-12-31T23:59:59Z"))
  join_until?: utcDateTime;

  @doc("The conference's resolution.")
  @example(VideoQuality.`720p`)
  quality?: VideoQuality = VideoQuality.`720p`;

  @doc("The conference's initial layout.")
  @example(VideoLayout.`grid-responsive`)
  layout?: VideoLayout = VideoLayout.`grid-responsive`;

  @doc("The size of the video conference.")
  @example(ConferenceSize.medium)
  size?: ConferenceSize = ConferenceSize.medium;

  @doc("Whether to start recording when a conference session begins.")
  @example(true)
  record_on_start?: boolean;

  @doc("Whether a tone is played when a member enters or exits the conference.")
  @example(true)
  tone_on_entry_and_exit?: boolean;

  @doc("Whether participants join with video off by room setting.")
  @example(false)
  room_join_video_off?: boolean;

  @doc("Whether participants join with video off by user setting.")
  @example(false)
  user_join_video_off?: boolean;

  @doc("Whether a preview video of the conference content is generated.")
  @example(true)
  enable_room_previews?: boolean;

  @doc("Whether group chat is enabled for conference participants.")
  @example(true)
  enable_chat?: boolean;

  ...UpdateConferenceThemeColors;
}
