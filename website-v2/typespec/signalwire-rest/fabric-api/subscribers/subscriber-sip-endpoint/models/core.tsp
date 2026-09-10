import "./enums.tsp";
import "../../../../types";

using TypeSpec.Http;

model FabricSubscriberID {
  @doc("Unique ID of a Fabric Subscriber.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  fabric_subscriber_id: uuid;
}

model SIPEndpointID {
  @doc("Unique ID of a Sip Endpoint.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

model SubscriberSIPEndpoint {
  @doc("Unique ID of the Sip Endpoint.")
  @example("acaa5c49-be5e-4477-bce0-48f4b23b7720")
  id: uuid;

  @doc("Username of the Sip Endpoint.")
  @example("justice-league")
  username: string;

  @doc("Caller ID of the Sip Endpoint.")
  @example("call-id-123")
  caller_id: string;

  @doc("Purchased or verified number")
  @example("+14632322867")
  send_as: string;

  @doc("Ciphers of the Sip Endpoint.")
  ciphers: Ciphers[];

  @doc("Codecs of the Sip Endpoint.")
  codecs: Codecs[];

  @doc("Encryption requirement of the Sip Endpoint.")
  @example(Encryption.Optional)
  encryption: Encryption;
}
