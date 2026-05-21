import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "../_shared/errors.tsp";
import "../tags.tsp";
import "../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@route("/Accounts/{AccountSid}/Queues")
namespace CompatibilityAPI.Queues {
  @tag(QUEUES_TAG)
  @friendlyName("Queues")
  interface Queues {
    @operationId("list_queues")
    @summary("List All Queues")
    @doc("""
      Retrieve all queues associated with your account. Results are returned as a paginated list.
      
      ${tokenPermissions<"_Voice_">}
      """)
    list(
      ...QueuesAccountSidPath,

      @query
      @doc("The page number to retrieve (zero-indexed).")
      @minValue(0)
      @example(0)
      Page?: int32 = 0,

      @query
      @doc("The number of results per page. Default is 50, maximum is 1000.")
      @minValue(1)
      @maxValue(1000)
      @example(50)
      PageSize?: int32 = 50,

      @query
      @doc("Token for cursor-based pagination. Required when navigating to pages beyond the first.")
      @example("PAb3877c40-da60-4998-90ad-b792e98472qu")
      PageToken?: string,
    ):
      | QueueListResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422;

    @operationId("create_queue")
    @summary("Create a Queue")
    @doc("""
      Create a call queue. Queue names must be unique among active queues within an account and can only contain alphanumeric characters and underscores. Deleted queue names can be reused.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @post
    create(
      ...QueuesAccountSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: CreateQueueRequest,
    ):
      | QueueCreatedResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422;

    @operationId("retrieve_queue")
    @summary("Retrieve a Queue")
    @doc("""
      Retrieve a single queue by its unique identifier.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @route("/{Sid}")
    read(...QueuesAccountSidPath, ...QueueSidPath):
      | QueueResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404;

    @operationId("update_queue")
    @summary("Update a Queue")
    @doc("""
      Modify the properties of a call queue. Queue names must be unique among active queues within an account. Deleted queue names can be reused.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @post
    @route("/{Sid}")
    update(
      ...QueuesAccountSidPath,
      ...QueueSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: UpdateQueueRequest,
    ):
      | QueueResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422;

    @operationId("delete_queue")
    @summary("Delete a Queue")
    @doc("""
      Delete a call queue. Only empty queues can be deleted - attempting to delete a queue with members will return a 422 error.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @delete
    @route("/{Sid}")
    delete(...QueuesAccountSidPath, ...QueueSidPath):
      | CompatibilityStatusCode204
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422;
  }

  @tag(QUEUE_MEMBERS_TAG)
  @friendlyName("Queue Members")
  @route("/{QueueSid}/Members")
  interface QueueMembers {
    @operationId("list_all_queue_members")
    @summary("List All Queue Members")
    @doc("""
      Retrieve all members currently waiting in a queue. Results are returned as a paginated list ordered by enqueue time.
      
      ${tokenPermissions<"_Voice_">}
      """)
    list(
      ...QueuesAccountSidPath,
      ...QueueSidPathForMembers,

      @query
      @doc("The page number to retrieve (zero-indexed).")
      @minValue(0)
      @example(0)
      Page?: int32 = 0,

      @query
      @doc("The number of results per page. Default is 50, maximum is 1000.")
      @minValue(1)
      @maxValue(1000)
      @example(50)
      PageSize?: int32 = 50,

      @query
      @doc("Token for cursor-based pagination. Required when navigating to pages beyond the first.")
      @example("PAb3877c40-da60-4998-90ad-b792e98472me")
      PageToken?: string,
    ):
      | QueueMemberListResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422;

    @operationId("retrieve_queue_member")
    @summary("Retrieve a Queue Member")
    @doc("""
      Retrieve a single queue member by call SID. Use the special value `Front` to retrieve the member at the front of the queue.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @route("/{CallSid}")
    read(
      ...QueuesAccountSidPath,
      ...QueueSidPathForMembers,
      ...QueueMemberCallSidPath,
    ):
      | QueueMemberResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404;

    @operationId("update_queue_member")
    @summary("Update a Queue Member")
    @doc("""
      Dequeue a member from a queue and redirect them to a new URL. Use the special value `Front` for the CallSid to dequeue the member at the front of the queue.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @post
    @route("/{CallSid}")
    update(
      ...QueuesAccountSidPath,
      ...QueueSidPathForMembers,
      ...QueueMemberCallSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: UpdateQueueMemberRequest,
    ):
      | QueueMemberResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422
      | CompatibilityStatusCode503;
  }
}
