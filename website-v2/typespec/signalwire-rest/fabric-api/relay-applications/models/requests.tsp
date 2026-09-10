import "./core.tsp";

model RelayApplicationCreateRequest {
  @doc("Name of the Relay Application")
  @example("Booking Assistant")
  name: string;

  @doc("Topic of the Relay Application")
  @example("booking")
  topic: string;

  @doc("Call status callback URL")
  @example("https://booking.com/callbacks")
  call_status_callback_url?: string;
}

model RelayApplicationUpdateRequest {
  @doc("Name of the Relay Application")
  @example("Booking Assistant")
  name?: string;

  @doc("Topic of the Relay Application")
  @example("booking")
  topic?: string;

  @doc("Call status callback URL")
  @example("https://booking.com/callbacks")
  call_status_callback_url?: string;
}
