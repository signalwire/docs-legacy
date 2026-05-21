import "../../Methods";

@summary("switch Method")
model Switch {
  @summary("switch")
  @doc("Execute different instructions based on a variable's value.")
  switch: {
    @doc("Name of the variable whose value needs to be compared.")
    @example("prompt_result")
    variable: string;

    @doc("Object of key-mapped values to array of SWML methods to execute.")
    case: {
      ...TypeSpec.Record<SWMLMethod[]>;
    };

    @doc("Array of SWML methods to execute if no cases match.")
    default?: SWMLMethod[];
  };
}
