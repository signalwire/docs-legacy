@summary("Create resource SIP endpoint")
model ResourceSipEndpointAssignRequest {
  @doc("The unique identifier of the SIP endpoint.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  sip_endpoint_id: uuid;
}
