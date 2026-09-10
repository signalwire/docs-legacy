@summary("LanguagesBase")
model LanguagesBase {
  @doc("Name of the language ('French', 'English', etc).")
  @example("French")
  name: string;

  @doc("Language code. For example, 'fr-FR'.")
  @example("fr-FR")
  code: string;

  @doc("Voice to use for the language. For example, 'fr-FR-Neural2-B'.")
  @example("fr-FR-Neural2-B")
  voice: string;
}

@summary("LanguagesWithFillers")
model LanguagesWithFillers is LanguagesBase {
  @doc("An array of strings to be used as fillers in the conversation when calling a `swaig function`. This helps the AI break silence between responses.")
  @example(#["great", "ok"])
  function_fillers?: string[];

  @doc("An array of strings to be used as fillers in the conversation. This helps the AI break silence between responses.")
  @example(#["umm", "hmm"])
  speech_fillers?: string[];
}

@summary("languages")
union Languages {
  LanguagesWithFillers,
}
