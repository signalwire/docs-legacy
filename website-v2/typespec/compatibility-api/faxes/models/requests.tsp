using TypeSpec.Http;

@doc("Request body for sending a fax.")
model SendFaxRequest {
  @doc("The URL hosting the fax media to send.")
  @example("https://example.com/fax.pdf")
  MediaUrl: string;

  @doc("The phone number, in E.164 format, or SIP URI the fax will be sent to.")
  @example("+13104456789")
  To: string;

  @doc("The phone number, in E.164 format, or client identifier the fax will be sent from.")
  @example("+13103383454")
  From: string;

  @doc("The quality of the fax. Default is 'fine'.")
  @example("fine")
  Quality?: "standard" | "fine" | "superfine" = "fine";

  @doc("The URL to send status callback requests to when the fax status changes.")
  @example("https://your-api-endpoint.com/fax-status")
  StatusCallback?: string;

  @doc("The HTTP method to use for status callback requests. Default is 'POST'.")
  @example("POST")
  StatusCallbackMethod?: "GET" | "POST" = "POST";

  @doc("The events that trigger status callback requests. Valid values: 'initiated', 'ringing', 'answered', 'completed', 'ringing_forwarded', 'ringing_queued'. Default is ['completed'].")
  @example(#["completed"])
  StatusCallbackEvent?: string[];

  @doc("Whether to store the fax media. Default is 'true'.")
  @example("true")
  StoreMedia?: "true" | "false" = "true";

  @doc("Time to live in minutes for the fax. Must be between 5 and 300. Default is 60.")
  @minValue(5)
  @maxValue(300)
  @example(60)
  Ttl?: int32 = 60;

  @doc("The username for SIP authentication.")
  @example("user123")
  SipAuthUsername?: string;

  @doc("The password for SIP authentication.")
  @example("password123")
  SipAuthPassword?: string;
}

@doc("Request body for updating (canceling) a fax.")
model UpdateFaxRequest {
  @doc("The status to set. Only 'canceled' is allowed. The fax must be in 'queued' status to be canceled.")
  @example("canceled")
  Status: "canceled";
}
