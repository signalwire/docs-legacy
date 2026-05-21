import "@typespec/http";
import "@typespec/openapi";
import "../types";
import "./logs";
import "../_globally_shared/const.tsp";
import "../../_shared/auth.tsp";
import "./tags.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@tagMetadata(VOICE_LOGS_TAG, VOICE_LOGS_TAG_METADATA)
@externalDocs(
  "https://signalwire.com/docs/apis",
  "The Voice API holds a collection of endpoints that will help you find voice related logs."
)
@info(#{
  title: "Voice API",
  version: "1.0.0",
  contact: CONTACT_INFO,
  license: LICENSE_INFO,
  termsOfService: TERMS_OF_SERVICE,
})
@service(#{ title: "Voice API" })
@server(
  "https://{space_name}.${SERVER_URL}/voice",
  "Endpoint",
  {
    @doc(SERVER_URL_DESCRIPTION)
    @example("example")
    space_name: string = "{Your_Space_Name}",
  }
)
@useAuth(SignalWireBasicAuth)
@doc("An API to programmatically access information about SignalWire Voice activity.")
namespace VoiceAPI;
