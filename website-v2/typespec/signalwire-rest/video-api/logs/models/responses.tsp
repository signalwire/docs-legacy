import "@typespec/http";
import "./core.tsp";
import "../../_shared/models.tsp";

using TypeSpec.Http;

@doc("List logs response.")
model ListLogsResponse {
  @doc("Pagination links.")
  links: PaginationLinks;

  @doc("List of logs.")
  data: VideoLog[];
}

@doc("Response model for video log retrieve endpoint.")
model LogResponse {
  @statusCode statusCode: 200;
  @body body: VideoLog;
}
