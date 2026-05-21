import "../../../types";
import "../../_shared/enums.tsp";

using TypeSpec.Http;

model CxmlApplicationPathID {
  @doc("Unique ID of a cXML Application.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

model CxmlApplication {
  @doc("Unique ID of the cXML Application.")
  @example("1313fe58-5e14-4c11-bbe7-6fdfa11fe780")
  @format("uuid")
  id: uuid;

  @doc("Project ID for the cXML Application")
  @example("1313fe58-5e14-4c11-bbe7-6fdfa11fe780")
  project_id: uuid;

  @doc("Display name of the cXML Application")
  @example("Reception App")
  friendly_name: string;

  @doc("URL to handle incoming calls")
  @example("https://example.com/voice/incoming")
  voice_url: string | null;

  @doc("HTTP method for voice URL")
  @example(UrlMethodType.Get)
  voice_method: UrlMethodType.Get | UrlMethodType.Post;

  @doc("Fallback URL for voice errors")
  @example("https://example.com/voice/fallback")
  voice_fallback_url: string | null;

  @doc("HTTP method for voice fallback URL")
  @example(UrlMethodType.Get)
  voice_fallback_method: UrlMethodType.Get | UrlMethodType.Post;

  @doc("URL to receive status callbacks")
  @example("https://example.com/voice/status")
  status_callback: url | null;

  @doc("HTTP method for status callbacks")
  @example(UrlMethodType.Get)
  status_callback_method: UrlMethodType.Get | UrlMethodType.Post;

  @doc("URL to handle incoming messages")
  @example("https://example.com/message/incoming")
  sms_url: string | null;

  @doc("HTTP method for SMS URL")
  @example(UrlMethodType.Get)
  sms_method: UrlMethodType.Get | UrlMethodType.Post;

  @doc("Fallback URL for SMS errors")
  @example("https://example.com/message/fallback")
  sms_fallback_url: string | null;

  @doc("HTTP method for SMS fallback URL")
  @example(UrlMethodType.Get)
  sms_fallback_method: UrlMethodType.Get | UrlMethodType.Post;

  @doc("URL to receive SMS status callbacks")
  @example("https://example.com/message/status")
  sms_status_callback: string | null;

  @doc("HTTP method for SMS status callbacks")
  @example(UrlMethodType.Get)
  sms_status_callback_method: UrlMethodType.Get | UrlMethodType.Post;
}
