import "./core.tsp";
import "../../addresses/models/responses.tsp";

using TypeSpec.Http;

@doc("Response containing a list of recordings.")
model RecordingListResponse {
  @doc("Pagination links.")
  links: PaginationLinks;

  @doc("List of recordings.")
  data: Recording[];
}

/** Response containing a single recording. */
alias RecordingResponse = Recording;
