@doc("Join as type for room tokens.")
enum JoinAsType {
  @doc("Join as audience participant (cannot send audio or video)")
  audience,

  @doc("Join as member")
  member,
}

@doc("Media allowed type for room tokens.")
enum MediaAllowedType {
  @doc("All media allowed")
  all,

  @doc("Video only")
  `video-only`,

  @doc("Audio only")
  `audio-only`,
}

@doc("Valid permission scopes for room tokens.")
enum RoomTokenPermission {
  @doc("Mute another member's audio")
  `room.member.audio_mute`: "room.member.audio_mute",

  @doc("Unmute another member's audio")
  `room.member.audio_unmute`: "room.member.audio_unmute",

  @doc("Mute another member's video")
  `room.member.video_mute`: "room.member.video_mute",

  @doc("Unmute another member's video")
  `room.member.video_unmute`: "room.member.video_unmute",

  @doc("Deafen another member")
  `room.member.deaf`: "room.member.deaf",

  @doc("Undeafen another member")
  `room.member.undeaf`: "room.member.undeaf",

  @doc("Set another member's input volume")
  `room.member.set_input_volume`: "room.member.set_input_volume",

  @doc("Set another member's output volume")
  `room.member.set_output_volume`: "room.member.set_output_volume",

  @doc("Set another member's input sensitivity")
  `room.member.set_input_sensitivity`: "room.member.set_input_sensitivity",

  @doc("Set another member's position")
  `room.member.set_position`: "room.member.set_position",

  @doc("Set another member's metadata")
  `room.member.set_meta`: "room.member.set_meta",

  @doc("Raise another member's hand")
  `room.member.raisehand`: "room.member.raisehand",

  @doc("Lower another member's hand")
  `room.member.lowerhand`: "room.member.lowerhand",

  @doc("Remove another member from the room")
  `room.member.remove`: "room.member.remove",

  @doc("Promote another member")
  `room.member.promote`: "room.member.promote",

  @doc("Demote another member")
  `room.member.demote`: "room.member.demote",

  @doc("Hide video-muted members in the room")
  `room.hide_video_muted`: "room.hide_video_muted",

  @doc("List available layouts for the room")
  `room.list_available_layouts`: "room.list_available_layouts",

  @doc("Lock the room")
  `room.lock`: "room.lock",

  @doc("Control room playback")
  `room.playback`: "room.playback",

  @doc("Seek room playback position")
  `room.playback_seek`: "room.playback_seek",

  @doc("Prioritize raised hands in the room")
  `room.prioritize_handraise`: "room.prioritize_handraise",

  @doc("Control room recording")
  `room.recording`: "room.recording",

  @doc("Set the room layout")
  `room.set_layout`: "room.set_layout",

  @doc("Set position in the room")
  `room.set_position`: "room.set_position",

  @doc("Set room metadata")
  `room.set_meta`: "room.set_meta",

  @doc("Show video-muted members in the room")
  `room.show_video_muted`: "room.show_video_muted",

  @doc("Control room streaming")
  `room.stream`: "room.stream",

  @doc("Unlock the room")
  `room.unlock`: "room.unlock",

  @doc("Mute your own audio")
  `room.self.audio_mute`: "room.self.audio_mute",

  @doc("Unmute your own audio")
  `room.self.audio_unmute`: "room.self.audio_unmute",

  @doc("Mute your own video")
  `room.self.video_mute`: "room.self.video_mute",

  @doc("Unmute your own video")
  `room.self.video_unmute`: "room.self.video_unmute",

  @doc("Deafen yourself")
  `room.self.deaf`: "room.self.deaf",

  @doc("Undeafen yourself")
  `room.self.undeaf`: "room.self.undeaf",

  @doc("Set your own input volume")
  `room.self.set_input_volume`: "room.self.set_input_volume",

  @doc("Set your own output volume")
  `room.self.set_output_volume`: "room.self.set_output_volume",

  @doc("Set your own input sensitivity")
  `room.self.set_input_sensitivity`: "room.self.set_input_sensitivity",

  @doc("Set your own position")
  `room.self.set_position`: "room.self.set_position",

  @doc("Set your own metadata")
  `room.self.set_meta`: "room.self.set_meta",

  @doc("Raise your own hand")
  `room.self.raisehand`: "room.self.raisehand",

  @doc("Lower your own hand")
  `room.self.lowerhand`: "room.self.lowerhand",

  @doc("Share your screen")
  `room.self.screenshare`: "room.self.screenshare",

  @doc("Share an additional source")
  `room.self.additional_source`: "room.self.additional_source",
}
