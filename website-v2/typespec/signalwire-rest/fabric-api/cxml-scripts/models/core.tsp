import "../../../types";

using TypeSpec.Http;

model CXMLScriptPathID {
  @doc("Unique ID of a cXML Script.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

model CXMLScript {
  @doc("Unique ID of a cXML Script.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  id: uuid;

  @doc("The cXML script contents")
  @example("<?xml version=\"1.0\" encoding=\"UTF-8\"?><Response><Say>Hello World</Say></Response>")
  contents: string;

  @doc("The amout of times the cXML script has been requested")
  @example(5)
  request_count: int32;

  @doc("The date and time when the cXML script was last accessed")
  @example(utcDateTime.fromISO("2023-10-01T12:00:00Z"))
  last_accessed_at: utcDateTime | null;

  @doc("The URL where the cXML script can be accessed")
  @example("https://example.signalwire.com/laml-bins/2537c89e-2606-48c2-b3c2-bb601d863d1e")
  request_url: url;

  @doc("The script type the cXML Script is used for")
  @example("calling")
  script_type: "calling" | "messaging";

  @doc("Display name of the cXML Script Fabric Resource")
  @example("Booking Assistant Script")
  display_name: string;

  @doc("The url that will send status updates for the cXML Script")
  @example("https://example.com/cxml/status")
  status_callback_url?: url | null;

  @doc("HTTP method for status callback URL")
  @example(UrlMethodType.Post)
  status_callback_method?: UrlMethodType.Get | UrlMethodType.Post;
}
