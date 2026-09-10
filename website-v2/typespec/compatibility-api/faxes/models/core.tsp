using TypeSpec.Http;

model FaxesAccountSidPath {
  @doc("The Project ID that uniquely identifies the Account.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  @format("uuid")
  @path
  AccountSid: string;
}

model FaxSidPath {
  @doc("The Fax ID that uniquely identifies the Fax.")
  @example("b3877c40-da60-4998-90ad-b792e98472fx")
  @format("uuid")
  @path
  Sid: string;
}

model FaxSidPathForMedia {
  @doc("The Fax ID that uniquely identifies the Fax.")
  @example("b3877c40-da60-4998-90ad-b792e98472fx")
  @format("uuid")
  @path
  FaxSid: string;
}

@doc("Fax direction.")
enum FaxDirection {
  Inbound: "inbound",
  Outbound: "outbound",
}

@doc("Fax quality.")
enum FaxQuality {
  Standard: "standard",
  Fine: "fine",
  Superfine: "superfine",
}

@doc("Fax status.")
enum FaxStatus {
  Queued: "queued",
  Processing: "processing",
  Sending: "sending",
  Delivered: "delivered",
  Receiving: "receiving",
  Received: "received",
  NoAnswer: "no-answer",
  Busy: "busy",
  Failed: "failed",
  Canceled: "canceled",
}

@doc("Fax links.")
model FaxLinks {
  @doc("Media associated with this fax.")
  @example("/fax/v1/Faxes/b3877c40-da60-4998-90ad-b792e98472fx/Media")
  media: string;
}

@doc("Fax model.")
model Fax {
  @doc("The unique identifier for the account this fax is associated with.")
  @example("b3877c40-da60-4998-90ad-b792e98472ac")
  account_sid: string;

  @doc("The version of the SignalWire API.")
  @example("v1")
  api_version: string;

  @doc("The date and time, in ISO 8601 format, the fax was created.")
  @example("2018-11-26T20:00:00Z")
  date_created: string;

  @doc("The date and time, in ISO 8601 format, the fax was updated.")
  @example("2018-11-27T20:00:00Z")
  date_updated: string;

  @doc("The direction of the fax.")
  direction: FaxDirection;

  @doc("The phone number, in E.164 format, the fax was sent from.")
  @example("+13103383454")
  from: string;

  @doc("The URL hosting the received media, or null if not available.")
  @example("https://example.com/fax.pdf")
  media_url: string | null;

  @doc("The unique identifier for the media instance associated with the fax instance.")
  @example("b3877c40-da60-4998-90ad-b792e98472me")
  media_sid: string;

  @doc("The number of pages in the fax document, or null if not yet determined.")
  @example("3")
  num_pages: string | null;

  @doc("The cost of the fax, or null if not yet calculated.")
  @example("-0.005")
  price: string | null;

  @doc("The currency, in ISO 4217 format, of the price.")
  @example("USD")
  price_unit: string;

  @doc("The quality of the fax.")
  quality: FaxQuality;

  @doc("The unique identifier of the fax.")
  @example("b3877c40-da60-4998-90ad-b792e98472fx")
  sid: string;

  @doc("The status of the fax.")
  status: FaxStatus;

  @doc("The phone number, in E.164 format, the fax was sent to.")
  @example("+13104456789")
  to: string;

  @doc("The time, in seconds, it took to deliver a fax.")
  @example(5000)
  duration: int32;

  @doc("The URL links for resources associated with the fax.")
  links: FaxLinks;

  @doc("The URL of this resource.")
  @example("/fax/v1/Faxes/b3877c40-da60-4998-90ad-b792e98472fx")
  url: string;

  @doc("Error code for this resource, or null if no error.")
  @example(null)
  error_code: string | null;

  @doc("The description of this error, or null if no error.")
  @example(null)
  error_message: string | null;
}

@doc("Fax media model.")
model FaxMedia {
  @doc("The unique identifier for the account.")
  @example("b3877c40-da60-4998-90ad-b792e98472ac")
  account_sid: string;

  @doc("The content type of the media.")
  @example("application/pdf")
  content_type: string;

  @doc("The date, in ISO 8601 format, this media was created.")
  @example("2018-11-26T20:00:00Z")
  date_created: string;

  @doc("The date, in ISO 8601 format, this media was updated.")
  @example("2018-11-27T20:00:00Z")
  date_updated: string;

  @doc("The unique identifier for the fax.")
  @example("b3877c40-da60-4998-90ad-b792e98472fx")
  fax_sid: string;

  @doc("The unique identifier for the media.")
  @example("b3877c40-da60-4998-90ad-b792e98472me")
  sid: string;

  @doc("The URI for the media.")
  @example("/fax/v1/Faxes/b3877c40-da60-4998-90ad-b792e98472fx/Media/b3877c40-da60-4998-90ad-b792e98472me.json")
  uri: string;

  @doc("The URL for the media.")
  @example("/fax/v1/Faxes/b3877c40-da60-4998-90ad-b792e98472fx/Media/b3877c40-da60-4998-90ad-b792e98472me.json")
  url: string;
}
