import "../../../types";
import "@typespec/openapi3";
import "../../_shared/fabric-address";
import "../../_shared/enums.tsp";
import "../../_shared/const.tsp";
import "../../../_globally_shared/enums.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

model SipGatewayResponse {
  @doc("Unique ID of the resource.")
  @example("0823a606-0aff-4c90-9eba-f88ba118fe05")
  @format("uuid")
  id: string;

  @doc("Project ID associated with the resource.")
  @example("bc949800-7b40-43cf-8438-a85facfcbdd1")
  @format("uuid")
  project_id: string;

  @doc("Display name of the SIP Gateway.")
  @example("My SIP Gateway")
  display_name: string;

  @doc("Type of the resource.")
  @example(FabricResponseType.SipGateway)
  type: FabricResponseType.SipGateway;

  @doc("Timestamp when the resource was created.")
  @example(UTC_TIME_EXAMPLE)
  created_at: utcDateTime;

  @doc("Timestamp when the resource was last updated.")
  @example(UTC_TIME_EXAMPLE)
  updated_at: utcDateTime;

  @doc("SIP Gateway configuration details.")
  sip_gateway: SipGateway;
}

model SipGateway {
  @doc("Unique ID of the SIP Gateway.")
  @example("cce59cad-104d-4c28-ada4-98cfd102ae09")
  @format("uuid")
  id: string;

  @doc("The URI for the SIP Gateway.")
  @example("user3@domain.com")
  uri: string;

  @doc("Display name of the SIP Gateway.")
  @example("My SIP Gateway")
  name: string;

  @doc("List of supported SIP ciphers.")
  @example(#[Ciphers.AEAD_AES_256_GCM_8])
  ciphers: Ciphers[];

  @doc("List of supported codecs.")
  @example(#[Codecs.OPUS])
  codecs: Codecs[];

  @doc("Specifies the encryption requirement.")
  @example(Encryption.Required)
  encryption: Encryption;
}

model SipGatewayListResponse {
  @doc("An array of objects that contain a list of SIP Gateway data")
  data: SipGatewayResponse[];

  @doc("Pagination links for the response.")
  links: SipGatewayPaginationResponse;
}

model SipGatewayPaginationResponse {
  @doc("Link to the current page of results")
  @example("https://example.signalwire.com/api/fabric/resources/sip_gateways?page_number=0&page_size=50")
  self: url;

  @doc("Link to the first page of results")
  @example("https://example.signalwire.com/api/fabric/resources/sip_gateways?page_number=0&page_size=50")
  first: url;

  @doc("Link to the next page of results")
  @example("https://example.signalwire.com/api/fabric/resources/sip_gateways?page_number=1&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca")
  next?: url;

  @doc("Link to the previous page of results")
  @example("https://example.signalwire.com/api/fabric/resources/sip_gateways?page_number=0&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca")
  prev?: url;
}
