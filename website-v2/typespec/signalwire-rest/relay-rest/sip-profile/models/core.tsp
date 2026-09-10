import "../../../types";

using TypeSpec.Http;
using Types;

@doc("SIP profile model.")
model SipProfile {
  @doc("A string representation of the fully qualified domain name for this profile.")
  @example("your-space-example.sip.signalwire.com")
  domain?: string;

  @doc("String representing the domain_identifier portion of the profile. Must be unique across your project.")
  @example("example")
  domain_identifier?: string;

  @doc("A list of codecs this profile will support. Currently supported values are: OPUS, G722, PCMU, PCMA, VP8, H264.")
  default_codecs?: string[];

  @doc("A list of encryption ciphers this profile will support. Currently supported values are: AEAD_AES_256_GCM_8, AES_256_CM_HMAC_SHA1_80, AES_CM_128_HMAC_SHA1_80, AES_256_CM_HMAC_SHA1_32, AES_CM_128_HMAC_SHA1_32.")
  default_ciphers?: string[];

  @doc("A string representing whether connections to an endpoint that uses this profile require encryption or if encryption is optional. Encryption will always be used if possible. Possible values are required or optional.")
  @example("optional")
  default_encryption?: "required" | "optional";

  @doc("The e164 formatted number you wish to set as the originating number when dialing PSTN phone numbers from a SIP Endpoint that uses this profile. Specify null or an empty string to randomly choose a purchased or verified number from within the project.")
  @example("+15551234567")
  default_send_as?: string;
}
