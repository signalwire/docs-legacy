import "@typespec/http";
import "./core.tsp";
import "../../_shared/models.tsp";

using TypeSpec.Http;

@doc("Stream response object.")
model StreamResponse {
  @statusCode statusCode: 200;
  @body body: Stream;
}

@doc("Stream created response.")
model StreamCreatedResponse {
  @statusCode statusCode: 201;
  @body body: Stream;
}

@doc("List streams response.")
model ListStreamsResponse {
  @doc("Pagination links.")
  links: PaginationLinks;

  @doc("List of streams.")
  data: Stream[];
}
