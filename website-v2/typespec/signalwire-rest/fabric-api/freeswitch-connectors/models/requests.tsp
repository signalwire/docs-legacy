import "./core.tsp";

model FreeswitchConnectorCreateRequest {
  @doc("Name of the FreeSWITCH Connector")
  @example("Booking Assistant")
  name: string;

  @doc("FreeSWITCH token")
  @example("993ed018-9e79-4e50-b97b-984bd5534095")
  @format("uuid")
  token: uuid;
}

model FreeswitchConnectorUpdateRequest {
  @doc("Name of the FreeSWITCH Connector")
  @example("Booking Assistant")
  name?: string;

  @doc("Caller ID for the connector")
  @example("123456")
  caller_id?: string;

  @doc("Send as identifier")
  @example("123456")
  send_as?: string;
}
