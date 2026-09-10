import "@typespec/json-schema";

import "../../Methods";

using TypeSpec.JsonSchema;

@summary("Condition with When/Then")
model CondReg {
  @doc("The JavaScript condition to act on.")
  @example("vars.digit == '1'")
  when: string;

  @doc("Sequence of SWML methods to execute when the condition evaluates to true.")
  then: SWMLMethod[];

  @doc("Sequence of SWML methods to execute when none of the other conditions evaluate to true.")
  `else`?: SWMLMethod[];
}

@summary("Else Fallback")
model CondElse {
  @doc("Sequence of SWML methods to execute when none of the other conditions evaluate to true.")
  `else`: SWMLMethod[];
}

@oneOf
@summary("CondParams union")
union CondParams {
  CondReg,
  CondElse,
}

@summary("cond Method")
model Cond {
  @summary("cond")
  @doc("Execute a sequence of instructions depending on the value of a JavaScript condition.")
  cond: CondParams[];
}
