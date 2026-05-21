using TypeSpec.Http;

model TokensAccountSidPath {
  @doc("The unique identifier for the project you want to use to authenticate this request.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  @format("uuid")
  @path
  AccountSid: string;
}

model TokenIdPath {
  @doc("The unique identifier of the project API token.")
  @example("ea14556a-984f-11ee-b9d1-0242ac120002")
  @format("uuid")
  @path
  token_id: string;
}

@doc("API Token model.")
model Token {
  @doc("The unique identifier of the created API Token.")
  @format("uuid")
  @example("ea14556a-984f-11ee-b9d1-0242ac120002")
  id: string;

  @doc("The name of the created API Token.")
  @example("John Doe's Token")
  @minLength(1)
  name: string;

  @doc("The permissions enabled for this token.")
  @example(#["calling", "fax", "messaging"])
  permissions: string[];

  @doc("The API token that can be used along with the project ID for basic authentication.")
  @example("PT037258e533e87ac63174ee136ed0798dc85d4f4f9e6d7191")
  token: string;
}
