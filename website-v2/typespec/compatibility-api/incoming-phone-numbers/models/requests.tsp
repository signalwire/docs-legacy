import "./webhooks.tsp";

using TypeSpec.Http;

@doc("Request body for creating an incoming phone number.")
model CreateIncomingPhoneNumberRequest {
  @doc("The phone number to purchase in E.164 format. Must start with `+` followed by 5-17 digits.")
  @pattern("^\\+\\d{5,17}$")
  @minLength(6)
  @maxLength(18)
  @example("+13103386745")
  PhoneNumber: string;

  @doc("A friendly name for the phone number. If not provided, the formatted phone number will be used.")
  @example("My Business Line")
  FriendlyName?: string;

  @doc("The unique identifier for the application associated with SMS handling on this phone number.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472sa")
  SmsApplicationSid?: string;

  @doc("Whether the request to `SmsFallbackUrl` is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  SmsFallbackMethod?: "GET" | "POST" = "POST";

  @doc("The URL to request if errors occur when fetching SmsUrl.")
  @format("uri")
  @example("https://example.com/sms-fallback")
  SmsFallbackUrl?: string;

  @doc("Whether the request to SmsUrl is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  SmsMethod?: "GET" | "POST" = "POST";

  @doc("The URL to request when an incoming SMS is received.")
  @format("uri")
  @example("https://example.com/sms")
  SmsUrl?: string;

  @webhook("incomingCallStatusCallback", InboundCallStatusCallbackPayload)
  @doc("The URL to request to pass status updates to. See the [Incoming call status callback](/docs/compatibility-api/rest/incoming-phone-numbers/webhooks/incoming-call-status-callback) webhook for the payload your URL will receive.")
  @format("uri")
  @example("https://example.com/status")
  StatusCallback?: string;

  @doc("Whether the request to StatusCallback is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  StatusCallbackMethod?: "GET" | "POST" = "POST";

  @doc("The unique identifier for the application associated with call handling on this phone number.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472va")
  VoiceApplicationSid?: string;

  @doc("Whether the request to VoiceFallbackUrl is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  VoiceFallbackMethod?: "GET" | "POST" = "POST";

  @doc("The URL to request if errors occur when fetching VoiceUrl.")
  @format("uri")
  @example("https://example.com/voice-fallback")
  VoiceFallbackUrl?: string;

  @doc("Whether the request to VoiceUrl is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  VoiceMethod?: "GET" | "POST" = "POST";

  @doc("Whether this number can receive voice calls or faxes. Default is `voice`.")
  @example("voice")
  VoiceReceiveMode?: "voice" | "fax" = "voice";

  @doc("The URL to request when an incoming call is received.")
  @format("uri")
  @example("https://example.com/voice")
  VoiceUrl?: string;
}

@doc("Request body for updating an incoming phone number.")
model UpdateIncomingPhoneNumberRequest {
  @doc("The unique identifier for an account to which the number should be transferred. Must be within the same Space.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472ac")
  AccountSid?: string;

  @doc("The unique identifier of the address associated with E911 for this phone number. Not supported for toll-free numbers or certain providers.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472ad")
  EmergencyAddressSid?: string;

  @doc("A friendly name for the phone number.")
  @minLength(1)
  @maxLength(255)
  @example("My Business Line")
  FriendlyName?: string;

  @doc("The unique identifier for the application associated with SMS handling on this phone number.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472sa")
  SmsApplicationSid?: string;

  @doc("Whether the request to `SmsFallbackUrl` is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  SmsFallbackMethod?: "GET" | "POST" = "POST";

  @doc("The URL to request if errors occur when fetching SmsUrl.")
  @format("uri")
  @example("https://example.com/sms-fallback")
  SmsFallbackUrl?: string;

  @doc("Whether the request to SmsUrl is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  SmsMethod?: "GET" | "POST" = "POST";

  @doc("The URL to request when an incoming SMS is received.")
  @format("uri")
  @example("https://example.com/sms")
  SmsUrl?: string;

  @doc("The URL to request to pass status updates to.")
  @format("uri")
  @example("https://example.com/status")
  StatusCallback?: string;

  @doc("Whether the request to StatusCallback is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  StatusCallbackMethod?: "GET" | "POST" = "POST";

  @doc("The unique identifier for the application associated with call handling on this phone number.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472va")
  VoiceApplicationSid?: string;

  @doc("Whether the request to VoiceFallbackUrl is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  VoiceFallbackMethod?: "GET" | "POST" = "POST";

  @doc("The URL to request if errors occur when fetching VoiceUrl.")
  @format("uri")
  @example("https://example.com/voice-fallback")
  VoiceFallbackUrl?: string;

  @doc("Whether the request to VoiceUrl is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  VoiceMethod?: "GET" | "POST" = "POST";

  @doc("Whether this number can receive voice calls or faxes.")
  @example("voice")
  VoiceReceiveMode?: "voice" | "fax";

  @doc("The URL to request when an incoming call is received.")
  @format("uri")
  @example("https://example.com/voice")
  VoiceUrl?: string;
}
