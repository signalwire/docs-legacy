import "./enums.tsp";
import "./ai/main.tsp";

import "../../../types";

// Import SWML AI types for reuse
import "../../../../swml/Methods/ai/main.tsp";

using TypeSpec.Http;

model AIAgentPathID {
  @doc("Unique ID of an AI Agent.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

@summary("AI Agent")
@doc("An AI Agent configuration that extends the SWML AI object with additional API-specific properties.")
model AIAgent is AIObject {
  @doc("Unique ID of an AI Agent.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  agent_id: uuid;

  @doc("Name of the AI Agent.")
  @example("My AI Agent")
  name: string;
}
