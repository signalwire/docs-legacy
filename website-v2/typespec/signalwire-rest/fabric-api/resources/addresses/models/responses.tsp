import "../../../_shared/fabric-address";
import "../../../../types";

model ResourceAddressListResponse {
  @doc("An array opf objects that contain a list of Resource Addresses")
  data: FabricAddress[];

  @doc("Object containing pagination links")
  links: ResourceAddressPaginationResponse;
}

model ResourceAddressPaginationResponse {
  @doc("Link to the current page of results")
  @example("https://example.signalwire.com/api/fabric/resources/016e5773-c197-4446-bcc2-9c48f14e2d0a/addresses?page_number=0&page_size=50")
  self: url;

  @doc("Link to the first page of results")
  @example("https://example.signalwire.com/api/fabric/resources/016e5773-c197-4446-bcc2-9c48f14e2d0a/addresses?page_number=0&page_size=50")
  first: url;

  @doc("Link to the next page of results")
  @example("https://example.signalwire.com/api/fabric/resources/016e5773-c197-4446-bcc2-9c48f14e2d0a/addresses?page_number=1&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca")
  next?: url;

  @doc("Link to the previous page of results")
  @example("https://example.signalwire.com/api/fabric/resources/016e5773-c197-4446-bcc2-9c48f14e2d0a/addresses?page_number=0&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca")
  prev?: url;
}
