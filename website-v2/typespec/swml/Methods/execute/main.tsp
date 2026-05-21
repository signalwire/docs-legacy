import "../../Methods";

@summary("ExecuteSwitch object")
model ExecuteSwitch {
  @doc("""
    Name of the variable whose value needs to be compared. If not provided, it will check the `return_value` variable.
    Can be one of the listed set of variables, or a string to represent a custom variable.
    """)
  @example("return_value")
  variable?: string;

  @doc("Object of values mapped to array of instructions to execute")
  case: {
    ...TypeSpec.Record<SWMLMethod[]>;
  };

  @doc("Array of instructions to execute if no cases match")
  default?: SWMLMethod[];
}

@summary("execute Method")
model Execute {
  @doc("""
    Execute a specified section or URL as a subroutine, and upon completion, return to the current document.
    Use the return statement to pass any return values or objects back to the current document.
    """)
  execute: {
    @doc("""
      Specifies what to execute. The value can be one of:
      - `<section_name>` - section in the current document to execute
      - A URL (http or https) that returns a SWML document - Sends HTTP POST
      - An inline SWML document (as a JSON string)
      """)
    @example("https://example.com/swml-handler")
    dest: string;

    @doc("Named parameters to send to section or URL")
    @example(#{ caller_id: "+15551234567", language: "en-US" })
    params?: {
      ...TypeSpec.Record<unknown>;
    };

    @doc("User-defined metadata, ignored by SignalWire")
    @example(#{ request_id: "req_abc123", source: "ivr" })
    meta?: {
      ...TypeSpec.Record<unknown>;
    };

    @doc("The list of SWML instructions to be executed when the executed section or URL returns")
    on_return?: SWMLMethod[];

    @doc("""
      Action to take based on the result of the call. This will run once the peer leg of the call has ended.
      Will use the switch method when the return_value is an object, and will use the cond method when the return_value is an array.
      """)
    result?: ExecuteSwitch | Cond.cond;
  };
}
