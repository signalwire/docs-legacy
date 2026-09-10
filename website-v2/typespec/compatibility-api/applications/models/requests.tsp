using TypeSpec.Http;

@doc("Request body for creating or updating an application.")
model ApplicationRequestBody {
  @doc("A named unique identifier for the resource.")
  @maxLength(64)
  @example("My Friendly Name")
  FriendlyName: string;

  @doc("The URL to request when a phone number receives a call or fax.")
  @format("uri")
  @example("http://example.com")
  VoiceUrl?: string;

  @doc("Whether the request to `VoiceUrl` is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  VoiceMethod?: "GET" | "POST" = "POST";

  @doc("The URL SignalWire will request if errors occur when fetching the `VoiceUrl`.")
  @format("uri")
  @example("http://example.com")
  VoiceFallbackUrl?: string;

  @doc("Whether the request to `VoiceFallbackUrl` is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  VoiceFallbackMethod?: "GET" | "POST" = "POST";

  @doc("The URL to pass status updates to the Application.")
  @format("uri")
  @example("http://example.com")
  StatusCallback?: string;

  @doc("Whether the request to the `StatusCallback` URL is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  StatusCallbackMethod?: "GET" | "POST" = "POST";

  @doc("The URL to request when an SMS is received.")
  @format("uri")
  @example("http://example.com")
  SmsUrl?: string;

  @doc("Whether the request to `SmsUrl` is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  SmsMethod?: "GET" | "POST" = "POST";

  @doc("The URL SignalWire will request if errors occur when fetching the `SmsUrl`.")
  @format("uri")
  @example("http://www.example.com/sms-fallback")
  SmsFallbackUrl?: string;

  @doc("Whether the request to `SmsFallbackUrl` is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  SmsFallbackMethod?: "GET" | "POST" = "POST";

  @doc("The URL to receive status updates for messages sent via this Application.")
  @format("uri")
  @example("http://www.example.com/sms-status-callback")
  SmsStatusCallback?: string;

  @doc("Whether the request to `SmsStatusCallback` is a `GET` or a `POST`. Default is `POST`.")
  @example("POST")
  SmsStatusCallbackMethod?: "GET" | "POST" = "POST";
}

@doc("Request body for creating an application.")
model CreateApplicationRequest {
  ...ApplicationRequestBody;
}

@doc("Request body for updating an application.")
model UpdateApplicationRequest {
  ...ApplicationRequestBody;
}
