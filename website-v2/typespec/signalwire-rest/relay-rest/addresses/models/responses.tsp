import "./core.tsp";

using TypeSpec.Http;

@doc("Query parameters for listing addresses.")
model ListAddressesQuery {
  @doc("Filter addresses by label (partial match).")
  @query
  filter_label?: string;

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

@doc("Pagination links for list responses.")
model PaginationLinks {
  @doc("Link to the current page.")
  self: string;

  @doc("Link to the first page.")
  first: string;

  @doc("Link to the next page. Only present when there are more results.")
  next?: string;

  @doc("Link to the previous page. Only present when not on the first page.")
  prev?: string;
}

@doc("Response containing a list of addresses.")
model AddressListResponse {
  @doc("Pagination links.")
  links: PaginationLinks;

  @doc("List of addresses.")
  data: Address[];
}

@doc("Response containing a single address.")
model AddressResponse {
  ...Address;
}
