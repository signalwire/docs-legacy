import "@typespec/openapi3";
import "./enums.tsp";
import "../../../../types";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

model AIAgentIDPath {
  @doc("Unique ID of a AI Agent.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  ai_agent_id: uuid;
}
