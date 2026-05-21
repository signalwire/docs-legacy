import "@typespec/openapi3";
import "../../../../types";
import "../../enums.tsp";
import "../../const.tsp";

using TypeSpec.Http;

model FabricAddressID {
  @doc("Unique ID of a FabricAddress.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

model FabricAddress {
  @doc("Unique ID of the Fabric Address.")
  @example("691af061-cd86-4893-a605-173f47afc4c2")
  @format("uuid")
  id: uuid;

  @doc("Name of the Fabric Address.")
  @example("justice-league")
  name: string;

  @doc("Display name of the Fabric Address.")
  @example("Justice League")
  display_name: string;

  @doc("Cover url of the Fabric Address.")
  @example("https://coverurl.com")
  cover_url: string;

  @doc("Preview url of the Fabric Address.")
  @example("https://previewurl.com")
  preview_url: string;

  @doc("Locks the Fabric Address. This is used to prevent the Fabric Address from accepting calls.")
  @example(true)
  locked: boolean;

  @doc("Channels of the Fabric Address.")
  channels: AddressChannel;

  @doc("Fabric Address Creation Date.")
  @example(UTC_TIME_EXAMPLE)
  created_at: utcDateTime;

  type: DisplayTypes;
}

@summary("Application Address")
model FabricAddressApp {
  ...OmitProperties<FabricAddress, "type">;

  @doc("The display type of a fabric address pointing to an application.")
  @example(DisplayTypes.App)
  type: DisplayTypes.App;
}

@summary("Room Address")
model FabricAddressRoom {
  ...OmitProperties<FabricAddress, "type">;

  @doc("The display type of a fabric address pointing to a Conference Room.")
  @example(DisplayTypes.Room)
  type: DisplayTypes.Room;
}

@summary("Call Address")
model FabricAddressCall {
  ...OmitProperties<FabricAddress, "type">;

  @doc("The display type of a fabric address pointing to call.")
  @example(DisplayTypes.Call)
  type: DisplayTypes.Call;
}

@summary("Subscriber Address")
model FabricAddressSubscriber {
  ...OmitProperties<FabricAddress, "type">;

  @doc("The display type of a fabric address pointing to a Subscriber.")
  @example(DisplayTypes.Subscriber)
  type: DisplayTypes.Subscriber;
}
