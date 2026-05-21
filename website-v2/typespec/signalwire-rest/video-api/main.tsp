import "@typespec/http";
import "@typespec/openapi";
import "../types";
import "../_globally_shared/const.tsp";
import "../../_shared/auth.tsp";
import "./rooms";
import "./streams";
import "./room-sessions";
import "./room-tokens";
import "./room-recordings";
import "./conferences";
import "./conference-tokens";
import "./logs";
import "./tags.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@tagMetadata(ROOMS_TAG, ROOMS_TAG_METADATA)
@tagMetadata(STREAMS_TAG, STREAMS_TAG_METADATA)
@tagMetadata(ROOM_SESSIONS_TAG, ROOM_SESSIONS_TAG_METADATA)
@tagMetadata(ROOM_TOKENS_TAG, ROOM_TOKENS_TAG_METADATA)
@tagMetadata(ROOM_RECORDINGS_TAG, ROOM_RECORDINGS_TAG_METADATA)
@tagMetadata(CONFERENCES_TAG, CONFERENCES_TAG_METADATA)
@tagMetadata(CONFERENCE_TOKENS_TAG, CONFERENCE_TOKENS_TAG_METADATA)
@tagMetadata(LOGS_TAG, LOGS_TAG_METADATA)
@externalDocs(
  "https://signalwire.com/docs/apis",
  "Find more information about this and other SignalWire APIs."
)
@info(#{
  title: "Video API",
  version: "1.0.0",
  contact: CONTACT_INFO,
  license: LICENSE_INFO,
  termsOfService: TERMS_OF_SERVICE,
})
@service(#{ title: "Video API" })
@server(
  "https://{space_name}.${SERVER_URL}/video",
  "Endpoint",
  {
    @doc(SERVER_URL_DESCRIPTION)
    @example("example")
    space_name: string = "{your_space_name}",
  }
)
@useAuth(SignalWireBasicAuth)
@doc("An API to programmatically create and control your own Video Applications.")
namespace VideoAPI;
