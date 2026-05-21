import "./core.tsp";
import "../../addresses/models/responses.tsp";

using TypeSpec.Http;

@doc("Query parameters for listing SIP endpoints.")
model ListSipEndpointsQuery {
  @doc("Filter SIP endpoints by username (partial match).")
  @query
  filter_username?: string;

  @doc("Filter SIP endpoints by caller ID (partial match).")
  @query
  filter_caller_id?: string;

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

@doc("Response containing a list of SIP endpoints.")
model SipEndpointListResponse {
  @doc("Pagination links.")
  links: PaginationLinks;

  @doc("List of SIP endpoints.")
  data: SipEndpoint[];
}

@doc("Response containing a single SIP endpoint.")
model SipEndpointResponse {
  ...SipEndpoint;
}
