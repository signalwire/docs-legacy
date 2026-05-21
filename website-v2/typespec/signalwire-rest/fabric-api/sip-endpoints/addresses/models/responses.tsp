import "../../../_shared/fabric-address";
import "../../../_shared/enums.tsp";
import "../../../../types";

model SipEndpointAddressListResponse {
  @doc("An array of objects that contain a list of SIP Endpoint Addresses")
  data: FabricAddressCall[];

  @doc("Object containing pagination links")
  links: SipEndpointAddressPaginationResponse;
}

model SipEndpointAddressPaginationResponse {
  @doc("Link of the current page")
  @example("https://example.signalwire.com/api/fabric/resources/sip_endpoints/7ecfd15a-fb9a-45a4-9b89-c0740a44c593/addresses?page_number=0&page_size=50&type=sip_endpoint")
  self: url;

  @doc("Link to the first page")
  @example("https://example.signalwire.com/api/fabric/resources/sip_endpoints/7ecfd15a-fb9a-45a4-9b89-c0740a44c593/addresses?page_size=50&type=sip_endpoint")
  first: url;

  @doc("Link to the next page")
  @example("https://example.signalwire.com/api/fabric/resources/sip_endpoints/7ecfd15a-fb9a-45a4-9b89-c0740a44c593/addresses?page_number=1&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=sip_endpoint")
  next?: url;

  @doc("Link to the previous page")
  @example("https://example.signalwire.com/api/fabric/resources/sip_endpoints/7ecfd15a-fb9a-45a4-9b89-c0740a44c593/addresses?page_number=0&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=sip_endpoint")
  prev?: url;
}
