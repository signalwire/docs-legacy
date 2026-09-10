import "./core.tsp";

using TypeSpec.Http;

@doc("Response containing a list of cXML scripts.")
model CxmlScriptListResponse {
  @doc("The URI of the current page.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/LamlBins?Page=0&PageSize=50")
  uri: string;

  @doc("The URI of the first page.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/LamlBins?Page=0&PageSize=50")
  first_page_uri: string;

  @doc("The URI of the next page, or null if there are no more pages.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/LamlBins?Page=1&PageSize=50&PageToken=PAb3877c40da604998")
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

  @doc("List of cXML scripts.")
  laml_bins: CxmlScript[];
}

@doc("Response containing a single cXML script.")
model CxmlScriptResponse {
  ...CxmlScript;
}

@doc("Response returned when a cXML script is created.")
model CxmlScriptCreatedResponse {
  @statusCode statusCode: 201;
  ...CxmlScript;
}
