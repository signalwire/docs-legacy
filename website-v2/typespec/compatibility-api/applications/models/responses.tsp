import "./core.tsp";

using TypeSpec.Http;

@doc("Response containing a list of applications.")
model ApplicationListResponse {
  @doc("The URI for this resource.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Applications?Page=0&PageSize=50")
  uri: string;

  @doc("The URI for the first page of results.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Applications?Page=0&PageSize=50")
  first_page_uri: string;

  @doc("The URI for the next page of results. Null if there are no more pages.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Applications?Page=1&PageSize=50")
  next_page_uri: string | null;

  @doc("The URI for the previous page of results. Null if this is the first page.")
  @example(null)
  previous_page_uri: string | null;

  @doc("The current page number. Zero-indexed.")
  @example(0)
  page: int32;

  @doc("The number of results per page.")
  @example(50)
  page_size: int32;

  @doc("List of applications.")
  applications: Application[];
}

@doc("Response containing a single application.")
model ApplicationResponse {
  ...Application;
}

@doc("Response containing a newly created application.")
model ApplicationCreatedResponse {
  @statusCode statusCode: 201;
  @body body: Application;
}
