import "@typespec/json-schema";

using TypeSpec.JsonSchema;

model PayPromptSayAction {
  @doc("When the action `type` is `Say`, this value is the text to be spoken; when the type is `Play`, it should be a URL to the audio file.")
  type: "Say";

  @doc("The phrase to speak")
  @example("Please enter your 16-digit card number.")
  phrase: string;
}

model PayPromptPlayAction {
  @doc("When the action `type` is `Say`, this value is the text to be spoken; when the type is `Play`, it should be a URL to the audio file.")
  type: "Play";

  @doc("The URL of the audio file to play")
  @pattern("^(http|https)://")
  @example("https://example.com/audio/enter-card-number.mp3")
  phrase: url;
}

union PayPromptAction {
  PayPromptSayAction,
  PayPromptPlayAction,
}
