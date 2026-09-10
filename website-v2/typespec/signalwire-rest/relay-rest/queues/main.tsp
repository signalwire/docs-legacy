import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "../../types";
import "../tags.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/queues")
namespace RelayRestAPI.Queues {
  @tag(QUEUES_TAG)
  @friendlyName("Queues")
  interface Queues {
    @operationId("list_queues")
    @summary("List all Queues")
    @doc("""
      Returns a list of your queues.
      
      ${tokenPermissions<"_Voice_">}
      """)
    list(): QueueListResponse | StatusCode401 | ValidationError | StatusCode500;

    @operationId("create_queue")
    @summary("Create a Queue")
    @doc("""
      Creates a new queue.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @post
    create(@body body: CreateQueueRequest):
      | {
          @statusCode statusCode: 201;
          @body queue: QueueResponse;
        }
      | StatusCode401
      | ValidationError
      | StatusCode500;

    @operationId("get_queue")
    @summary("Retrieve a Queue")
    @doc("""
      Retrieves the details of a queue.
      
      ${tokenPermissions<"_Voice_">}
      """)
    read(...QueuePathID):
      | QueueResponse
      | StatusCode401
      | StatusCode404
      | ValidationError
      | StatusCode500;

    @operationId("update_queue")
    @summary("Update a Queue")
    @doc("""
      Updates a queue.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @put
    update(...QueuePathID, @body body: UpdateQueueRequest):
      | {
          @statusCode statusCode: 200;
          @body queue: QueueResponse;
        }
      | StatusCode400
      | StatusCode401
      | ValidationError
      | StatusCode500;

    @operationId("delete_queue")
    @summary("Delete a Queue")
    @doc("""
      Deletes a queue.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @delete
    delete(...QueuePathID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }

  @tag(QUEUE_MEMBERS_TAG)
  @friendlyName("Queue Members")
  @route("/{queue_id}/members")
  interface QueueMembers {
    @operationId("list_queue_members")
    @summary("List all members of a queue")
    @doc("""
      Returns a list of members in a queue.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @get
    listMembers(...QueueIdPath):
      | QueueMemberListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("retrieve_next_queue_member")
    @summary("Retrieve next member on the queue")
    @doc("""
      Retrieves the next member in the queue without dequeuing.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @route("/next")
    @get
    getNextMember(...QueueIdPath):
      | QueueMemberResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("retrieve_queue_member")
    @summary("Retrieve a queue member")
    @doc("""
      Retrieves the details of a queue member.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @route("/{id}")
    @get
    getMember(...QueueIdPath, ...QueueMemberPathID):
      | QueueMemberResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
