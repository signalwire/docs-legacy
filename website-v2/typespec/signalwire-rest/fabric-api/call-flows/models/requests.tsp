import "./core.tsp";

model CallFlowCreateRequest {
  @doc("The name of the Call Flow")
  @example("Booking Assistant")
  title: string;
}

model CallFlowUpdateRequest {
  @doc("The name of the Call Flow")
  @example("Booking Assistant")
  title?: string;

  @doc("The current revision of the call flow. Every update must increase this number.")
  @example(1)
  document_version?: int32;
}
