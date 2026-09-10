import "./core.tsp";
import "../../addresses/models/responses.tsp";

using TypeSpec.Http;

@doc("Query parameters for listing number groups.")
model ListNumberGroupsQuery {
  @query
  @doc("Filter by name. Returns all number groups containing this value as a substring.")
  @maxLength(255)
  filter_name?: string;

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

@doc("Query parameters for listing number group memberships.")
model ListNumberGroupMembershipsQuery {
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

@doc("Response containing a list of number groups.")
model NumberGroupListResponse {
  @doc("Pagination links.")
  links: PaginationLinks;

  @doc("List of number groups.")
  data: NumberGroup[];
}

@doc("Response containing a single number group.")
model NumberGroupResponse {
  ...NumberGroup;
}

@doc("Response containing a list of number group memberships.")
model NumberGroupMembershipListResponse {
  @doc("Pagination links.")
  links: PaginationLinks;

  @doc("List of number group memberships.")
  data: NumberGroupMembership[];
}

@doc("Response containing a single number group membership.")
model NumberGroupMembershipResponse {
  ...NumberGroupMembership;
}
