import "@typespec/http";
import "./core.tsp";

using TypeSpec.Http;

@doc("Query parameters for listing room sessions.")
model ListRoomSessionsRequest {
  @doc("Return Sessions started from this Room.")
  @example("fe4093d9-58c2-4931-b4b9-5679f82652c6")
  @query
  @format("uuid")
  room_id?: string;

  @doc("Return Sessions with a matching room name.")
  @example("my_example_room")
  @query
  room_name?: string;

  @doc("Return Sessions with a room name matching this pattern (substring match).")
  @example("example")
  @query
  room_name_matches?: string;

  @doc("Return Sessions currently in this state.")
  @example(RoomSessionStatus.completed)
  @query
  status?: RoomSessionStatus;

  @doc("Page number to return. Requires `page_token` for values greater than 0.")
  @example(0)
  @query
  @minValue(0)
  page_number?: int32 = 0;

  @doc("Specify the number of results to return on a single page. The default page size is `50` and the maximum is `1000`.")
  @example(50)
  @query
  @minValue(1)
  @maxValue(1000)
  page_size?: int32 = 50;

  @doc("Token for cursor-based pagination. Required when `page_number` is greater than 0.")
  @example("PAb3877c40da604998")
  @query
  page_token?: string;
}

@doc("Query parameters for listing room session recordings.")
model ListRoomSessionRecordingsRequest {
  @doc("Generated media links will be valid for this many seconds. Default is 900 (15 minutes).")
  @example(900)
  @query
  @minValueExclusive(0)
  media_ttl?: int32;

  @doc("Page number to return. Requires `page_token` for values greater than 0.")
  @example(0)
  @query
  @minValue(0)
  page_number?: int32 = 0;

  @doc("Specify the number of results to return on a single page. The default page size is `50` and the maximum is `1000`.")
  @example(50)
  @query
  @minValue(1)
  @maxValue(1000)
  page_size?: int32 = 50;

  @doc("Token for cursor-based pagination. Required when `page_number` is greater than 0.")
  @example("PAb3877c40da604998")
  @query
  page_token?: string;
}

@doc("Query parameters for listing room session members.")
model ListRoomSessionMembersRequest {
  @doc("Page number to return. Requires `page_token` for values greater than 0.")
  @example(0)
  @query
  @minValue(0)
  page_number?: int32 = 0;

  @doc("Specify the number of results to return on a single page. The default page size is `50` and the maximum is `1000`.")
  @example(50)
  @query
  @minValue(1)
  @maxValue(1000)
  page_size?: int32 = 50;

  @doc("Token for cursor-based pagination. Required when `page_number` is greater than 0.")
  @example("PAb3877c40da604998")
  @query
  page_token?: string;
}

@doc("Query parameters for listing room session events.")
model ListRoomSessionEventsRequest {
  @doc("Page number to return. Requires `page_token` for values greater than 0.")
  @example(0)
  @query
  @minValue(0)
  page_number?: int32 = 0;

  @doc("Specify the number of results to return on a single page. The default page size is `50` and the maximum is `1000`.")
  @example(50)
  @query
  @minValue(1)
  @maxValue(1000)
  page_size?: int32 = 50;

  @doc("Token for cursor-based pagination. Required when `page_number` is greater than 0.")
  @example("PAb3877c40da604998")
  @query
  page_token?: string;
}
