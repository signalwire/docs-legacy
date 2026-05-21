import "@typespec/http";
import "@typespec/openapi";
import "../types";
import "./tokens";
import "../_globally_shared/const.tsp";
import "../../_shared/auth.tsp";
import "./tags.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@tagMetadata(TOKENS_TAG, TOKENS_TAG_METADATA)
@externalDocs(
  "https://signalwire.com/docs/apis",
  "Find more information about this and other SignalWire APIs."
)
@info(#{
  title: "PubSub API",
  version: "1.0.0",
  contact: CONTACT_INFO,
  license: LICENSE_INFO,
  termsOfService: TERMS_OF_SERVICE,
})
@service(#{ title: "PubSub API" })
@server(
  "https://{space_name}.${SERVER_URL}/pubsub",
  "Endpoint",
  {
    @doc(SERVER_URL_DESCRIPTION)
    @example("example")
    space_name: string = "{Your_Space_Name}",
  }
)
@useAuth(SignalWireBasicAuth)
@doc("""
  An API to use PubSub channels in your own application.
  """)
namespace PubSubAPI;
