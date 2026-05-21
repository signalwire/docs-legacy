import "../../../_shared/fabric-address/models/core.tsp";
import "../../../_shared/enums.tsp";
import "../../../../types";

model CXMLScriptAddressListResponse {
  @doc("An array of objects that contain a list of cXML Script Addresses")
  data: FabricAddressApp[];

  @doc("Object containing pagination links")
  links: CXMLScriptAddressPaginationResponse;
}

model CXMLScriptAddressPaginationResponse {
  @doc("Link of the current page")
  @example("https://example.signalwire.com/api/fabric/resources/cxml_scripts?page_number=0&page_size=50&type=cxml_script")
  self: url;

  @doc("Link to the first page")
  @example("https://example.signalwire.com/api/fabric/resources/cxml_scripts?page_size=50&type=cxml_script")
  first: url;

  @doc("Link to the next page")
  @example("https://example.signalwire.com/api/fabric/resources/cxml_scripts?page_number=1&page_size=50&page_token=PA08cdad0c-e7e6-4a75-8244-902524f38d55&type=cxml_script")
  next?: url;

  @doc("Link to the previous page")
  @example("https://example.signalwire.com/api/fabric/resources/cxml_scripts?page_number=0&page_size=50&page_token=PA08cdad0c-e7e6-4a75-8244-902524f38d55&type=cxml_script")
  prev?: url;
}
