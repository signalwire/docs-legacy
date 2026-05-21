@doc("Valid permission types for API tokens.")
enum TokenPermission {
  calling,
  chat,
  datasphere,
  fax,
  management,
  messaging,
  numbers,
  pubsub,
  storage,
  tasking,
  video,
}

@summary("API Token Response")
model TokenResponse {
  @doc("The ID of the created API Token.")
  @example("ea14556a-984f-11ee-b9d1-0242ac120002")
  @format("uuid")
  id: string;

  @doc("The name of the created API Token.")
  @example("John Doe's Token")
  name: string;

  @doc("The permissions enabled for this token.")
  @example(#[
    TokenPermission.calling,
    TokenPermission.fax,
    TokenPermission.messaging
  ])
  permissions: TokenPermission[];

  @doc("The API token that can be used along with the project ID for basic authentication")
  @example("PT037258e533e87ac63174ee136ed0798dc85d4f4f9e6d7191")
  token: string;
}
