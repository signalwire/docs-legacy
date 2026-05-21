import "./core.tsp";

using TypeSpec.Http;

@doc("Response containing a list of messages.")
model MessageListResponse {
  @doc("The URI of the current page.")
  @example("/api/laml/2010-04-01/Accounts/ea108133-d6b3-407c-9536-9fad8a929a6a/Messages?Page=0&PageSize=50")
  uri: string;

  @doc("The URI of the first page.")
  @example("/api/laml/2010-04-01/Accounts/ea108133-d6b3-407c-9536-9fad8a929a6a/Messages?Page=0&PageSize=50")
  first_page_uri: string;

  @doc("The URI of the next page, or null if there are no more pages.")
  @example("/api/laml/2010-04-01/Accounts/ea108133-d6b3-407c-9536-9fad8a929a6a/Messages?Page=1&PageSize=50&PageToken=PA0a059168ead041af")
  next_page_uri: string | null;

  @doc("The URI of the previous page, or null if this is the first page.")
  @example(null)
  previous_page_uri: string | null;

  @doc("The current page number.")
  @example(0)
  page: int32;

  @doc("The number of items per page.")
  @example(50)
  page_size: int32;

  @doc("List of messages.")
  messages: Message[];
}

@doc("Response containing a single message.")
model MessageResponse {
  ...Message;
}

@doc("Response returned when a message is created.")
model MessageCreatedResponse {
  @statusCode statusCode: 201;
  ...Message;
}

@doc("Response containing a list of message media.")
model MessageMediaListResponse {
  @doc("The URI of the current page.")
  @example("/api/laml/2010-04-01/Accounts/ea108133-d6b3-407c-9536-9fad8a929a6a/Messages/0a059168-ead0-41af-9d1f-343dae832527/Media?Page=0&PageSize=50")
  uri: string;

  @doc("The URI of the first page.")
  @example("/api/laml/2010-04-01/Accounts/ea108133-d6b3-407c-9536-9fad8a929a6a/Messages/0a059168-ead0-41af-9d1f-343dae832527/Media?Page=0&PageSize=50")
  first_page_uri: string;

  @doc("The URI of the next page, or null if there are no more pages.")
  @example(null)
  next_page_uri: string | null;

  @doc("The URI of the previous page, or null if this is the first page.")
  @example(null)
  previous_page_uri: string | null;

  @doc("The current page number.")
  @example(0)
  page: int32;

  @doc("The number of items per page.")
  @example(50)
  page_size: int32;

  @doc("List of media.")
  media_list: MessageMedia[];
}

@doc("Response containing a single message media.")
model MessageMediaResponse {
  ...MessageMedia;
}
