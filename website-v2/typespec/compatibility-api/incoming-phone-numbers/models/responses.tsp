import "./core.tsp";

using TypeSpec.Http;

@doc("Response containing a list of incoming phone numbers.")
model IncomingPhoneNumberListResponse {
  @doc("The URI of the current page.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/IncomingPhoneNumbers?Page=0&PageSize=50")
  uri: string;

  @doc("The URI of the first page.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/IncomingPhoneNumbers?Page=0&PageSize=50")
  first_page_uri: string;

  @doc("The URI of the next page, or null if there are no more pages.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/IncomingPhoneNumbers?Page=1&PageSize=50&PageToken=PAb3877c40da604998")
  next_page_uri: string | null;

  @doc("The URI of the previous page, or null if this is the first page.")
  @example(null)
  previous_page_uri: string | null;

  @doc("The current page number.")
  @example(0)
  page: int32;

  @doc("The number of items per page.")
  @example(50)
  page_size: int32;

  @doc("List of incoming phone numbers.")
  incoming_phone_numbers: IncomingPhoneNumber[];
}

@doc("Response containing a single incoming phone number.")
model IncomingPhoneNumberResponse {
  ...IncomingPhoneNumber;
}

@doc("Response returned when an incoming phone number is created.")
model IncomingPhoneNumberCreatedResponse {
  @statusCode statusCode: 201;
  ...IncomingPhoneNumber;
}
