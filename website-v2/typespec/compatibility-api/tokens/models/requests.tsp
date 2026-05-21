using TypeSpec.Http;

@doc("Request body for creating an API token.")
model CreateTokenRequest {
  @doc("The name representing the project API token.")
  @example("John Doe's Token")
  @minLength(1)
  name: string;

  @doc("The permissions you would like to enable for this project API token. Valid permissions are: calling, chat, datasphere, fax, management, messaging, numbers, pubsub, storage, tasking, and video.")
  @example(#["calling", "fax", "messaging"])
  @minItems(1)
  permissions: string[];

  @doc("The unique identifier of the subproject you would like to create a token for. Must belong to the parent project.")
  @format("uuid")
  @example("9a7fc048-984f-11ee-b9d1-0242ac120002")
  subproject_id?: string;
}

@doc("Request body for updating an API token.")
model UpdateTokenRequest {
  @doc("The name representing the project API token.")
  @example("John Doe's Token")
  @minLength(1)
  name: string;

  @doc("The permissions you would like to enable for this project API token. If not provided, existing permissions are kept. Valid permissions are: calling, chat, datasphere, fax, management, messaging, numbers, pubsub, storage, tasking, and video.")
  @example(#["calling", "fax", "messaging"])
  permissions?: string[];
}
