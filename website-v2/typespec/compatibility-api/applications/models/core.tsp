using TypeSpec.Http;

model AccountSidPath {
  @doc("The Account ID that has the Application.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  @format("uuid")
  @path
  AccountSid: string;
}

model ApplicationPathSid {
  @doc("The Application ID that uniquely identifies the Application.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  @format("uuid")
  @path
  Sid: string;
}

@doc("HTTP method for webhooks.")
enum HttpMethod {
  GET: "GET",
  POST: "POST",
}

@doc("Application model representing a cXML application.")
model Application {
  @doc("The unique identifier for the Application.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  @format("uuid")
  sid: string;

  @doc("The unique identifier for the Account that created this Application.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  @format("uuid")
  account_sid: string;

  @doc("The version of the SignalWire API.")
  @example("2010-04-01")
  api_version: string;

  @doc("The date, in RFC 2822 GMT format, this Application was created.")
  @example("Sat, 15 Sept 2018 10:00:00 +0000")
  date_created: string;

  @doc("The date, in RFC 2822 GMT format, this Application was updated.")
  @example("Sat, 16 Sept 2018 10:00:00 +0000")
  date_updated: string;

  @doc("A named unique identifier for the resource.")
  @example("My Friendly Name")
  friendly_name: string;

  @doc("The URI for this Application.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Applications/b3877c40-da60-4998-90ad-b792e98472af.json")
  uri: string;

  @doc("The URL to request when a phone number receives a call or fax.")
  @example("http://example.com")
  voice_url: string | null;

  @doc("Whether the request to `VoiceUrl` is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  voice_method: string | null;

  @doc("The URL SignalWire will request if errors occur when fetching the `VoiceUrl`.")
  @example("http://example.com")
  voice_fallback_url: string | null;

  @doc("Whether the request to `VoiceFallbackUrl` is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  voice_fallback_method: string | null;

  @doc("The URL to pass status updates to the Application.")
  @example("http://example.com")
  status_callback: string | null;

  @doc("Whether the request to the `StatusCallback` URL is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  status_callback_method: string | null;

  @doc("Whether or not to look up a caller's ID from the database. Always null.")
  @example(null)
  voice_caller_id_lookup: boolean | null;

  @doc("The URL to request when an SMS is received.")
  @example("http://example.com")
  sms_url: string | null;

  @doc("Whether the request to `SmsUrl` is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  sms_method: string | null;

  @doc("The URL SignalWire will request if errors occur when fetching the `SmsUrl`.")
  @example("http://www.example.com/sms-fallback")
  sms_fallback_url: string | null;

  @doc("Whether the request to `SmsFallbackUrl` is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  sms_fallback_method: string | null;

  @doc("The URL to receive status updates for messages sent via this Application.")
  @example("http://www.example.com/sms-status-callback")
  sms_status_callback: string | null;

  @doc("Whether the request to `SmsStatusCallback` is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  sms_status_callback_method: string | null;

  @doc("The URL to receive status updates for messages sent via this Application.")
  @example("http://www.example.com/sms-status-callback")
  message_status_callback: string | null;
}
