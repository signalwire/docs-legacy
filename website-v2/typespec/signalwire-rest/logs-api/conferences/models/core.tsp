@doc("Core conference object.")
model Conference {
  @doc("Unique identifier for the conference.")
  @example("b9028451-b1d3-4690-b5d3-37b19d25f573")
  @format("uuid")
  id: string;

  @doc("Creation timestamp.")
  @example(utcDateTime.fromISO("2025-03-11T01:49:49.630Z"))
  created_at: utcDateTime;
}

model BaseConference is Conference {
  @doc("Project ID of the conference.")
  @example("a77ce7d0-6ae8-4b33-a7a6-0bf1750d1e19")
  project_id: uuid;

  @doc("Region of the conference.")
  @example("us1")
  region: string;

  @doc("Name of the conference.")
  @example("conference")
  name: string | null;

  @doc("Status of the conference.")
  @example("in-progress")
  status: string | null;

  @doc("Maximum size of the conference.")
  @example(2)
  max_size: integer | null;

  @doc("Current participants in the conference.")
  @example(1)
  current_participants: integer;

  @doc("Updated timestamp.")
  @example(utcDateTime.fromISO("2025-03-12T01:49:49.630Z"))
  updated_at: utcDateTime;
}

@summary("cXML Conference")
model CxmlConference is BaseConference {
  @doc("Type of the conference.")
  @example("cxml_conference")
  type: "cxml_conference";
}

@summary("Relay Conference")
model RelayConference is BaseConference {
  @doc("Type of the conference.")
  @example("relay_conference")
  type: "relay_conference";

  @doc("Recording URL of the conference.")
  @example("http://record.com")
  recording_url: string | null;

  @doc("Recording duration of the conference.")
  @example(123)
  recording_duration: integer | null;

  @doc("Recording file size of the conference.")
  @example(12345)
  recording_file_size: integer | null;
}

@summary("Video Room Session")
model VideoRoomSessionConference is Conference {
  @doc("Source of the conference.")
  @example("realtime_api")
  source: string;

  @doc("Type of the conference.")
  @example("video_conference_session")
  type: "video_conference_session" | "video_room_session";

  @doc("URL of the conference room session.")
  @example("https://test.signalwire.com/api/video/room_sessions/b9028451-b1d3-4690-b5d3-37b19d25f573")
  url: string;

  @doc("Name of the conference room.")
  @example("dmjjSRZphrx8Y1do2MwE")
  room_name: string | null;

  @doc("Status of the conference.")
  @example("completed")
  status: string | null;

  @doc("Whether the conference is locked.")
  @example(false)
  locked: boolean;

  @doc("Timestamp when the conference started.")
  @example(utcDateTime.fromISO("2025-03-11T01:49:51.069Z"))
  started_at: utcDateTime | null;

  @doc("Timestamp when the conference ended.")
  @example(utcDateTime.fromISO("2025-03-11T01:50:55.752Z"))
  ended_at: utcDateTime | null;

  @doc("Total charge amount of the conference in dollars.")
  @example("0.0")
  charge: string;

  @doc("Details on charges associated with this conference.")
  charge_details: ChargeDetails[];
}

model ChargeDetails {
  @doc("Description for this charge.")
  @example("Tax")
  description: string;

  @doc("Charge amount in dollars.")
  @example("0.50")
  charge: string;
}
