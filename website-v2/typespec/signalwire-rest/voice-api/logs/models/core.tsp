import "@typespec/http";
import "../../../types";
import "../../const.tsp";
import "../../enums.tsp";

using TypeSpec.Http;

model LogPathID {
  @format("uuid")
  @path
  @doc("Unique ID of the log. This is the segment_id you can find in Relay call details in your Dashboard UI or in return objects when using the SDK.")
  @example("b7182dc2-00f3-40e4-a5ce-20f164b329df")
  id: uuid;
}

@doc("Details on charges associated with this log.")
model ChargeDetail {
  @doc("Description for this charge.")
  @example("Text to Speech")
  description: string;

  @doc("Charged amount.")
  @example(0.121176)
  charge: float64;
}

@doc("Common fields shared across all voice log types.")
model VoiceLogCommon {
  @format("uuid")
  @doc("A unique identifier for the log.")
  @example("b7182dc2-00f3-40e4-a5ce-20f164b329df")
  id: uuid;

  @doc("The origin phone number.")
  @example("+12065551212")
  from: string;

  @doc("The destination phone number.")
  @example("+12065553434")
  to: string;

  @doc("Source of this log entry.")
  @example(VoiceSources.realtime_api)
  source: VoiceSources;

  @doc("The charge in dollars.")
  @example(0.01)
  charge: float64;

  @doc("Details on charges associated with this log.")
  @example(#[])
  charge_details: ChargeDetail[];

  @doc("Date and time when the call entry was created.")
  @example(UTC_TIME_EXAMPLE)
  created_at: utcDateTime;
}

@summary("Call Log")
@doc("Voice log for Compatibility and Relay call types. Returned when `type` is `laml_call`, `relay_pstn_call`, `relay_sip_call`, or `relay_webrtc_call`.")
model RelayVoiceLog {
  ...VoiceLogCommon;

  @doc("Type of this log entry.")
  @example(RelayVoiceType.relay_sip_call)
  type: RelayVoiceType;

  @doc("URL for the resource associated with this log entry. Present for LAML calls, null for Relay calls.")
  @example(null)
  url: url | null;

  @doc("The direction of the voice activity.")
  @example(VoiceDirection.inbound)
  direction: VoiceDirection;

  @doc("The status of the voice activity.")
  @example(VoiceLogStatus.completed)
  status: VoiceLogStatus;

  @doc("The duration of the voice activity in seconds.")
  @example(9)
  duration: int32 | null;

  @doc("The duration of the voice activity in milliseconds.")
  @example(9638)
  duration_ms: int32 | null;

  @doc("The billable duration of the voice activity in milliseconds.")
  @example(60000)
  billing_ms: int32 | null;

  @doc("Parent log identifier for related call entries.")
  @example(null)
  parent_id: string | null;
}

@summary("Video Room Audio Leg Log")
@doc("Voice log for audio legs in a Video Room. Returned when `type` is `video_room_pstn_leg` or `video_room_sip_leg`.")
model VideoRoomVoiceLog {
  ...VoiceLogCommon;

  @doc("Type of this log entry.")
  @example(VideoRoomVoiceType.video_room_pstn_leg)
  type: VideoRoomVoiceType;

  @doc("Always null for this call type.")
  @example(null)
  url: null;

  @doc("The direction of the voice activity.")
  @example(VoiceDirection.inbound)
  direction: VoiceDirection;

  @doc("The status of the voice activity.")
  @example(VoiceLogStatus.completed)
  status: VoiceLogStatus;

  @doc("The duration of the voice activity in seconds.")
  @example(9)
  duration: int32 | null;

  @doc("The duration of the voice activity in milliseconds.")
  @example(9638)
  duration_ms: int32 | null;
}

@summary("Dialogflow Log")
@doc("Voice log for Dialogflow call types. Returned when `type` is `dialogflow_call`.")
model DialogflowVoiceLog {
  ...VoiceLogCommon;

  @doc("Type of this log entry.")
  @example(VoiceType.dialogflow_call)
  type: VoiceType.dialogflow_call;

  @doc("Always null for this call type.")
  @example(null)
  url: null;

  @doc("The status of the voice activity.")
  @example(VoiceLogStatus.completed)
  status: VoiceLogStatus;

  @doc("The duration of the voice activity in seconds.")
  @example(9)
  duration: int32 | null;
}

@summary("Fabric Device Log")
@doc("Voice log for Fabric Subscriber Device call types. Returned when `type` is `fabric_subscriber_device_leg`.")
model FabricVoiceLog {
  ...VoiceLogCommon;

  @doc("Type of this log entry.")
  @example(VoiceType.fabric_subscriber_device_leg)
  type: VoiceType.fabric_subscriber_device_leg;

  @doc("Always null for this call type.")
  @example(null)
  url: null;

  @doc("The direction of the voice activity.")
  @example(VoiceDirection.inbound)
  direction: VoiceDirection;

  @doc("The status of the voice activity. Always null for this call type.")
  @example(null)
  status: VoiceLogStatus | null;
}

@summary("Deleted Log")
@doc("A discarded/deleted voice log entry. Returned when the log has been deleted. Only present when `include_deleted` is `true`.")
model DiscardedVoiceLog {
  @format("uuid")
  @doc("A unique identifier for the log.")
  @example("b7182dc2-00f3-40e4-a5ce-20f164b329df")
  id: uuid;

  @doc("Date and time when the log was discarded.")
  @example(UTC_TIME_EXAMPLE)
  discarded_at: utcDateTime;

  @doc("Date and time when the log was originally created.")
  @example(UTC_TIME_EXAMPLE)
  created_at: utcDateTime;
}

@doc("A voice log entry. The specific fields present depend on the `type` value. Discarded logs return only `id`, `discarded_at`, and `created_at`.")
union VoiceLog {
  RelayVoiceLog,
  VideoRoomVoiceLog,
  DialogflowVoiceLog,
  FabricVoiceLog,
  DiscardedVoiceLog,
}

@doc("Event entry for a voice log")
model LogEvent {
  @doc("Timestamp when the event occurred.")
  @example(UTC_TIME_EXAMPLE)
  event_at: utcDateTime;

  @doc("Log level of the event.")
  @example("info")
  level: "info" | "warn" | "error" | "debug";

  @doc("Name of the event.")
  @example("calling_call_initiated")
  name: string;

  @doc("Additional details about the event. Structure varies by event type.")
  @example(#{})
  details: {};

  @format("uuid")
  @doc("Unique identifier for the project.")
  @example("b7182dc2-00f3-40e4-a5ce-20f164b329df")
  project_id: uuid;

  @format("uuid")
  @doc("Unique identifier for the log.")
  @example("b7182dc2-00f3-40e4-a5ce-20f164b329df")
  log_id: uuid;
}
