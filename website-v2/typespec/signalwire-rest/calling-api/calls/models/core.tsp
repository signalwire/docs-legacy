import "../const.tsp";

@doc("The direction of the call.")
enum CallDirection {
  @doc("An inbound call received by the system.")
  inbound,

  @doc("An outbound call placed by the system.")
  outbound,

  @doc("An outbound call initiated via the API.")
  `outbound-api`,
}

@doc("The type of call.")
enum CallType {
  @doc("A PSTN call placed via Relay.")
  relay_pstn_call,

  @doc("A SIP call placed via Relay.")
  relay_sip_call,

  @doc("A WebRTC call placed via Relay.")
  relay_webrtc_call,

  @doc("A Fabric subscriber device leg.")
  fabric_subscriber_device_leg,
}

@doc("Fields shared by all call leg types.")
model CallBase {
  @doc("The unique identifier of the call on SignalWire. This can be used to update the call programmatically.")
  @example("0e9c80d7-a149-4917-892d-420043709f45")
  id: uuid;

  @doc("The origin number or address.")
  @example("+12069708643")
  from: string;

  @doc("The destination number or address.")
  @example("+15550198765")
  to: string;

  @doc("The direction of the call.")
  @example(CallDirection.`outbound-api`)
  direction: CallDirection;

  @doc("Source of this call.")
  @example("realtime_api")
  source: "realtime_api";

  @doc("The URL associated with this call.")
  @example(null)
  url: string | null;

  @doc("Total charge for this call.")
  @example(0)
  charge: float64;

  @doc("The date and time when the call was created.")
  @example(UTC_TIME_EXAMPLE)
  created_at: utcDateTime;

  @doc("Details on charges associated with this call.")
  @example(#[#{ description: "Outbound Voice", charge: 0.004 }])
  charge_details: ChargeDetails[];
}

@doc("A Call leg (PSTN, SIP, or WebRTC).")
model CallLeg {
  ...CallBase;

  @doc("The status of the call.")
  @example(CallResponseStatus.queued)
  status: CallResponseStatus | null;

  @doc("The duration of the call in seconds.")
  @example(null)
  duration: integer | null;

  @doc("The duration of the call in milliseconds.")
  @example(null)
  duration_ms: integer | null;

  @doc("The billable duration of the call in milliseconds.")
  @example(null)
  billing_ms: integer | null;

  @doc("Type of this call.")
  @example(CallType.relay_pstn_call)
  type: CallType.relay_pstn_call | CallType.relay_sip_call | CallType.relay_webrtc_call;

  @doc("The parent call ID if this is a child call.")
  @example(null)
  parent_id: uuid | null;
}

@doc("A Fabric subscriber device leg.")
model FabricDeviceLeg {
  ...CallBase;

  @doc("The status of the call. Always null for Fabric subscriber device legs.")
  @example(null)
  status: null;

  @doc("Type of this call.")
  @example(CallType.fabric_subscriber_device_leg)
  type: CallType.fabric_subscriber_device_leg;
}

model ChargeDetails {
  @doc("Description for this charge.")
  @example("Text to Speech")
  description: string;

  @doc("Charged amount.")
  @example(0.121176)
  charge: float64;
}
