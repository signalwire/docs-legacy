import "./core.tsp";
import "../../_shared/enums.tsp";
import "../../_shared/const.tsp";

model CxmlApplicationResponse {
  @doc("Unique ID of the cXML Application.")
  @example("993ed018-9e79-4e50-b97b-984bd5534095")
  @format("uuid")
  id: uuid;

  @doc("Unique ID of the Project.")
  @example("1313fe58-5e14-4c11-bbe7-6fdfa11fe780")
  @format("uuid")
  project_id: uuid;

  @doc("Display name of the cXML Application Fabric Resource")
  @example("Reception App")
  display_name: string;

  @doc("Type of the Fabric Resource")
  @example(FabricResponseType.CxmlApplication)
  type: FabricResponseType.CxmlApplication;

  @doc("Date and time when the resource was created.")
  @example(UTC_TIME_EXAMPLE)
  created_at: utcDateTime;

  @doc("Date and time when the resource was updated.")
  @example(UTC_TIME_EXAMPLE)
  updated_at: utcDateTime;

  @doc("cXML Application data.")
  cxml_application: CxmlApplication;
}

model CxmlApplicationListResponse {
  @doc("An array of objects containing the list of cXML Application(s) data.")
  data: CxmlApplicationResponse[];

  @doc("Object containing pagination links")
  links: CxmlApplicationPaginationResponse;
}

model CxmlApplicationPaginationResponse {
  @doc("Linmk to the current page")
  @example("https://example.signalwire.com/api/fabric/resources/cxml_applications?page_number=0&page_size=50&type=cxml_application")
  self: url;

  @doc("Link to the first page")
  @example("https://example.signalwire.com/api/fabric/resources/cxml_applications?page_size=50&type=cxml_application")
  first: url;

  @doc("Link to the next page")
  @example("https://example.signalwire.com/api/fabric/resources/cxml_applications?page_number=1&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=cxml_application")
  next?: url;

  @doc("Link to the previous page")
  @example("https://example.signalwire.com/api/fabric/resources/cxml_applications?page_number=0&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca&type=cxml_application")
  prev?: url;
}
