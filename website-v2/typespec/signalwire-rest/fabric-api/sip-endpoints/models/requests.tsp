import "./core.tsp";
import "../../../_globally_shared/enums.tsp";

model SipEndpointCreateRequest {
  ...SipEndpoint;
}

model SipEndpointUpdateRequest {
  @doc("The username of the Sip Endpoint")
  @example("User")
  username?: string;

  @doc("The caller ID that will showup when dialing from this Sip Endpoint")
  @example("123456789")
  caller_id?: string;

  @doc("The Sip username that will show up on the calle's side. Overrides the username.")
  @example("Support")
  send_as?: string;

  @doc("Ciphers that can be enabled for calls on this Sip Endpoint.")
  @example(#[Ciphers.AEAD_AES_256_GCM_8, Ciphers.AES_256_CM_HMAC_SHA1_32])
  ciphers?: Ciphers[];

  @doc("Codecs that can be enabled for calls on this Sip Endpoint.")
  @example(#[Codecs.G722, Codecs.PCMA, Codecs.PCMU, Codecs.VP8])
  codecs?: Codecs[];

  @doc("The set encryption type on the Sip Endpoint.")
  @example(Encryption.Default)
  encryption?: Encryption = Encryption.Default;

  @doc(callHandlerDescription)
  @example(CallHandlerType.Default)
  call_handler?: CallHandlerType;

  @doc("If `call_handler` is set to `resource`, this field will contain the id of the set resouce. Will be `null` otherwise.")
  @example("993ed018-9e79-4e50-b97b-984bd5534095")
  calling_handler_resource_id: uuid | null;
}
