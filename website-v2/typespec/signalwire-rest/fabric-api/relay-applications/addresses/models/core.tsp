import "@typespec/http";

using TypeSpec.Http;

model RelayApplicationAddressPathID {
  @doc("The unique identifier of the Relay Application.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: string;
}
