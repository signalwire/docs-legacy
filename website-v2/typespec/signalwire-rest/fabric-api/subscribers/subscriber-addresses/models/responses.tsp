import "./core.tsp";
import "../../../_shared/fabric-address";

model SubscriberAddressesResponse {
  @doc("An array of objects that contain a list of Subscriber addresses")
  data: FabricAddressSubscriber[];

  @doc("Object containing pagination links")
  links: SubscriberAddressPaginationResponse;
}

model SubscriberAddressPaginationResponse {
  @doc("Link of the current page")
  @example("https://example.signalwire.com/api/fabric/resources/subscribers/016e5773-c197-4446-bcc2-9c48f14e2d0a/addresses?page_number=0&page_size=50")
  self: url;

  @doc("Link to the first page")
  @example("https://example.signalwire.com/api/fabric/resources/subscribers/016e5773-c197-4446-bcc2-9c48f14e2d0a/addresses?page_number=0&page_size=50")
  first: url;

  @doc("Link to the next page")
  @example("https://example.signalwire.com/api/fabric/resources/subscribers/016e5773-c197-4446-bcc2-9c48f14e2d0a/addresses?page_number=1&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca")
  next?: url;

  @doc("Link of the previous page")
  @example("https://example.signalwire.com/api/fabric/resources/subscribers/016e5773-c197-4446-bcc2-9c48f14e2d0a/addresses?page_number=0&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca")
  prev?: url;
}
