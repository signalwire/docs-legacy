import "../../../_shared/webhook/decorator.tsp";

@summary("Transcription status callback")
@doc("""
  Payload sent by SignalWire to your Transcription Status Callback URL when the status of a transcription changes.

  Configure this callback by enabling transcription on a recording via the
  [Record](/compatibility-api/cxml/voice/record) verb (`transcribe=true`) and setting `transcribeCallback`
  to your webhook URL.

  Your app can use these parameters to handle the transcription — for example, uploading the text to
  your CRM, sending it via email, or forwarding the body via SignalWire SMS.
  """)
model TranscriptionStatusCallbackPayload {
  @doc("The unique, 34-character ID of the transcription.")
  @example("b3877c40-da60-4998-90ad-b792e984tr01")
  TranscriptionSid: string;

  @doc("The text of the transcription.")
  @example("Hello, I'd like to schedule an appointment for next Tuesday.")
  TranscriptionText: string;

  @doc("The status of the transcription.")
  @example("completed")
  TranscriptionStatus: "completed" | "failed";

  @doc("The URL for the transcription's REST API resource.")
  @example("https://example.signalwire.com/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Transcriptions/b3877c40-da60-4998-90ad-b792e984tr01")
  TranscriptionUrl: string;

  @doc("The unique, 34-character identifier for the recording from which the transcription was generated.")
  @example("b3877c40-da60-4998-90ad-b792e984re01")
  RecordingSid: string;

  @doc("The URL for the audio recording from which the transcription was generated.")
  @example("https://example.signalwire.com/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Recordings/b3877c40-da60-4998-90ad-b792e984re01")
  RecordingUrl: string;
}
