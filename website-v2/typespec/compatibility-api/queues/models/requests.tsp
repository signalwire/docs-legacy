using TypeSpec.Http;

@doc("Request body for creating a queue.")
model CreateQueueRequest {
  @doc("A unique name for the queue. Must contain only alphanumeric characters and underscores.")
  @example("Queue1")
  @minLength(1)
  @pattern("^\\w+$")
  FriendlyName: string;

  @doc("The maximum number of calls that are allowed to wait in a queue. Must be a positive integer.")
  @example(100)
  @minValueExclusive(0)
  MaxSize?: int32;
}

@doc("Request body for updating a queue.")
model UpdateQueueRequest {
  @doc("A unique name for the queue. Must contain only alphanumeric characters and underscores.")
  @example("Queue1")
  @minLength(1)
  @pattern("^\\w+$")
  FriendlyName: string;

  @doc("The maximum number of calls that are allowed to wait in a queue. Must be a positive integer.")
  @example(100)
  @minValueExclusive(0)
  MaxSize?: int32;
}

@doc("Request body for dequeuing a queue member.")
model UpdateQueueMemberRequest {
  @doc("The URL to redirect the dequeued member to. This URL should return cXML instructions for handling the call.")
  @example("https://your-application.com/dequeue-handler")
  @format("uri")
  Url: string;

  @doc("The HTTP method to use when requesting the URL. Default is `POST`.")
  @example("POST")
  Method?: "GET" | "POST" = "POST";
}
