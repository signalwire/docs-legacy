import "./core.tsp";

@doc("Request body for creating a new API Token.")
model CreateTokenRequest {
  @doc("The name representing the API token.")
  @example("John Doe's Token")
  name: string;

  @doc("The permissions you would like to enable for this token. Valid permissions are calling, chat, datasphere, fax, management, messaging, numbers, pubsub, storage, tasking, and video")
  @example(#[
    TokenPermission.calling,
    TokenPermission.fax,
    TokenPermission.messaging
  ])
  @minItems(1)
  permissions: TokenPermission[];

  @doc("The unique identifier of the subproject you would like to create a token for. The subproject passed must be a child of the project used to authenticate the request.")
  @example("9a7fc048-984f-11ee-b9d1-0242ac120002")
  @format("uuid")
  subproject_id?: string;
}

@doc("Request body for updating an API Token.")
model UpdateTokenRequest {
  @doc("The name representing the API token.")
  @example("John Doe's Token")
  name?: string;

  @doc("The permissions you would like to enable for this token. Valid permissions are calling, chat, datasphere, fax, management, messaging, numbers, pubsub, storage, tasking, and video")
  @example(#[
    TokenPermission.calling,
    TokenPermission.fax,
    TokenPermission.messaging
  ])
  permissions?: TokenPermission[];
}
