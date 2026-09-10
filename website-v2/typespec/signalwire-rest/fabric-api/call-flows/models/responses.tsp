import "./core.tsp";
import "../../_shared/enums.tsp";
import "../../_shared/const.tsp";

model CallFlowResponse {
  @doc("Unique ID of the Call Flow.")
  @example("993ed018-9e79-4e50-b97b-984bd5534095")
  @format("uuid")
  id: uuid;

  @doc("Unique ID of the Project.")
  @example("1313fe58-5e14-4c11-bbe7-6fdfa11fe780")
  @format("uuid")
  project_id: uuid;

  @doc("Display name of the Call Flow Fabric Resource")
  @example("Booking Assistant")
  display_name: string;

  @doc("Type of the Fabric Resource")
  @example(FabricResponseType.CallFlow)
  type: FabricResponseType.CallFlow;

  @doc("Date and time when the resource was created.")
  @example(UTC_TIME_EXAMPLE)
  created_at: utcDateTime;

  @doc("Date and time when the resource was updated.")
  @example(UTC_TIME_EXAMPLE)
  updated_at: utcDateTime;

  @doc("Call Flow data.")
  call_flow: CallFlow;
}

model CallFlowListResponse {
  @doc("Object containing pagination links")
  links: CallFlowAddressPaginationResponse;

  @doc("An array of objects containing the CallFlow listing response")
  data: CallFlowResponse[];
}

model CallFlowVersionResponse {
  @doc("Version number of the Call Flow")
  @example(1)
  version: int32;

  @doc("Date and time when the version was created.")
  @example(UTC_TIME_EXAMPLE)
  created_at: utcDateTime;

  @doc("Call Flow data structure")
  @example("{}")
  flow_data?: string;

  @doc("SWML document for this version")
  @example(SWML_EXAMPLE)
  relayml?: string;
}

model CallFlowPaginationResponse {
  @doc("Link of the current page")
  @example("https://example.signalwire.com/api/fabric/resources/call_flows?page_number=0&page_size=50&type=call_flow")
  self: url;

  @doc("Link to the first page")
  @example("https://example.signalwire.com/api/fabric/resources/call_flows?page_size=50&type=call_flow")
  first: url;

  @doc("Link to the next page")
  @example("https://example.signalwire.com/api/fabric/resources/call_flows?page_number=1&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=call_flow")
  next?: url;

  @doc("Link to the previous page")
  @example("https://example.signalwire.com/api/fabric/resources/call_flows?page_number=0&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=call_flow")
  prev?: url;
}
