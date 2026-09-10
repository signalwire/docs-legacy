import "./core.tsp";
import "../../_shared/enums.tsp";
import "../../_shared/const.tsp";

model DialogflowAgentResponse {
  @doc("Unique ID of the Dialogflow Agent.")
  @example("993ed018-9e79-4e50-b97b-984bd5534095")
  @format("uuid")
  id: uuid;

  @doc("Unique ID of the Project.")
  @example("1313fe58-5e14-4c11-bbe7-6fdfa11fe780")
  @format("uuid")
  project_id: uuid;

  @doc("Display name of the Dialogflow Agent Fabric Resource")
  @example("Customer Service Agent")
  display_name: string;

  @doc("Type of the Fabric Resource")
  @example(FabricResponseType.DialogflowAgent)
  type: FabricResponseType.DialogflowAgent;

  @doc("Date and time when the resource was created.")
  @example(UTC_TIME_EXAMPLE)
  created_at: utcDateTime;

  @doc("Date and time when the resource was updated.")
  @example(UTC_TIME_EXAMPLE)
  updated_at: utcDateTime;

  @doc("Dialogflow Agent data.")
  dialogflow_agent: DialogflowAgent;
}

model DialogflowAgentListResponse {
  @doc("An array of objects that contain a list of Dialogflow Agent data")
  data: DialogflowAgentResponse[];

  @doc("Object containing pagination links")
  links: DialogFlowPaginationResponse;
}

model DialogFlowPaginationResponse {
  @doc("Link to the current page")
  @example("https://devspace.signalwire.com/api/fabric/resources/dialogflow_agents?page_number=0&page_size=50&type=dialogflow_agent")
  self: url;

  @doc("Link to the first page")
  @example("https://devspace.signalwire.com/api/fabric/resources/dialogflow_agents?page_size=50&type=dialogflow_agent")
  first: url;

  @doc("Link to the next page")
  @example("https://devspace.signalwire.com/api/fabric/resources/dialogflow_agents?page_number=1&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=dialogflow_agent")
  next?: url;

  @doc("Link to the previous page")
  @example("https://devspace.signalwire.com/api/fabric/resources/dialogflow_agents?page_number=0&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=dialogflow_agent")
  prev?: url;
}
