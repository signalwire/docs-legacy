import "./core.tsp";

using TypeSpec.Http;

@doc("Request body for creating a queue.")
model CreateQueueRequest {
  @doc("The name of the queue.")
  @example("Name 2")
  name?: string;

  @doc("The maximum number of callers allowed in the queue.")
  @example(600)
  max_size?: int32;
}

@doc("Request body for updating a queue.")
model UpdateQueueRequest {
  @doc("The name of the queue.")
  @example("Name 2")
  name?: string;

  @doc("The maximum number of callers allowed in the queue.")
  @example(600)
  max_size?: int32;
}
