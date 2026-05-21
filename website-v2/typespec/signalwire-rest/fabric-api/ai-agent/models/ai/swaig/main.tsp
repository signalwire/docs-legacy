import "./defaults.tsp";
import "./native_functions.tsp";
import "./includes.tsp";
import "./functions";

@summary("swaig")
model SWAIG {
  @doc("Default settings for all SWAIG functions. If `defaults` is not set, settings may be set in each function object. Default is not set.")
  defaults?: SWAIGDefaults;

  @doc("Prebuilt functions the AI agent is able to call from this list of available native functions")
  native_functions?: SWAIGNativeFunction[];

  @doc("""
    An array of objects to include remote function signatures.
    The object fields are url to specify where the remote functions are defined and functions which is an array of the function names as strings.
    """)
  includes?: SWAIGIncludes[];

  @doc("""
    An array of JSON objects to define functions that can be executed during the interaction with the AI. Default is not set.
    The fields of this object are the six following.
    """)
  functions?: SWAIGFunction[];
}
