import "@typespec/http";
import "../../_shared/models.tsp";

using TypeSpec.Http;

@doc("Status of a room session.")
enum RoomSessionStatus {
  @doc("The room session is currently active.")
  `in-progress`,

  @doc("The room session has ended.")
  completed,
}

@doc("Status of a room recording.")
enum RoomRecordingStatus {
  @doc("The recording is actively capturing.")
  recording,

  @doc("The recording has been paused.")
  paused,

  @doc("The recording has ended and is being processed.")
  processing,

  @doc("The recording is complete and available.")
  completed,
}

model RoomSessionPathID {
  @path
  @format("uuid")
  @doc("Unique ID of the Room Session.")
  @example("c22d24f6-5a47-4597-9a23-c7d01e696b92")
  id: string;
}

@doc("Room session response object.")
model RoomSession {
  @doc("Unique ID of the session.")
  @format("uuid")
  @example("c22d24f6-5a47-4597-9a23-c7d01e696b92")
  id: string;

  @doc("Unique ID of the Room if the Session was created from a Room and was not an auto-created Session. Null if the room was set to delete on end.")
  @format("uuid")
  @example("a1b2c3d4-5e6f-7890-abcd-ef1234567890")
  room_id: string | null;

  @doc("The named identifier of the room session.")
  @example("my_example_room")
  name: string | null;

  @doc("Display name of the room. Maximum of 200 characters. Defaults to the value of name.")
  @example("My Room's Name")
  display_name: string | null;

  @doc("The maximum number of members allowed in the room at a time.")
  @example(20)
  max_members: int32 | null;

  @doc("The room session's resolution.")
  @example(VideoQuality.`720p`)
  quality: VideoQuality | null;

  @doc("The room session's frames per second.")
  @example(VideoFps.`20`)
  fps: VideoFps | null;

  @doc("Room Session does not accept new Members before this time.")
  @example(utcDateTime.fromISO("2022-01-01T00:00:00Z"))
  join_from: utcDateTime | null;

  @doc("Room Session stops accepting new Members at this time.")
  @example(utcDateTime.fromISO("2022-12-31T23:59:59Z"))
  join_until: utcDateTime | null;

  @doc("Remove Members from the Room Session at this time.")
  @example(utcDateTime.fromISO("2022-12-31T23:59:59Z"))
  remove_at: utcDateTime | null;

  @doc("Remove Members after they are in the Room Session for N seconds.")
  @example(120)
  remove_after_seconds_elapsed: int32 | null;

  @doc("The room session's initial layout.")
  @example("grid-responsive")
  layout: string | null;

  @doc("Whether a recording was automatically started when this Room Session began.")
  @example(false)
  record_on_start: boolean;

  @doc("Whether a tone is played when a member enters or exits the room session.")
  @example(true)
  tone_on_entry_and_exit: boolean;

  @doc("Whether participants join with video off by room setting.")
  @example(false)
  room_join_video_off: boolean;

  @doc("Whether participants join with video off by user setting.")
  @example(false)
  user_join_video_off: boolean;

  @doc("Whether the room session is locked.")
  @example(false)
  locked: boolean;

  @doc("Start time of the session.")
  @example(utcDateTime.fromISO("2022-01-01T10:00:00Z"))
  start_time: utcDateTime | null;

  @doc("End time of the session.")
  @example(utcDateTime.fromISO("2022-01-01T11:00:00Z"))
  end_time: utcDateTime | null;

  @doc("How long, in seconds, the Room Session lasted.")
  @example(120)
  duration: int32 | null;

  @doc("Status of the session.")
  @example(RoomSessionStatus.completed)
  status: RoomSessionStatus | null;

  @doc("Timestamp when the room session was created.")
  @example(utcDateTime.fromISO("2022-01-01T10:00:00Z"))
  created_at: utcDateTime;

  @doc("Timestamp when the room session was last updated.")
  @example(utcDateTime.fromISO("2022-01-01T11:00:00Z"))
  updated_at: utcDateTime;

  @doc("If room previews are enabled and the room session is in progress, this is the URL of the preview video.")
  @example("https://example.signalwire.com/preview/abc123")
  preview_url: string | null;

  @doc("Whether raised hands are prioritized in the layout.")
  @example(false)
  prioritize_handraise: boolean | null;

  @doc("Enable/disable jitter buffer audio-video sync.")
  @example(true)
  sync_audio_video: boolean | null;

  @doc("The cost of the room session in dollars.")
  @example(0.05)
  cost_in_dollars: float64;

  @doc("Whether a video with a preview of the content of the room is to be generated.")
  @example(true)
  enable_room_previews: boolean;

  @doc("URL of the locked room cover image.")
  @example("https://example.signalwire.com/locked-cover.png")
  locked_cover: string;
}

