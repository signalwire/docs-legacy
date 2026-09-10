import "./core.tsp";
import "../../addresses/models/responses.tsp";

using TypeSpec.Http;

@doc("Query parameters for listing phone numbers.")
model ListPhoneNumbersQuery {
  @doc("The name given to the phone number. Will return all Phone Numbers containing this value as a substring.")
  @query
  filter_name?: string;

  @doc("The phone number in E164 format. Will return all Phone Numbers containing this value as a substring.")
  @query
  filter_number?: string;

  @doc("The page number to retrieve (0-indexed).")
  @query
  page_number?: int32 = 0;

  @doc("The number of items per page (1-1000).")
  @query
  @minValue(1)
  @maxValue(1000)
  page_size?: int32 = 50;

  @doc("Token for cursor-based pagination. Required when page_number > 0.")
  @query
  page_token?: string;
}

@doc("Response containing a list of phone numbers.")
model PhoneNumberListResponse {
  @doc("Pagination links.")
  links: PaginationLinks;

  @doc("List of phone numbers.")
  data: PhoneNumber[];
}

@doc("Response containing a single phone number.")
model PhoneNumberResponse {
  ...PhoneNumber;
}

@doc("Response containing available phone numbers for purchase.")
model AvailablePhoneNumbersResponse {
  @doc("Pagination links.")
  links?: PaginationLinks;

  @doc("List of available phone numbers.")
  data?: AvailablePhoneNumber[];
}

@doc("Response containing phone number lookup result.")
model PhoneNumberLookupResponse {
  ...PhoneNumberLookup;
}
