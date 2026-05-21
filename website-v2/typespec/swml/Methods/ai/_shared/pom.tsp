import "@typespec/json-schema";

using TypeSpec.JsonSchema;

@doc("Base model for common section properties")
model PomSectionBase {
  @doc("Title for the section")
  @minLength(1)
  @example("Customer Service Guidelines")
  title?: string;

  @doc("Optional array of nested subsections")
  @minItems(1)
  subsections?: POM[];

  @doc("Whether to number the section")
  @example(true)
  numbered?: boolean | SWMLVar;

  @doc("Whether to number the bullets")
  @example(false)
  numberedBullets?: boolean | SWMLVar;
}

@summary("Section with Body")
@doc("Content model with body text and optional bullets")
model PomSectionBodyContent is PomSectionBase {
  @doc("Body text for the section")
  @example("Welcome customers warmly and assist them with their inquiries.")
  body: string;

  @doc("Optional array of bullet points")
  @minItems(1)
  @example(#[
    "Be polite and professional",
    "Listen actively to customer concerns",
    "Provide accurate information"
  ])
  bullets?: string[];
}

@summary("Section with Bullets")
@doc("Content model with bullets and optional body")
model PomSectionBulletsContent is PomSectionBase {
  @doc("Body text for the section (optional)")
  @example("Follow these steps when handling customer complaints:")
  body?: string;

  @doc("Array of bullet points")
  @minItems(1)
  @example(#[
    "Acknowledge the issue",
    "Apologize for any inconvenience",
    "Offer a resolution"
  ])
  bullets: string[];
}

@doc("Regular section that requires either body or bullets.")
union POM {
  PomSectionBodyContent,
  PomSectionBulletsContent,
}
