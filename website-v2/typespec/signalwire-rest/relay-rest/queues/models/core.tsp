import "../../../types";

using TypeSpec.Http;
using Types;

model QueuePathID {
  @doc("Unique ID of the queue.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

model QueueIdPath {
  @doc("Unique ID of the queue.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  queue_id: uuid;
}

model QueueMemberPathID {
  @doc("The unique identifier (ID) of the queue member.")
  @example("596e2dea-a269-4765-a0b4-01b82d11c120")
  @format("uuid")
  @path
  id: uuid;
}

@doc("Queue model.")
model Queue {
  @doc("The unique identifier of the queue.")
  @example("aae131db-214c-46f5-88b6-92004f8467cf")
  @format("uuid")
  id: uuid;

  @doc("The project ID associated with this queue.")
  @example("c6c4679b-716a-456a-9e41-a03821005005")
  @format("uuid")
  project_id: uuid;

  @doc("The friendly name of the queue.")
  @example("test")
  friendly_name: string;

  @doc("The maximum number of callers allowed in the queue.")
  @example(5)
  max_size?: int32;

  @doc("The current number of callers in the queue.")
  @example(0)
  current_size?: int32;

  @doc("The average wait time in seconds.")
  @example(0)
  average_wait_time?: int32;

  @doc("The URL of this queue.")
  @example("/api/relay/rest/queues/aae131db-214c-46f5-88b6-92004f8467cf")
  uri?: string;

  @doc("Timestamp when the queue was created.")
  date_created?: utcDateTime;

  @doc("Timestamp when the queue was last updated.")
  date_updated?: utcDateTime;
}

@doc("Queue member model.")
model QueueMember {
  @doc("The call ID of the queue member.")
  @example("596e2dea-a269-4765-a0b4-01b82d11c120")
  @format("uuid")
  call_id: uuid;

  @doc("The ID of the project associated with this queue member.")
  @example("d421473b-d696-449a-a1a1-4ddd83d2d0e5")
  project_id: string;

  @doc("The ID of the queue associated with this queue member.")
  @example("596e2dea-a269-4765-a0b4-01b82d11c120")
  queue_id: string;

  @doc("Queue member position in the queue.")
  @example(2)
  position: int32;

  @doc("The URL of this queue member.")
  @example("/api/relay/rest/queues/596e2dea-a269-4765-a0b4-01b82d11c120/members/596e2dea-a269-4765-a0b4-01b82d11c120")
  uri: string;

  @doc("Wait time in seconds since the member was enqueued. If not yet enqueued, it will be null.")
  @example(172975)
  wait_time?: int32;

  @doc("When the queue member was last enqueued.")
  date_enqueued?: utcDateTime;
}
