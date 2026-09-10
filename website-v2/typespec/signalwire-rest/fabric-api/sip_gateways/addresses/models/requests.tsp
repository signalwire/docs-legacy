import "@typespec/http";
import "@typespec/openapi3";

using TypeSpec.Http;

model SipGatewayAddressRequest {
  @doc("The unique identifier of the SIP Gateway.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  resource_id: uuid;
}
