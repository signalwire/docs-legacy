import "@typespec/json-schema";
import "./ai_languages.tsp";
import "./prompt";
import "./ai_pronounce.tsp";
import "./ai_params.tsp";
import "./swaig";
import "./ai_hints.tsp";
using TypeSpec.JsonSchema;

@summary("AI Object")
model AIObject {
  @doc("""
    A key-value object for storing data that persists throughout the AI session.
    Can be set initially in the SWML script or modified during the conversation using the set_global_data action.
    The global_data object is accessible everywhere in the AI session: prompts, AI parameters,
    and SWML returned from SWAIG functions. Access properties using template strings (e.g. \${global_data.property_name}).
    """)
  @example(#{ company_name: "Acme Corp", support_hours: "9am-5pm EST" })
  global_data?: {
    ...TypeSpec.Record<unknown>;
  };

  @doc("Hints help the AI agent understand certain words or phrases better. Words that can commonly be misinterpreted can be added to the hints to help the AI speak more accurately.")
  @example(#["pizza", "pepperoni"])
  hints?: (string | Hint)[];

  @doc("An array of JSON objects defining supported languages in the conversation.")
  languages?: Languages[];

  @doc("A JSON object containing parameters as key-value pairs.")
  params?: AIParams;

  @doc("The final set of instructions and configuration settings to send to the agent.")
  post_prompt?: AIPostPrompt;

  @doc("The URL to which to send status callbacks and reports. Authentication can also be set in the url in the format of `username:password@url`.")
  @example("username:password@https://example.com")
  post_prompt_url?: url;

  @doc("An array of JSON objects to clarify the AI's pronunciation of words or expressions.")
  pronounce?: Pronounce[];

  @doc("""
    Defines the AI agent's personality, goals, behaviors, and instructions for handling conversations.
    The prompt establishes how the agent should interact with callers, what information it should gather,
    and how it should respond to various scenarios. It is recommended to write prompts using markdown formatting.
    """)
  prompt: AIPrompt;

  @doc("An array of JSON objects to create user-defined functions/endpoints that can be executed during the dialogue.")
  SWAIG?: SWAIG;
}

@summary("ai Method")
model AI {
  @doc("""
    Creates an AI agent that conducts voice conversations using automatic speech recognition (ASR),
    large language models (LLMs), and text-to-speech (TTS) synthesis.
    The agent processes caller speech in real-time, generates contextually appropriate responses,
    and can execute custom functions to interact with external systems through SignalWire AI Gateway (SWAIG).
    """)
  @summary("ai")
  ai: AIObject;
}
