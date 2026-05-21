import "./core.tsp";

model FabricAddressesResponse {
  @doc("An array of objects containing a list of Resource Addresses")
  data: FabricAddress[];

  @doc("Object containing pagination links")
  links: FabricAddressPaginationResponse;
}

model FabricAddressPaginationResponse {
  @doc("Link of the current page")
  @example("https://example.signalwire.com/api/fabric/addresses?page_number=0&page_size=50")
  self: url;

  @doc("Link to the first page")
  @example("https://example.signalwire.com/api/fabric/addresses?page_number=0&page_size=50")
  first: url;

  @doc("Link to the next page")
  @example("https://example.signalwire.com/api/fabric/addresses?page_number=1&page_number=1&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca")
  next?: url;

  @doc("Link to the previous page")
  @example("https://example.signalwire.com/api/fabric/addresses?page_number=0&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca")
  prev?: url;
}
