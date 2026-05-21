using TypeSpec.Http;

model TranscriptionsAccountSidPath {
  @doc("The unique identifier for the account that created this transcription.")
  @example("b3877c40-da60-4998-90ad-b792e98472ac")
  @format("uuid")
  @path
  AccountSid: string;
}

model TranscriptionSidPath {
  @doc("The unique identifier for the transcription.")
  @example("b3877c40-da60-4998-90ad-b792e98472tr")
  @format("uuid")
  @path
  Sid: string;
}

@doc("Transcription model.")
model Transcription {
  @doc("The unique identifier for the transcription.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472tr")
  sid: string;

  @doc("The unique identifier for the account that created this transcription.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472ac")
  account_sid: string;

  @doc("The version of the SignalWire API.")
  @example("2010-04-01")
  api_version: string;

  @doc("The unique identifier for the recording that this transcription was created from.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472re")
  recording_sid: string;

  @doc("The date, in RFC 2822 format, this transcription was created.")
  @example("Thu, 27 Sep 2018 02:00:00 +0000")
  date_created: string;

  @doc("The date, in RFC 2822 format, this transcription was updated.")
  @example("Fri, 28 Sep 2018 03:00:00 +0000")
  date_updated: string;

  @doc("The duration, in seconds, of the transcribed audio.")
  @example(60)
  @minValue(0)
  duration: int32;

  @doc("The charge for the transcription. Null if cost has not been calculated.")
  @example("-0.00025")
  price: string | null;

  @doc("The currency, in ISO 4217 format, for the price of the transcription.")
  @example("USD")
  price_unit: string;

  @doc("The status of the transcription. Always 'completed' for transcriptions returned by the API.")
  @example("completed")
  status: string;

  @doc("The text content of the transcription. Null if transcription text is not available.")
  @example("Hello, this is a test transcription.")
  transcription_text: string | null;

  @doc("The type of the transcription. Currently always an empty string.")
  @example("")
  type: string;

  @doc("The URI of this resource, relative to the API base URL.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472ac/Transcriptions/b3877c40-da60-4998-90ad-b792e98472tr.json")
  uri: string;
}
