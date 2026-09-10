import "../ai";

union OmittedPromptProps {
  "contexts",
}

model BedrockPromptBase {
  @example("matthew")
  voice_id?: "tiffany" | "matthew" | "amy" | "lupe" | "carlos" = "matthew";
}

model BedrockPromptText is BedrockPromptBase {
  ...AIPromptText;
}

model BedrockPromptPom is BedrockPromptBase {
  ...AIPostPromptPom;
}

union BedrockPrompt {
  OmitProperties<BedrockPromptText, OmittedPromptProps>,
  OmitProperties<BedrockPromptPom, OmittedPromptProps>,
}

model BedrockPostPomptText is AIPostPromptText;

model BedrockPostPromptPom is AIPostPromptPom;

union BedrockPostPrompt {
  OmitProperties<BedrockPostPomptText, OmittedPromptProps>,
  OmitProperties<BedrockPostPromptPom, OmittedPromptProps>,
}
