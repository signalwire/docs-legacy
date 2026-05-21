import "../../../_shared/fabric-address";

model SWMLWebhookAddressListResponse {
  @doc("An array of objects that contain a list of SWML Webhook Addresses")
  data: FabricAddressApp[];

  @doc("Object containing pagination links")
  links: SWMLWebhookAddressPaginationResponse;
}

model SWMLWebhookAddressPaginationResponse {
  @doc("Link of the current paghe")
  @example("https://example.signalwire.com/api/fabric/resources/swml_webhooks/a87db7ed-8ebe-42e4-829f-8ba5a4152f54/addresses?page_number=0&page_size=50&type=swml_webhook")
  self: url;

  @doc("Link to the first page")
  @example("https://example.signalwire.com/api/fabric/resources/swml_webhooks/a87db7ed-8ebe-42e4-829f-8ba5a4152f54/addresses?page_number=0&page_size=50&type=swml_webhook")
  first: url;

  @doc("Link to the next page")
  @example("https://example.signalwire.com/api/fabric/resources/swml_webhooks/a87db7ed-8ebe-42e4-829f-8ba5a4152f54/addresses?page_number=1&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=swml_webhook")
  next: url;

  @doc("Link to the previous page")
  @example("https://example.signalwire.com/api/fabric/resources/swml_webhooks/a87db7ed-8ebe-42e4-829f-8ba5a4152f54/addresses?page_number=0&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=swml_webhook")
  prev?: url;
}
