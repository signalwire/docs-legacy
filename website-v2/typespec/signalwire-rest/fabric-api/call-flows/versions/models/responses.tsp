import "../../../../types";
import "../../../_shared/const.tsp";

model CallFlowVersion {
  @doc("The unique identifier of the version.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  id: uuid;

  @doc("The version number.")
  @example("1.0.0")
  version: string;

  @doc("The creation timestamp.")
  @example("2023-01-01T12:00:00Z")
  created_at: string;

  @doc("The last update timestamp.")
  @example("2023-01-01T12:00:00Z")
  updated_at: string;

  @doc("Call Flow data structure")
  @example("{}")
  flow_data?: string;

  @doc("SWML document for this version")
  @example("{}")
  relayml?: string;
}

model CallFlowVersionListResponse {
  @doc("List of Call Flow Versions")
  data: CallFlowVersion[];

  links: CallFlowVersionsPaginationResponse;
}

model CallFlowVersionDeployResponse {
  @doc("The unique identifier of the deployed Call Flow Version.")
  @example("993ed018-9e79-4e50-b97b-984bd5534095")
  @format("uuid")
  id: uuid;

  @doc("The creation timestamp.")
  @example("2024-01-02T00:00:00Z")
  created_at: string;

  @doc("The last update timestamp.")
  @example("2024-01-02T00:00:00Z")
  updated_at: string;

  @doc("The document version.")
  @example(2)
  document_version: int32;

  @doc("Call Flow data structure")
  @example("{}")
  flow_data?: string;

  @doc("SWML document for this version")
  @example(SWML_EXAMPLE)
  relayml?: string;
}

model CallFlowVersionsPaginationResponse {
  @doc("Link of the current page")
  @example("https://example.signalwire.com/api/fabric/call_flows/versions?page_number=0&page_size=50&type=call_flow")
  self: url;

  @doc("Link to the first page")
  @example("https://example.signalwire.com/api/fabric/call_flows/versions?page_number=0&page_size=50&type=call_flow")
  first: url;

  @doc("Link to the next page")
  @example("https://example.signalwire.com/api/fabric/call_flows/versions?page_number=1&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=call_flow")
  next: url;

  @doc("Link to the previous page")
  @example("https://example.signalwire.com/api/fabric/call_flows/versions?page_number=0&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=call_flow")
  prev?: url;
}
