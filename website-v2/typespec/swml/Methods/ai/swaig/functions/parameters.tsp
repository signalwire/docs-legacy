import "../../../../Shared/Types";
import "@typespec/json-schema";

using TypeSpec.JsonSchema;

// == Formats ==

enum StringFormat {
  date_time,
  time,
  date,
  duration,
  email,
  hostname,
  ipv4,
  ipv6,
  uri,
  uuid,
}

// ===== Parameter Model =====

model FunctionParameters {
  @doc("The type of argument the AI is passing to the function. Possible values are 'string' and 'object'.")
  type: "object";

  @doc("""
    An object containing the property definitions that are passed to the function.
    
    A property definition is a valid JSON schema type with dynamic property names, where:
    - Keys: User-defined strings, that set the property names.
    - Values: A valid property type, which can be one of the following: `string`, `integer`, `number`, `boolean`, `array`, `object`, or `null`.
    """)
  properties: {
    ...TypeSpec.Record<SchemaType>;
  };

  @doc("An array of required property names from the `properties` object.")
  @example(#["name1", "name2"])
  required?: string[];
}

// ===== Property Type Models =====

@summary("Function Parameters Type Union")
@oneOf
union SchemaType {
  StringProperty,
  IntegerProperty,
  NumberProperty,
  BooleanProperty,
  ArrayProperty,
  ObjectProperty,
  NullProperty,
  OneOfProperty,
  AllOfProperty,
  AnyOfProperty,
  ConstProperty,
}

@doc("Base interface for all property types")
model FunctionBaseProperty {
  @doc("A description of the property.")
  @example("Property description")
  description?: string;

  @doc("Whether the property can be null.")
  @example(false)
  nullable?: boolean | SWMLVar;
}

@summary("String Function Property")
model StringProperty is FunctionBaseProperty {
  @doc("The type of parameter(s) the AI is passing to the function.")
  type: "string";

  @doc("An array of strings that are the possible values")
  @example(#["value1", "value2", "value3"])
  `enum`?: string[];

  @doc("The default string value")
  @example("default value")
  default?: string;

  /* Needs to be tested 
    @doc("Minimum length of the string")
    minLength?: integer;
    */

  /* Needs to be tested 
    @doc("Maximum length of the string")
    maxLength?: integer;
    */

  @doc("Regular expression pattern")
  @example("^[a-zA-Z0-9_.-]*$")
  pattern?: string;

  @doc("String format (email, date-time, etc.)")
  format?: StringFormat;
}

@summary("Integer Function Property")
model IntegerProperty is FunctionBaseProperty {
  @doc("The type of parameter(s) the AI is passing to the function.")
  type: "integer";

  @doc("An array of integers that are the possible values")
  @example(#[1, 2, 3])
  `enum`?: integer[];

  @doc("The default integer value")
  @example(5)
  default?: integer | SWMLVar;

  /* Needs to be tested
    @doc("Minimum value")
    minimum?: integer;
    */

  /* Needs to be tested
    @doc("Maximum value")
    maximum?: integer;
    */

  /* Needs to be tested
    @doc("Exclusive minimum value")
    exclusiveMinimum?: integer;
    */

  /* Needs to be tested
    @doc("Exclusive maximum value")
    exclusiveMaximum?: integer;
    */

  /* Needs to be tested
    @doc("Multiple of value")
    multipleOf?: integer;
    */
}

@summary("Number Function Property")
model NumberProperty is FunctionBaseProperty {
  @doc("The type of parameter(s) the AI is passing to the function.")
  type: "number";

  @doc("An array of integers that are the possible values")
  @example(#[1, 2, 3])
  `enum`?: number[] | SWMLVar[];

  @doc("The default integer value")
  @example(3)
  default?: number | SWMLVar;

  /* Needs to be tested
    @doc("Minimum value")
    minimum?: number;
    */

  /* Needs to be tested
    @doc("Maximum value")
    maximum?: number;
    */

  /* Needs to be tested
    @doc("Exclusive minimum value")
    exclusiveMinimum?: number;
    */

  /* Needs to be tested
    @doc("Exclusive maximum value")
    exclusiveMaximum?: number;
    */

  /* Needs to be tested
    @doc("Multiple of value")
    multipleOf?: number;
    */
}

@summary("Boolean Function Property")
model BooleanProperty is FunctionBaseProperty {
  @doc("The type of parameter(s) the AI is passing to the function.")
  type: "boolean";

  @doc("The default boolean value")
  @example(false)
  default?: boolean | SWMLVar;
}

@summary("Const Property")
model ConstProperty {
  @doc("A constant value that can be passed to the function.")
  `const`: unknown;
}

@summary("oneOf Property")
model OneOfProperty {
  @doc("An array of schemas where exactly one of the schemas must be valid.")
  oneOf: SchemaType[];
}

@summary("allOf Property")
model AllOfProperty {
  @doc("An array of schemas where all of the schemas must be valid.")
  allOf: SchemaType[];
}

@summary("anyOf Property")
model AnyOfProperty {
  @doc("An array of schemas where at least one of the schemas must be valid.")
  anyOf: SchemaType[];
}

@summary("Array Function Property")
model ArrayProperty is FunctionBaseProperty {
  @doc("The type of parameter(s) the AI is passing to the function.")
  type: "array";

  @doc("The default array value")
  default?: unknown[];

  @doc("Schema for array items")
  items: SchemaType;

  /* Needs to be tested
    @doc("Minimum number of items")
    minItems?: number;
    */

  /* Needs to be tested
    @doc("Maximum number of items")
    maxItems?: number;
    */

  /* Needs to be tested
    @doc("Whether items must be unique")
    uniqueItems?: boolean;
    */
}

@summary("Object Function Property")
model ObjectProperty is FunctionBaseProperty {
  @doc("The type of parameter(s) the AI is passing to the function.")
  type: "object";

  @doc("The default object value")
  @example(#{ key1: "value1", key2: 42 })
  default?: {
    ...TypeSpec.Record<unknown>;
  };

  @doc("Nested properties")
  properties?: {
    ...TypeSpec.Record<SchemaType>;
  };

  @doc("Required property names")
  @example(#["name1", "name2"])
  required?: string[];

  /* Needs to be tested
    @doc("Minimum number of properties")
    minProperties?: number;
    */

  /* Needs to be tested
    @doc("Maximum number of properties")
    maxProperties?: number;
    */

  /* Needs to be tested
    @doc("Whether to allow additional properties")
    additionalProperties?: boolean;
    */
}

@summary("Null Function Property")
model NullProperty {
  @doc("The type of parameter(s) the AI is passing to the function.")
  type: "null";

  @doc("A description of the property.")
  @example("Property Description")
  description: string;
}
