import "../_globally_shared/enums.tsp";

enum VoiceLogStatus {
  queued,
  initiated,
  ringing,
  `in-progress`,
  busy,
  failed,
  `no-answer`,
  canceled,
  completed,
  ended,
  answered,
  created,
  ending,
  joined,
}

enum VoiceDirection {
  inbound,
  outbound,
  `outbound-api`,
  `outbound-dial`,
}

enum VoiceSources {
  dialogflow,
  laml,
  realtime_api,
}

enum VoiceType {
  dialogflow_call,
  laml_call,
  relay_pstn_call,
  relay_sip_call,
  relay_webrtc_call,
  video_room_pstn_leg,
  video_room_sip_leg,
  fabric_subscriber_device_leg,
}

enum RelayVoiceType {
  laml_call: "laml_call",
  relay_pstn_call: "relay_pstn_call",
  relay_sip_call: "relay_sip_call",
  relay_webrtc_call: "relay_webrtc_call",
}

enum VideoRoomVoiceType {
  video_room_pstn_leg: "video_room_pstn_leg",
  video_room_sip_leg: "video_room_sip_leg",
}
