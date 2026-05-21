import "@typespec/openapi3";
import "./enums.tsp";
import "../../../../types";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

model CXMLWebhookIDPath {
  @doc("Unique ID of a CXML Webhook.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  cxml_webhook_id: uuid;
}
