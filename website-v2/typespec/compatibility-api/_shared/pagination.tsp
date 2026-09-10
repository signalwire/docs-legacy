@doc("Pagination information for list responses.")
model Pagination {
  @doc("The URI of the current page.")
  @example("/api/laml/2010-04-01/Accounts?Page=0&PageSize=50")
  uri?: string;

  @doc("The URI of the first page.")
  @example("/api/laml/2010-04-01/Accounts?Page=0&PageSize=50")
  first_page_uri?: string;

  @doc("The URI of the next page.")
  @example("/api/laml/2010-04-01/Accounts?Page=1&PageSize=50")
  next_page_uri?: string;

  @doc("The URI of the previous page.")
  previous_page_uri?: string;

  @doc("The current page number.")
  @example(0)
  page?: int32;

  @doc("The number of items per page.")
  @example(50)
  page_size?: int32;
}

@doc("Pagination information with key property for list responses.")
model PaginationWithKey {
  ...Pagination;

  @doc("The name of the object")
  @example("faxes")
  key?: string;
}
