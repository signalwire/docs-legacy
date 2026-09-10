import "../label";
import "../../Shared/Types/main.tsp";
@summary("goto Method")
model Goto {
  @doc("""
    Jump to a label within the current section, optionally based on a condition.
    The goto method will only navigate to a label within the same section.
    """)
  goto: {
    label: Label.label;

    @doc("A JavaScript condition that determines whether to perform the jump. If the condition evaluates to true, the jump is executed. If omitted, the jump is unconditional.")
    @example("vars.retry_count < 3")
    when?: string;

    @doc("The maximum number of times to perform the jump. Must be a number between 1 and 100. Default `100`.")
    @minValue(1)
    @maxValue(100)
    @example(3)
    max?: integer | SWMLVar = 100;
  };
}
