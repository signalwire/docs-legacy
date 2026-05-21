using TypeSpec.Http;

model CxmlScriptsAccountSidPath {
  @doc("The unique identifier for the account this script is associated with.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  @format("uuid")
  @path
  AccountSid: string;
}

model CxmlScriptSidPath {
  @doc("The unique identifier of the cXML script.")
  @example("5184b831-184f-4209-872d-ccdccc80f2f1")
  @format("uuid")
  @path
  Sid: string;
}

@doc("cXML Script model.")
model CxmlScript {
  @doc("The unique identifier of the cXML script on SignalWire.")
  @format("uuid")
  @example("5184b831-184f-4209-872d-ccdccc80f2f1")
  sid: string;

  @doc("The date and time, in ISO 8601 format, the script was created.")
  @example("2019-11-26T20:00:00Z")
  date_created: string;

  @doc("The date and time, in ISO 8601 format, the script was updated.")
  @example("2019-11-26T20:00:00Z")
  date_updated: string;

  @doc("The date and time, in ISO 8601 format, the script was last accessed, or null if never accessed.")
  @example("2020-06-05T20:00:00Z")
  date_last_accessed: string | null;

  @doc("The unique identifier for the account this script is associated with.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  account_sid: string;

  @doc("A friendly name given to the cXML script.")
  @example("Death Star IVR")
  name: string;

  @doc("The contents of the cXML script.")
  @example("<Response><Say>Hello!</Say></Response>")
  contents: string;

  @doc("The unique URL to the raw contents of the cXML script.")
  @format("uri")
  @example("https://example.signalwire.com/laml-bins/5184b831-184f-4209-872d-ccdccc80f2f1")
  request_url: string;

  @doc("The number of times this cXML script has been accessed.")
  @example(42)
  num_requests: int32;

  @doc("The version of the SignalWire API.")
  @example("2010-04-01")
  api_version: string;

  @doc("The URL of this resource.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/LamlBins/5184b831-184f-4209-872d-ccdccc80f2f1")
  uri: string;
}
