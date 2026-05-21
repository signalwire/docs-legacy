using TypeSpec.Http;

@doc("Request body for creating a cXML script.")
model CreateCxmlScriptRequest {
  @doc("A friendly name given to the cXML script. Required.")
  @minLength(1)
  @example("Death Star IVR")
  Name: string;

  @doc("The cXML contents of the script. Must be valid XML with proper Mustache syntax if templates are used. Defaults to an empty Response element.")
  @example("<Response><Say>Hello!</Say></Response>")
  Contents?: string;
}

@doc("Request body for updating a cXML script.")
model UpdateCxmlScriptRequest {
  @doc("A friendly name given to the cXML script. Required.")
  @minLength(1)
  @example("Death Star IVR")
  Name: string;

  @doc("The cXML contents of the script. Must be valid XML with proper Mustache syntax if templates are used.")
  @example("<Response><Say>Hello!</Say></Response>")
  Contents?: string;
}
