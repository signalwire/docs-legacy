import "@typespec/http";
import "@typespec/openapi";
import "../types";
import "./logs";
import "../_globally_shared/const.tsp";
import "../../_shared/auth.tsp";
import "./tags.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@tagMetadata(MESSAGE_LOGS_TAG, MESSAGE_LOGS_TAG_METADATA)
@externalDocs(
  "https://signalwire.com/docs/apis",
  "Find more information about this and other SignalWire APIs."
)
@info(#{
  title: "Message API",
  version: "1.0.0",
  contact: CONTACT_INFO,
  license: LICENSE_INFO,
  termsOfService: TERMS_OF_SERVICE,
})
@service(#{ title: "Message API" })
@server(
  "https://{space_name}.${SERVER_URL}/messaging",
  "Endpoint",
  {
    @doc(SERVER_URL_DESCRIPTION)
    @example("example")
    space_name: string = "{Your_Space_Name}",
  }
)
@useAuth(SignalWireBasicAuth)
@doc("An API to programmatically access information about SignalWire Message activity.")
namespace MessageAPI;
