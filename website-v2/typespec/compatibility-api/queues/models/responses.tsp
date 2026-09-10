import "./core.tsp";
import "../../_shared/pagination.tsp";

using TypeSpec.Http;

@doc("Response containing a list of queues.")
model QueueListResponse {
  @doc("The URI of the current page.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Queues?Page=0&PageSize=50")
  uri: string;

  @doc("The URI of the first page.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Queues")
  first_page_uri: string;

  @doc("The URI of the next page. Null if there are no more pages.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Queues?Page=1&PageSize=50&PageToken=PAb3877c40-da60-4998-90ad-b792e98472qu")
  next_page_uri: string | null;

  @doc("The URI of the previous page. Null if this is the first page.")
  @example(null)
  previous_page_uri: string | null;

  @doc("The current page number (zero-indexed).")
  @example(0)
  page: int32;

  @doc("The number of items per page.")
  @example(50)
  page_size: int32;

  @doc("List of queues.")
  queues: Queue[];
}

@doc("Response containing a single queue.")
model QueueResponse {
  ...Queue;
}

@doc("Response returned when a queue is successfully created.")
model QueueCreatedResponse {
  @statusCode statusCode: 201;
  ...Queue;
}

@doc("Response containing a list of queue members.")
model QueueMemberListResponse {
  @doc("The URI of the current page.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Queues/b3877c40-da60-4998-90ad-b792e98472qu/Members?Page=0&PageSize=50")
  uri: string;

  @doc("The URI of the first page.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Queues/b3877c40-da60-4998-90ad-b792e98472qu/Members")
  first_page_uri: string;

  @doc("The URI of the next page. Null if there are no more pages.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Queues/b3877c40-da60-4998-90ad-b792e98472qu/Members?Page=1&PageSize=50&PageToken=PAb3877c40-da60-4998-90ad-b792e98472me")
  next_page_uri: string | null;

  @doc("The URI of the previous page. Null if this is the first page.")
  @example(null)
  previous_page_uri: string | null;

  @doc("The current page number (zero-indexed).")
  @example(0)
  page: int32;

  @doc("The number of items per page.")
  @example(50)
  page_size: int32;

  @doc("List of queue members.")
  queue_members: QueueMember[];
}

@doc("Response containing a single queue member.")
model QueueMemberResponse {
  ...QueueMember;
}
