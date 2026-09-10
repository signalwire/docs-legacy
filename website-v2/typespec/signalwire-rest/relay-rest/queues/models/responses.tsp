import "./core.tsp";
import "../../addresses/models/responses.tsp";

using TypeSpec.Http;

@doc("Response containing a list of queues.")
model QueueListResponse {
  @doc("Pagination links.")
  links?: PaginationLinks;

  @doc("List of queues.")
  data?: Queue[];
}

@doc("Response containing a single queue.")
model QueueResponse {
  ...Queue;
}

@doc("Response containing a list of queue members.")
model QueueMemberListResponse {
  @doc("Pagination links.")
  links?: PaginationLinks;

  @doc("List of queue members.")
  data?: QueueMember[];
}

@doc("Response containing a single queue member.")
model QueueMemberResponse {
  ...QueueMember;
}
