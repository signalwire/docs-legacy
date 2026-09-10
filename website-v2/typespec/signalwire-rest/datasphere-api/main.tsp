import "@typespec/http";
import "@typespec/openapi";
import "../types";
import "../../_shared/auth.tsp";
import "./document";
import "./tags.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@tagMetadata(DOCUMENTS_TAG, DOCUMENTS_TAG_METADATA)
@tagMetadata(CHUNKS_TAG, CHUNKS_TAG_METADATA)
@service(#{ title: "Datasphere API" })
@server(
  "https://{space_name}.signalwire.com/api/datasphere",
  "Endpoint",
  {
    space_name: string = "{Your_Space_Name}",
  }
)
@useAuth(SignalWireBasicAuth)
@doc("An AI-powered API for document search.")
namespace DatasphereAPI;
