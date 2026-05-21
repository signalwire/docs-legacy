import "../../addresses/models/core.tsp";
import "../../../_shared/fabric-address";
import "../../../../types";

using Types.StatusCodes;

model CallFlowAddressListResponse {
  @doc("An array of objects containing a list of Call Flow Addresses")
  data: FabricAddressApp[];

  @doc("Object containing pagination links")
  links: CallFlowAddressPaginationResponse;
}

model CallFlowAddressPaginationResponse {
  @doc("Link of the current page")
  @example("https://example.signalwire.com/api/fabric/resources/016e5773-c197-4446-bcc2-9c48f14e2d0a/addresses?page_number=0&page_size=50&type=call_flow")
  self: url;

  @doc("Link to the first page")
  @example("https://example.signalwire.com/api/fabric/resources/016e5773-c197-4446-bcc2-9c48f14e2d0a/addresses?page_number=0&page_size=50&type=call_flow")
  first: url;

  @doc("Link to the next page")
  @example("https://example.signalwire.com/api/fabric/resources/016e5773-c197-4446-bcc2-9c48f14e2d0a/addresses?page_number=1&page_size=50&page_token=PA6581c1fa-d985-4c8f-b53e-2fee11b579ad&type=call_flow")
  next?: url;

  @doc("Link to the previous page")
  @example("https://example.signalwire.com/api/fabric/resources/016e5773-c197-4446-bcc2-9c48f14e2d0a/addresses?page_number=0&page_size=50&page_token=PA6581c1fa-d985-4c8f-b53e-2fee11b579ad&type=call_flow")
  prev?: url;
}
