import "./core.tsp";

using TypeSpec.Http;

@doc("Response containing a list of faxes.")
model FaxListResponse {
  @doc("The URI of the current page.")
  @example("/fax/v1/Faxes?Page=0&PageSize=50")
  uri: string;

  @doc("The URI of the first page.")
  @example("/fax/v1/Faxes?PageSize=50")
  first_page_uri: string;

  @doc("The URI of the next page, or null if there are no more pages.")
  @example("/fax/v1/Faxes?Page=1&PageSize=50&PageToken=PAb3877c40da604998")
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

  @doc("List of faxes.")
  faxes: Fax[];
}

@doc("Response containing a single fax.")
model FaxResponse {
  ...Fax;
}

@doc("Response containing a list of fax media.")
model FaxMediaListResponse {
  @doc("The URI of the current page.")
  @example("/fax/v1/Faxes/b3877c40-da60-4998-90ad-b792e98472fx/Media?Page=0&PageSize=50")
  uri: string;

  @doc("The URI of the first page.")
  @example("/fax/v1/Faxes/b3877c40-da60-4998-90ad-b792e98472fx/Media?PageSize=50")
  first_page_uri: string;

  @doc("The URI of the next page, or null if there are no more pages.")
  @example(null)
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

  @doc("List of media.")
  media: FaxMedia[];

  @doc("List of fax media (alias for media).")
  fax_media: FaxMedia[];
}

@doc("Response containing a single fax media.")
model FaxMediaResponse {
  ...FaxMedia;
}
