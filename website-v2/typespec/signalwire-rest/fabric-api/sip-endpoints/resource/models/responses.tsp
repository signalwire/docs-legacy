import "./core.tsp";
import "../../../_shared/enums.tsp";

model ResourceSipEndpointResponse {
  @doc("The unique identifier of the SIP endpoint.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  id: uuid;

  @doc("The name for the SIP endpoint.")
  @example("sip_user")
  name: string;

  @doc("The Resource type")
  @example(DisplayTypes.Call)
  type: DisplayTypes.Call;

  @doc("The cover URL for the SIP endpoint.")
  @example("https://example.com/cover.jpg")
  cover_url: url | null;

  @doc("The preview URL for the SIP endpoint.")
  @example("https://example.com/preview.jpg")
  preview_url: url | null;

  @doc("An object containing the resource addresses with the specified comunication channels")
  channels: AddressChannel;
}