@doc("Room recording response object.")
model RoomRecording {
  @doc("Unique ID of the Room Recording.")
  @format("uuid")
  @example("c22d24f6-5a47-4597-9a23-c7d01e696b92")
  id: string;

  @doc("Unique ID of the Room Session the Room Recording was made in.")
  @format("uuid")
  @example("a1b2c3d4-5e6f-7890-abcd-ef1234567890")
  room_session_id: string;

  @doc("Status of the recording.")
  @example(RoomRecordingStatus.completed)
  status: RoomRecordingStatus | null;

  @doc("Timestamp of when the Room Recording started.")
  @example(utcDateTime.fromISO("2022-01-01T10:00:00Z"))
  started_at: utcDateTime | null;

  @doc("Timestamp of when the Room Recording stopped.")
  @example(utcDateTime.fromISO("2022-01-01T11:00:00Z"))
  finished_at: utcDateTime | null;

  @doc("The length of the Room Recording in seconds.")
  @example(120)
  duration: int32 | null;

  @doc("The number of bytes of the Room Recording file.")
  @example(20971520)
  size_in_bytes: int32 | null;

  @doc("The MIME type of the Room Recording file.")
  @example("video/mp4")
  format: string | null;

  @doc("The cost of the recording in dollars.")
  @example(0.05)
  cost_in_dollars: float64;

  @doc("A temporary URL for accessing the recording file. By default, valid for 15 minutes.")
  @example("https://files.signalwire.com/temporary/link/to/the/recording/file")
  uri: string | null;

  @doc("Timestamp when the recording was created.")
  @example(utcDateTime.fromISO("2022-01-01T10:00:00Z"))
  created_at: utcDateTime;

  @doc("Timestamp when the recording was last updated.")
  @example(utcDateTime.fromISO("2022-01-01T11:00:00Z"))
  updated_at: utcDateTime;
}

@doc("Room session member response object.")
model RoomSessionMember {
  @doc("Unique ID of the Member.")
  @format("uuid")
  @example("c22d24f6-5a47-4597-9a23-c7d01e696b92")
  id: string;

  @doc("Unique ID of the Room Session.")
  @format("uuid")
  @example("a1b2c3d4-5e6f-7890-abcd-ef1234567890")
  room_session_id: string;

  @doc("Display name of the Member.")
  @example("John Smith")
  name: string | null;

  @doc("Timestamp of when the Member joined the Room Session.")
  @example(utcDateTime.fromISO("2022-01-01T10:00:00Z"))
  join_time: utcDateTime | null;

  @doc("Timestamp of when the Member left the Room Session.")
  @example(utcDateTime.fromISO("2022-01-01T11:00:00Z"))
  leave_time: utcDateTime | null;

  @doc("How long the Member stayed in the Room Session, in seconds. Null if the member has not yet joined.")
  @example(120)
  duration: int32 | null;

  @doc("The cost of the member's participation in dollars.")
  @example(0.05)
  cost_in_dollars: float64;
}

@doc("Room session event response object.")
model RoomSessionEvent {
  @doc("Unique ID of the event.")
  @format("uuid")
  @example("e44f56a8-7c69-6153-b45c-ab3456789012")
  id: string;

  @doc("The ID of the project.")
  @format("uuid")
  @example("a1b2c3d4-5e6f-7890-abcd-ef1234567890")
  project_id: string;

  @doc("The ID of the room.")
  @format("uuid")
  @example("b2c3d4e5-6f70-8901-bcde-f12345678901")
  room_id: string;

  @doc("The ID of the room session.")
  @format("uuid")
  @example("c22d24f6-5a47-4597-9a23-c7d01e696b92")
  room_session_id: string;

  @doc("The ID of the associated room recording. Only present for recording-related events.")
  @format("uuid")
  @example("d33e35f7-6b58-5042-a34b-ef2345678901")
  room_recording_id?: string;

  @doc("The ID of the associated room participant. Only present for participant-related events.")
  @format("uuid")
  @example("e44f68a9-7c69-6153-b56d-ef3456789012")
  room_participant_id?: string;

  @doc("The severity level of the event.")
  @example("info")
  level: string;

  @doc("The name of the event.")
  @example("room.started")
  name: string;

  @doc("Event-specific payload data.")
  payload: Record<unknown>;

  @doc("Timestamp when the event was created.")
  @example(utcDateTime.fromISO("2022-01-01T10:00:00Z"))
  created_at: utcDateTime;
}
