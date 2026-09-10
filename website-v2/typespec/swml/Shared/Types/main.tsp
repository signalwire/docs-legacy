import "../../../_shared/types/main.tsp";

@doc("""
  A SWML variable reference for dynamic value substitution at runtime.
  
  Use the `\${varname}` or `%{varname}` syntax to reference variables that will be resolved when the SWML is executed.
  Variables can be:
  - **SignalWire-provided variables**: System variables like `\${call.from}`, `\${call.to}`, `\${call.direction}`, etc.
  - **User-defined variables**: Custom variables set via `set_global_data` action or passed in the initial SWML script's `global_data` object.
  - **Function return values**: Variables populated from SWAIG function responses.
  
  Example: `\${global_data.customer_name}` will be replaced with the value of `customer_name` from the global_data object at runtime.
  """)
@pattern("^[\\$%]\\{.*\\}$")
@summary("SWML Variable Reference")
scalar SWMLVar extends string;

alias SupportedAIModels =
  | "gpt-4o-mini"
  | "gpt-4.1-mini"
  | "gpt-4.1-nano"
  | string;

@doc("Speech recognition engine options.")
enum SpeechEngine {
  @doc("Use Deepgram for speech recognition.")
  deepgram,

  @doc("Use Google for speech recognition.")
  google,
}
