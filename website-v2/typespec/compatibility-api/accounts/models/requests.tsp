using TypeSpec.Http;

@doc("Request body for creating a subproject.")
model CreateSubprojectRequest {
  @doc("The name of the Project, up to 250 characters long.")
  @maxLength(250)
  @example("My Project")
  FriendlyName: string;
}

@doc("Request body for updating an account.")
model UpdateAccountRequest {
  @doc("The new name for the Project.")
  @maxLength(250)
  @example("My Project")
  FriendlyName: string;
}
