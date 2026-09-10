import "./core.tsp";
import "../../addresses/models/responses.tsp";

using TypeSpec.Http;

@doc("Query parameters for listing domain applications.")
model ListDomainApplicationsQuery {
  @doc("String representing the domain portion of the domain application. Will return all domain applications containing this value as a substring.")
  @query
  filter_domain?: string;

  @doc("String representing the name portion of the domain application. Will return all domain applications containing this value as a substring.")
  @query
  filter_name?: string;

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

@doc("Response containing a list of domain applications.")
model DomainApplicationListResponse {
  @doc("Pagination links.")
  links: PaginationLinks;

  @doc("List of domain applications.")
  data: DomainApplication[];
}

@doc("Response containing a single domain application.")
model DomainApplicationResponse {
  ...DomainApplication;
}
