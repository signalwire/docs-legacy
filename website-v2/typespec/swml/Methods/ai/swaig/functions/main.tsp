import "@typespec/json-schema";
import "./data_map";
import "../../../../Shared/Types";
import "./parameters.tsp";
import "../../_shared/fillers.tsp";

using TypeSpec.JsonSchema;

const functionDescription: string = "A unique name for the function. This can be any user-defined string or can reference a reserved function. Reserved functions are SignalWire functions that will be executed at certain points in the conversation.";

@summary("functions")
model SWAIGFunctionBase {
  @doc("A description of the context and purpose of the function, to explain to the agent when to use it.")
  @example("Get the weather information")
  description: string;

  #deprecated "The purpose field has been deprecated and is replaced by the `description` field."
  @doc("""
    The purpose field has been deprecated and is replaced by the `description` field.
    A description of the context and purpose of the function, to explain to the agent when to use it.
    """)
  @example("Get the weather information")
  purpose?: string;

  @doc("A JSON object that defines the expected user input parameters and their validation rules for the function.")
  parameters?: FunctionParameters;

  @doc("A JSON object defining the fillers that should be played when calling a `swaig function`. This helps the AI break silence between responses. The filler is played asynchronously during the function call.")
  fillers?: FunctionFillers;

  #deprecated "The argument field has been deprecated and is replaced by the `parameters` field."
  @doc("""
    The argument field has been deprecated and is replaced by the `parameters` field. 
    A JSON object defining the input that should be passed to the function. 
    The fields of this object are the following two parameters.
    """)
  argument?: FunctionParameters;

  @doc("Whether the function is active. **Default:** `true`.")
  @example(true)
  active?: boolean | SWMLVar = true;

  @doc("""
    A powerful and flexible environmental variable which can accept arbitrary data that is set initially in the SWML script or from the SWML set_meta_data action.
    This data can be referenced locally to the function.
    All contained information can be accessed and expanded within the prompt - for example, by using a template string.
    Default is not set.
    """)
  @example(#{ api_key: "key_123", endpoint: "https://api.example.com" })
  meta_data?: {
    ...TypeSpec.Record<unknown>;
  };

  @doc("Scoping token for meta_data. If not supplied, metadata will be scoped to function's `web_hook_url`. Default is set by SignalWire.")
  @example("my-function-scope")
  meta_data_token?: string;

  @doc("""
    An object that processes function inputs and executes operations through expressions, webhooks, or direct output.
    Properties are evaluated in strict priority order:
    1. expressions
    2. webhooks
    3. output
    
    Evaluation stops at the first property that returns a valid output result, similar to a return statement in a function.
    Any subsequent properties are ignored when a valid output is returned.
    If a valid output is not returned from any of the properties, a generic error message is returned.
    """)
  @minProperties(1)
  data_map?: DataMap;

  @doc("""
    Skips the top-level fillers specified in `ai.languages` (which includes `speech_fillers` and `function_fillers`).
    When set to `true`, only function-specific fillers defined directly on `SWAIG.functions.fillers` will play.
    **Default:** `false`.
    """)
  @example(true)
  skip_fillers?: boolean | SWMLVar = false;

  @doc("Function-specific URL to send status callbacks and reports to. Takes precedence over a default setting. Authentication can also be set in the url in the format of `username:password@url.`")
  @example("username:password:https://statuscallback.com")
  web_hook_url?: string;

  @doc("A file to play while the function is running. `wait_file_loops` can specify the amount of times that files should continously play. Default is not set.")
  @example("https://cdn.signalwire.com/default-music/welcome.mp3")
  wait_file?: url;

  @doc("The number of times to loop playing the file. Default is not set.")
  @example(5)
  wait_file_loops?: integer | string;

  @doc("Whether to wait for fillers to finish playing before continuing with the function. **Default:** `false`.")
  @example(true)
  wait_for_fillers?: boolean | SWMLVar = false;
}

@summary("SWAIG Function")
model UserSWAIGFunction is SWAIGFunctionBase {
  @doc("${functionDescription}")
  @example("get_weather")
  function: string;
}

@summary("startup_hook Function")
model StartUpHookSWAIGFunction is SWAIGFunctionBase {
  @doc("${functionDescription} For the start_hook function, the function name is 'start_hook'.")
  function: "startup_hook";
}

@summary("hangup_hook Function")
model HangUpHookSWAIGFunction is SWAIGFunctionBase {
  @doc("${functionDescription} For the stop_hook function, the function name is 'stop_hook'.")
  function: "hangup_hook";
}

@summary("summarize_conversation Function")
@doc("""
  An internal reserved function that generates a summary of the conversation and sends any specified properties to the configured webhook after the conversation has ended.
  This ensures that key parts of the conversation, as interpreted by the LLM, are reliably captured and delivered to the webhook.
  """)
model SummarizeConversationSWAIGFunction is SWAIGFunctionBase {
  @doc("${functionDescription}. For the summarize_conversation function, the function name is 'summarize_conversation'.")
  function: "summarize_conversation";
}

union SWAIGFunction {
  UserSWAIGFunction,
  StartUpHookSWAIGFunction,
  HangUpHookSWAIGFunction,
  SummarizeConversationSWAIGFunction,
}
