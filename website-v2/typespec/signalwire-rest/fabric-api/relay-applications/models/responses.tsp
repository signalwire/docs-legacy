import "./core.tsp";
import "../../_shared/enums.tsp";
import "../../_shared/const.tsp";

model RelayApplicationResponse {
  @doc("Unique ID of the Relay Application.")
  @example("993ed018-9e79-4e50-b97b-984bd5534095")
  @format("uuid")
  id: uuid;

  @doc("Unique ID of the Project.")
  @example("1313fe58-5e14-4c11-bbe7-6fdfa11fe780")
  @format("uuid")
  project_id: uuid;

  @doc("Display name of the Relay Application Fabric Resource")
  @example("Customer Service Bot")
  display_name: string;

  @doc("Type of the Fabric Resource")
  @example(FabricResponseType.RelayApplication)
  type: FabricResponseType.RelayApplication;

  @doc("Date and time when the resource was created.")
  @example(UTC_TIME_EXAMPLE)
  created_at: utcDateTime;

  @doc("Date and time when the resource was updated.")
  @example(UTC_TIME_EXAMPLE)
  updated_at: utcDateTime;

  @doc("Relay Application data.")
  relay_application: RelayApplication;
}

model RelayApplicationListResponse {
  @doc("An array of objects that contain a list of Relay Application data")
  data: RelayApplicationResponse[];

  @doc("Object containing pagination links")
  links: RelayApplicationAddressPaginationResponse;
}

model RelayApplicationPaginationResponse {
  @doc("Link of the current page")
  @example("https://example.signalwire.com/api/fabric/resources/relay_applications?page_number=0&page_size=50&type=relay_application")
  self: url;

  @doc("Link of the first page")
  @example("https://example.signalwire.com/api/fabric/resources/relay_applications?page_size=50&type=relay_application")
  first: url;

  @doc("Link to the next page")
  @example("https://example.signalwire.com/api/fabric/resources?page_number=1&page_size=50&page_token=PAc28a38e4-0ae7-49ab-9bf6-f41f1572e6e4&type=relay_application")
  next?: url;

  @doc("Link to the previous page")
  @example("https://example.signalwire.com/api/fabric/resources?page_number=0&page_size=50&page_token=PAc28a38e4-0ae7-49ab-9bf6-f41f1572e6e4&type=relay_application")
  prev?: url;
}
