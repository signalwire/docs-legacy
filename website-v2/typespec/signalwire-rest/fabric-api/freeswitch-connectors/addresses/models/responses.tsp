import "../../../_shared/fabric-address";
import "../../../_shared/enums.tsp";
import "../../../../types";

model FreeswitchConnectorAddressListResponse {
  @doc("An array of objects containing a list of FreeSWITCH Connector Addresses")
  data: FabricAddressCall[];

  @doc("Object containing pagination links")
  links: FreeswitchConnectorAddressPaginationResponse;
}

model FreeswitchConnectorAddressPaginationResponse {
  @doc("Link to the current page")
  @example("https://example.signalwire.com/api/fabric/resources/freeswitch_connectors/a87db7ed-8ebe-42e4-829f-8ba5a4152f54/addresses?page_number=0&page_size=50&type=freeswitch_connector")
  self: url;

  @doc("Link to the first page")
  @example("https://example.signalwire.com/api/fabric/resources/freeswitch_connectors/a87db7ed-8ebe-42e4-829f-8ba5a4152f54/addresses?page_number=0&page_size=50&type=freeswitch_connector")
  first: url;

  @doc("Link to the next page")
  @example("https://example.signalwire.com/api/fabric/resources/freeswitch_connectors/a87db7ed-8ebe-42e4-829f-8ba5a4152f54/addresses?page_number=1&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=freeswitch_connector")
  next?: url;

  @doc("Link to the previous page")
  @example("https://example.signalwire.com/api/fabric/resources/freeswitch_connectors/a87db7ed-8ebe-42e4-829f-8ba5a4152f54/addresses?page_number=0&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=freeswitch_connector")
  prev?: url;
}
