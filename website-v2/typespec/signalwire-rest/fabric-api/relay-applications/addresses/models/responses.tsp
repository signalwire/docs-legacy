import "../../../_shared/fabric-address";
import "../../../_shared/enums.tsp";
import "../../../../types";

model RelayApplicationAddressListResponse {
  @doc("An array of objects that contain a list of Relay Application Addresses")
  data: FabricAddressApp[];

  @doc("Object containing pagination links")
  links: RelayApplicationAddressPaginationResponse;
}

model RelayApplicationAddressPaginationResponse {
  @doc("Self link for the current page")
  @example("https://example.signalwire.com/api/fabric/resources/relay_applications/a87db7ed-8ebe-42e4-829f-8ba5a4152f54/addresses?page_number=0&page_size=50&type=relay_application")
  self: string;

  @doc("Link to the first page")
  @example("https://example.signalwire.com/api/fabric/resources/relay_applications/a87db7ed-8ebe-42e4-829f-8ba5a4152f54/addresses?page_number=0&page_size=50&type=relay_application")
  first: string;

  @doc("Link to the next page")
  @example("https://example.signalwire.com/api/fabric/resources/relay_applications/a87db7ed-8ebe-42e4-829f-8ba5a4152f54/addresses?page_number=1&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=relay_application")
  next?: string;

  @doc("Link to the previous page")
  @example("https://example.signalwire.com/api/fabric/resources/relay_applications/a87db7ed-8ebe-42e4-829f-8ba5a4152f54/addresses?page_number=0&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=relay_application")
  prev?: string;
}
