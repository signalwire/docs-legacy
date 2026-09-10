import "./core.tsp";
import "../../addresses/models/responses.tsp";

using TypeSpec.Http;

@doc("Response containing a list of verified caller IDs.")
model VerifiedCallerIDListResponse {
  @doc("Pagination links.")
  links?: PaginationLinks;

  @doc("List of verified caller IDs.")
  data?: VerifiedCallerID[];
}

@doc("Response containing a single verified caller ID.")
model VerifiedCallerIDResponse {
  ...VerifiedCallerID;
}
