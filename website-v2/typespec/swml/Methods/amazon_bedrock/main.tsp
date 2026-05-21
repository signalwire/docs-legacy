import "../ai";
import "./prompt.tsp";
import "./swaig";
import "./params.tsp";

@summary("Ommited properties from AI Type")
union AmazonBedrockOmitProps {}

model AmazonBedrockObject {
  @doc("""
    A powerful and flexible environmental variable which can accept arbitrary data that is set initially in the SWML script
    or from the SWML `set_global_data` action. This data can be referenced `globally`.
    All contained information can be accessed and expanded within the prompt - for example, by using a template string.
    """)
  @example(#{ company_name: "Acme Corp", support_hours: "9am-5pm EST" })
  global_data?: {
    ...TypeSpec.Record<unknown>;
  };

  @doc("A JSON object containing parameters as key-value pairs.")
  params?: BedrockParams;

  @doc("The final set of instructions and configuration settings to send to the agent.")
  post_prompt?: BedrockPostPrompt;

  @doc("The URL to which to send status callbacks and reports. Authentication can also be set in the url in the format of `username:password@url`.")
  @example("https://example.com/bedrock-callback")
  post_prompt_url?: url;

  @doc("Establishes the initial set of instructions and settings to configure the agent.")
  prompt: BedrockPrompt;

  @doc("An array of JSON objects to create user-defined functions/endpoints that can be executed during the dialogue.")
  SWAIG?: BedrockSWAIG;
}

@summary("amazon_bedrock Method")
model AmazonBedrock {
  @doc("Creates a new Bedrock AI Agent")
  amazon_bedrock: AmazonBedrockObject;
}
