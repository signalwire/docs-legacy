import "../../../../types";
import "@typespec/http";

using TypeSpec.Http;

model SubscriberAddressID {
  @doc("Unique ID of a Subscriber Address.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}
