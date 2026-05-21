import "../../../types";
import "../../../_globally_shared/enums.tsp";
import "../enums.tsp";

using TypeSpec.Http;

const callHandlerDescription = """
  Specify how the SIP endpoint will handle outbound calls.
  - **default**: The SIP endpoint will pull the outbound policy setting from the [SIP Profile Settings](https://my.signalwire.com?page=sip_profile/edit). This allows centralized management of outbound call behavior across multiple endpoints from a single configuration.
  - **passthrough**: The SIP endpoint will be allowed to dial PSTN numbers. This permits outbound calling to traditional phone numbers without restrictions.
  - **block-pstn**: The SIP endpoint will be blocked from dialing PSTN numbers. Use this to restrict the endpoint from initiating calls to the public telephone network.
  - **resource**: Outbound calls from this SIP endpoint will dial the specified resource and execute its instructions. Requires setting `calling_handler_resource_id` to a valid resource. This enables custom call handling workflows for outbound calls. See the [Fabric REST API](/apis/fabric) for valid resource types.
  """;

model SipEndpointPathID {
  @doc("Unique ID of a SIP Endpoint.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

model SipEndpoint {
  @doc("The id of the Sip Endpoint")
  @example("993ed018-9e79-4e50-b97b-984bd5534095")
  @format("uuid")
  id: uuid;

  @doc("The username of the Sip Endpoint")
  @example("User")
  username: string;

  @doc("The caller ID that will showup when dialing from this Sip Endpoint")
  @example("123456789")
  caller_id: string;

  @doc("The Sip username that will show up on the calle's side. Overrides the username.")
  @example("Support")
  send_as: string;

  @doc("Ciphers that can be enabled for calls on this Sip Endpoint.")
  @example(#[Ciphers.AEAD_AES_256_GCM_8, Ciphers.AES_256_CM_HMAC_SHA1_32])
  ciphers: Ciphers[];

  @doc("Codecs that can be enabled for calls on this Sip Endpoint.")
  @example(#[Codecs.G722, Codecs.PCMA, Codecs.PCMU, Codecs.VP8])
  codecs: Codecs[];

  @doc("The set encryption type on the Sip Endpoint.")
  @example(Encryption.Default)
  encryption: Encryption = Encryption.Default;

  @doc(callHandlerDescription)
  @example(CallHandlerType.Default)
  call_handler: CallHandlerType;

  @doc("If `call_handler` is set to `resource`, this field expects the id of the set resouce. Will be `null` otherwise.")
  @example("993ed018-9e79-4e50-b97b-984bd5534095")
  calling_handler_resource_id: uuid | null;
}
