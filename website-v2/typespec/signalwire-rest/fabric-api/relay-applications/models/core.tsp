import "../../../types";

using TypeSpec.Http;

model RelayApplicationPathID {
  @doc("Unique ID of a Relay Application.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

model RelayApplication {
  @doc("Unique ID of a Relay Application.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  id: uuid;

  @doc("Name of the Relay Application")
  @example("Booking Assistant")
  name: string;

  @doc("Topic of the Relay Application")
  @example("booking")
  topic: string;

  @doc("Call status callback URL")
  @example("https://example.com/callbacks")
  call_status_callback_url: url | null;
}
