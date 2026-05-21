import "./core.tsp";
import "../../_shared/enums.tsp";
import "../../_shared/const.tsp";

model SwmlScriptResponse {
  @doc("Unique ID of the SWML Script.")
  @example("993ed018-9e79-4e50-b97b-984bd5534095")
  @format("uuid")
  id: uuid;

  @doc("Unique ID of the Project.")
  @example("1313fe58-5e14-4c11-bbe7-6fdfa11fe780")
  @format("uuid")
  project_id: uuid;

  @doc("Display name of the SWML Script Fabric Resource")
  @example("Welcome Script")
  display_name: string;

  @doc("Type of the Fabric Resource")
  @example(FabricResponseType.SwmlScript)
  type: FabricResponseType.SwmlScript;

  @doc("Date and time when the resource was created.")
  @example(UTC_TIME_EXAMPLE)
  created_at: utcDateTime;

  @doc("Date and time when the resource was updated.")
  @example(UTC_TIME_EXAMPLE)
  updated_at: utcDateTime;

  @doc("SWML Script data.")
  swml_script: SwmlScript;
}

model SwmlScriptListResponse {
  @doc("An array of objects that contain a list of SWML Script data")
  data: SwmlScriptResponse[];

  @doc("Object containing pagination links")
  links: SwmlScriptPaginationresponse;
}

model SwmlScriptPaginationresponse {
  @doc("Link to the current page")
  @example("https://example.signalwire.com/api/fabric/resources/swml_scripts?page_number=0&page_size=50&type=swml_script")
  self: url;

  @doc("Link to the first page")
  @example("https://example.signalwire.com/api/fabric/resources/swml_scripts?page_size=50&type=swml_script")
  first: url;

  @doc("Link to the next page")
  @example("https://example.signalwire.com/api/fabric/resources/swml_scripts?page_number=1&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=swml_script")
  next?: url;

  @doc("Link to the previous page")
  @example("https://example.signalwire.com/api/fabric/resources/swml_scripts?page_number=0&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=swml_script")
  prev?: url;
}
