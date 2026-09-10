import "@typespec/openapi3";
import "../../../../_globally_shared/enums.tsp";

using TypeSpec.OpenAPI;

model SubscriberSipEndpointRequest {
  @doc("Username of the Sip Endpoint.")
  @example("justice-league")
  username: string;

  @doc("Password of the Sip Endpoint.")
  @example("hack-me-if-you-can")
  password: string;

  @doc("Caller ID of the Sip Endpoint.")
  @example("call-id-123")
  caller_id?: string;

  @doc("The Number to send as.")
  @example("+14632322867")
  send_as?: string;

  @doc("Ciphers of the Sip Endpoint.")
  ciphers?: Ciphers[];

  @doc("Codecs of the Sip Endpoint.")
  codecs?: Codecs[];

  @doc("Encryption requirement of the Sip Endpoint.")
  @example(Encryption.Optional)
  encryption?: Encryption = Encryption.Default;
}
