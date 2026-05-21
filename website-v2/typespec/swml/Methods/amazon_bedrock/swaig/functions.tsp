import "../../ai";

union PickedSWAIGFunctionProps {
  "function",
  "description",
  "parameters",
  "web_hook_url",
  "data_map",
  "active",
  "meta_data",
  "meta_data_token",
}

union BedrockSWAIGFunction {
  PickProperties<UserSWAIGFunction, PickedSWAIGFunctionProps>,
  PickProperties<StartUpHookSWAIGFunction, PickedSWAIGFunctionProps>,
  PickProperties<HangUpHookSWAIGFunction, PickedSWAIGFunctionProps>,
  PickProperties<SummarizeConversationSWAIGFunction, PickedSWAIGFunctionProps>,
}
