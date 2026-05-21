import "./core.tsp";
import "../../_shared/fabric-address";
import "../../_shared/const.tsp";
import "../../_shared/enums.tsp";

model SubscriberResponse {
  @doc("Unique ID of the request.")
  @example("d369a402-7b43-4512-8735-9d5e1f387814")
  id: string;

  @doc("Unique ID of the project.")
  @example("d369a402-7b43-4512-8735-9d5e1f387814")
  project_id: string;

  @doc("Display name of the Subscriber.")
  @example("John Doe")
  display_name: string;

  @doc("Type of the resource.")
  @example(FabricResponseType.Subscriber)
  type: FabricResponseType.Subscriber;

  @doc("Date and time when the resource was created.")
  @example(UTC_TIME_EXAMPLE)
  created_at: utcDateTime;

  @doc("Date and time when the resource was updated.")
  @example(UTC_TIME_EXAMPLE)
  updated_at: utcDateTime;

  @doc("Subscriber data.")
  subscriber: Subscriber;
}

model SubscriberListResponse {
  @doc("An array of objects that contain a list of Subscriber data")
  data: SubscriberResponse[];

  @doc("Object containing pagination links")
  links: SubscriberPaginationResponse;
}

model SubscriberPaginationResponse {
  @doc("Link of the current page")
  @example("https://example.signalwire.com/api/fabric/resources/subscribers?page_number=0&page_size=50")
  self: url;

  @doc("Link to the first page")
  @example("https://example.signalwire.com/api/fabric/resources/subscribers?page_number=0&page_size=50")
  first: url;

  @doc("Link to the next page")
  @example("https://example.signalwire.com/api/fabric/resources/subscribers?page_number=1&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca")
  next?: url;

  @doc("Link to the previous page")
  @example("https://example.signalwire.com/api/fabric/resources/subscribers?page_number=0&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca")
  prev?: url;
}
