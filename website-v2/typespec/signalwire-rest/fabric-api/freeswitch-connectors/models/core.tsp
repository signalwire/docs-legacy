import "../../../types";

using TypeSpec.Http;

model FreeswitchConnectorPathID {
  @doc("Unique ID of a FreeSWITCH Connector.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

model FreeswitchConnector {
  @doc("Unique ID of a FreeSWITCH Connector.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  id: uuid;

  @doc("Name of the FreeSWITCH Connector")
  @example("Booking Assistant")
  name?: string;

  @doc("Caller ID for the connector")
  @example("123456")
  caller_id?: string | null;

  @doc("Send as identifier")
  @example("123456")
  send_as?: string | null;
}
