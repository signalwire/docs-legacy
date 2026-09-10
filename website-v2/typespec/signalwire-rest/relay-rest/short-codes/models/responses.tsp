import "./core.tsp";
import "../../addresses/models/responses.tsp";

using TypeSpec.Http;

@doc("Query parameters for listing short codes.")
model ListShortCodesQuery {
  @query
  @doc("Filter by name. Returns all short codes containing this value as a substring.")
  filter_name?: string;

  @query
  @doc("Filter by number. Returns all short codes containing this value as a substring.")
  filter_number?: string;

  @query
  @doc("The page number to retrieve.")
  page_number?: int32 = 0;

  @query
  @doc("The number of results per page.")
  @minValue(1)
  @maxValue(1000)
  page_size?: int32 = 50;

  @query
  @doc("Token for cursor-based pagination.")
  page_token?: string;
}

@doc("Response containing a list of short codes.")
model ShortCodeListResponse {
  @doc("Pagination links.")
  links: PaginationLinks;

  @doc("List of short codes.")
  data: ShortCode[];
}

@doc("Response containing a single short code.")
model ShortCodeResponse {
  ...ShortCode;
}
