import "@typespec/http";
import "./core.tsp";
import "../../_shared/models.tsp";

using TypeSpec.Http;

@doc("Conference token response object.")
model ConferenceTokenResponse {
  @statusCode statusCode: 200;
  @body body: ConferenceToken;
}

@doc("List conference tokens response.")
model ListConferenceTokensResponse {
  @doc("Pagination links.")
  links: PaginationLinks;

  @doc("List of conference tokens.")
  data: ConferenceToken[];
}
