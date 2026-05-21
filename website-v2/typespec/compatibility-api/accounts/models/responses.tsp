import "./core.tsp";
import "../../_shared/pagination.tsp";

using TypeSpec.Http;

@doc("Response containing a list of accounts.")
model AccountListResponse {
  @doc("The URI of the current page.")
  @example("/api/laml/2010-04-01/Accounts?Page=0&PageSize=50")
  uri: string;

  @doc("The URI of the first page.")
  @example("/api/laml/2010-04-01/Accounts?Page=0&PageSize=50")
  first_page_uri: string;

  @doc("The URI of the next page. Null if there are no more results.")
  @example("/api/laml/2010-04-01/Accounts?Page=1&PageSize=50")
  next_page_uri: string | null;

  @doc("The URI of the previous page. Null if this is the first page.")
  @example(null)
  previous_page_uri: string | null;

  @doc("The current page number (zero-indexed).")
  @example(0)
  page: int32;

  @doc("The number of results per page.")
  @example(50)
  page_size: int32;

  @doc("List of accounts.")
  accounts: Account[];
}

@doc("Response containing a single account.")
model AccountResponse {
  ...Account;
}

@doc("Response containing a newly created subproject account.")
model AccountCreatedResponse {
  @statusCode statusCode: 201;
  @body body: Account;
}
