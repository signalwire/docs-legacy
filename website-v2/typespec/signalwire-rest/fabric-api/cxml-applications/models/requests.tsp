import "./core.tsp";
import "../../_shared/enums.tsp";

model CxmlApplicationCreateRequest {
  @doc("Display name of the cXML Application")
  @example("Reception App")
  display_name: string;

  @doc("Project ID for the cXML Application")
  @example("1313fe58-5e14-4c11-bbe7-6fdfa11fe780")
  project_id?: uuid;

  @doc("URL to handle incoming calls")
  @example("https://example.com/voice/incoming")
  voice_url?: string;

  @doc("HTTP method for voice URL")
  @example(UrlMethodType.Post)
  voice_method?: UrlMethodType.Get | UrlMethodType.Post;

  @doc("Fallback URL for voice errors")
  @example("https://example.com/voice/fallback")
  voice_fallback_url?: string;

  @doc("HTTP method for voice fallback URL")
  @example(UrlMethodType.Post)
  voice_fallback_method?: UrlMethodType.Get | UrlMethodType.Post;

  @doc("URL to receive status callbacks")
  @example("https://example.com/voice/status")
  status_callback?: string;

  @doc("HTTP method for status callbacks")
  @example(UrlMethodType.Post)
  status_callback_method?: UrlMethodType.Get | UrlMethodType.Post;

  @doc("URL to handle incoming messages")
  @example("https://example.com/message/incoming")
  sms_url?: string;

  @doc("HTTP method for SMS URL")
  @example(UrlMethodType.Post)
  sms_method?: UrlMethodType.Get | UrlMethodType.Post;

  @doc("Fallback URL for SMS errors")
  @example("https://example.com/message/fallback")
  sms_fallback_url?: string;

  @doc("HTTP method for SMS fallback URL")
  @example(UrlMethodType.Post)
  sms_fallback_method?: UrlMethodType.Get | UrlMethodType.Post;

  @doc("URL to receive SMS status callbacks")
  @example("https://example.com/message/status")
  sms_status_callback?: string;

  @doc("HTTP method for SMS status callbacks")
  @example(UrlMethodType.Post)
  sms_status_callback_method?: UrlMethodType.Get | UrlMethodType.Post;
}

model CxmlApplicationUpdateRequest {
  @doc("Display name of the cXML Application")
  @example("Reception App")
  display_name?: string;

  @doc("Project ID for the cXML Application")
  @example("1313fe58-5e14-4c11-bbe7-6fdfa11fe780")
  @format("uuid")
  account_sid?: uuid;

  @doc("URL to handle incoming calls")
  @example("https://example.com/voice/incoming")
  voice_url?: string;

  @doc("HTTP method for voice URL")
  @example(UrlMethodType.Post)
  voice_method?: UrlMethodType.Get | UrlMethodType.Post;

  @doc("Fallback URL for voice errors")
  @example("https://example.com/voice/fallback")
  voice_fallback_url?: string;

  @doc("HTTP method for voice fallback URL")
  @example(UrlMethodType.Post)
  voice_fallback_method?: UrlMethodType.Get | UrlMethodType.Post;

  @doc("URL to receive status callbacks")
  @example("https://example.com/voice/status")
  status_callback?: string;

  @doc("HTTP method for status callbacks")
  @example(UrlMethodType.Post)
  status_callback_method?: UrlMethodType.Get | UrlMethodType.Post;

  @doc("URL to handle incoming messages")
  @example("https://example.com/message/incoming")
  sms_url?: string;

  @doc("HTTP method for SMS URL")
  @example(UrlMethodType.Post)
  sms_method?: UrlMethodType.Get | UrlMethodType.Post;

  @doc("Fallback URL for SMS errors")
  @example("https://example.com/message/fallback")
  sms_fallback_url?: string;

  @doc("HTTP method for SMS fallback URL")
  @example(UrlMethodType.Post)
  sms_fallback_method?: UrlMethodType.Get | UrlMethodType.Post;

  @doc("URL to receive SMS status callbacks")
  @example("https://example.com/message/status")
  sms_status_callback?: string;

  @doc("HTTP method for SMS status callbacks")
  @example(UrlMethodType.Post)
  sms_status_callback_method?: UrlMethodType.Get | UrlMethodType.Post;
}
