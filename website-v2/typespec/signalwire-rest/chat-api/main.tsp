import "@typespec/http";
import "@typespec/openapi";
import "../types";
import "../../_shared/auth.tsp";
import "./tokens";
import "./tags.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@tagMetadata(TOKENS_TAG, TOKENS_TAG_METADATA)
@service(#{ title: "Chat API" })
@server(
  "https://{space_name}.signalwire.com/api/chat",
  "Endpoint",
  {
    space_name: string = "{Your_Space_Name}",
  }
)
@useAuth(SignalWireBasicAuth)
@doc("""
  An API to programmatically create your own Chat Applications.
  """)
namespace ChatAPI;
