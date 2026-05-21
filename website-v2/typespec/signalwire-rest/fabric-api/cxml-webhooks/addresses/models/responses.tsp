import "../../../_shared/fabric-address";

model CXMLWebhookAddressListResponse {
  data: FabricAddressApp[];
  links: CXMLWebhookAddressPaginationResponse;
}

model CXMLWebhookAddressPaginationResponse {
  @doc("Link of the current page")
  @example("https://example.signalwire.com/api/fabric/resources/cxml_webhooks/a87db7ed-8ebe-42e4-829f-8ba5a4152f54/addresses?page_number=0&page_size=50&type=cxml_webhook")
  self: url;

  @doc("Link to the first page")
  @example("https://example.signalwire.com/api/fabric/resources/cxml_webhooks/a87db7ed-8ebe-42e4-829f-8ba5a4152f54/addresses?page_number=0&page_size=50&type=cxml_webhook")
  first: url;

  @doc("Link to the next page")
  @example("https://example.signalwire.com/api/fabric/resources/cxml_webhooks/a87db7ed-8ebe-42e4-829f-8ba5a4152f54/addresses?page_number=1&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=cxml_webhook")
  next: url;

  @doc("Link to the previous page")
  @example("https://example.signalwire.com/api/fabric/resources/cxml_webhooks/a87db7ed-8ebe-42e4-829f-8ba5a4152f54/addresses?page_number=0&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=cxml_webhook")
  prev?: url;
}
