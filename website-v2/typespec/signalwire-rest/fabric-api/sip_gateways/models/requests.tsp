import "../../../_globally_shared/enums.tsp";

model SipGatewayRequest {
  @doc("Display name for the SIP Gateway.")
  @example("My SIP Gateway")
  name: string;

  @doc("External SIP URI.")
  @example("user2@domain.com")
  uri: string;

  @doc("Specifies the encryption requirement for the SIP connection.")
  @example(Encryption.Required)
  encryption: Encryption;

  @doc("List of supported SIP ciphers.")
  @example(#[Ciphers.AEAD_AES_256_GCM_8, Ciphers.AES_256_CM_HMAC_SHA1_80])
  ciphers: Ciphers[];

  @doc("List of supported codecs for media transmission.")
  @example(#[Codecs.OPUS])
  codecs: Codecs[];
}
