import "../../ai";
import "./functions.tsp";

union PickedBedrockSWAIG {
  "defaults",
  "native_functions",
  "includes",
}

model BedrockSWAIG {
  @doc("""
    An array of JSON objects to define functions that can be executed during the interaction with the Bedrock AI. Default is not set.
    The fields of this object are the six following.
    """)
  functions?: BedrockSWAIGFunction[];

  ...PickProperties<SWAIG, PickedBedrockSWAIG>;
}
