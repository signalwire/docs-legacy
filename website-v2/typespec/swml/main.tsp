import "@typespec/json-schema";
import "./Methods";

using TypeSpec.JsonSchema;

@summary("SWML sections")
model Section {
  main: SWMLMethod[];
  ...TypeSpec.Record<SWMLMethod[]>;
}

@jsonSchema
@summary("SWML Object")
model SWMLObject {
  version?: "1.0.0";
  sections: Section;
}
