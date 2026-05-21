import "./webhooks.tsp";

using TypeSpec.Http;

@doc("Request body for creating a message.")
model CreateMessageRequest {
  @doc("The phone number in E.164 format that will receive the message.")
  @example("+15557654321")
  To: string;

  @doc("The phone number in E.164 format that will send the message. Either `From` or `MessagingServiceSid` must be provided.")
  @example("+15551234567")
  From?: string;

  @doc("The text of the message. Either `Body` or `MediaUrl` must be provided.")
  @example("Hello World!")
  Body?: string;

  @doc("URL(s) of media you wish to attach and send with the message. Can be specified multiple times for up to 8 media items.")
  @format("uri")
  @example("https://example.com/image.jpg")
  MediaUrl?: string | string[];

  @doc("When set to true, forces the message to be sent as an MMS.")
  @example(false)
  SendAsMms?: boolean;

  @doc("The SID of a SignalWire cXML Application used to configure the message's status callback.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472ap")
  ApplicationSid?: string;

  @doc("The maximum price in USD acceptable for the message to be sent. Format: decimal with up to 4 decimal places.")
  @pattern("^\\d+\\.?\\d{0,4}$")
  @example("0.0075")
  MaxPrice?: string;

  @webhook("smsStatusCallback", SmsStatusCallbackPayload)
  @doc("A URL endpoint to receive callbacks each time the status of the message changes. See the [SMS status callback](/docs/compatibility-api/rest/messages/webhooks/sms-status-callback) webhook for the payload your URL will receive.")
  @format("uri")
  @example("https://example.com/status-callback")
  StatusCallback?: string;

  @doc("The number of seconds a message will allow being queued before canceling. Must be between 1 and 172800 (48 hours). Default is 14400 (4 hours).")
  @minValue(1)
  @maxValue(172800)
  @example(14400)
  ValidityPeriod?: int32 = 14400;

  @doc("The ID of a number group to use when sending the message. Either `From` or `MessagingServiceSid` must be provided.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472ms")
  MessagingServiceSid?: string;
}

@doc("Request body for updating (redacting) a message.")
model UpdateMessageRequest {
  @doc("The new body of the message. Must be an empty string to redact the message content.")
  @maxLength(0)
  @example("")
  Body: string;
}
