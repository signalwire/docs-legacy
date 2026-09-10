import "../../../types";

using TypeSpec.Http;

model SipGatewayID {
  @doc("Unique ID of a SIP Gateway.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}
