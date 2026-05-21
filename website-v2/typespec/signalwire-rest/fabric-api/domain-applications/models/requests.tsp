model DomainApplicationAssignRequest {
  @doc("The id of the domain application you wish to assign a resource to.")
  @example("993ed018-9e79-4e50-b97b-984bd5534095")
  @format("uuid")
  domain_application_id: uuid;
}
