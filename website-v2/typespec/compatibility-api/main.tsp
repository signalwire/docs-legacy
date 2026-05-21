import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";

import "../_shared/auth.tsp";
import "./tags.tsp";
import "./accounts/main.tsp";
import "./applications/main.tsp";
import "./available-phone-numbers/main.tsp";
import "./calls/main.tsp";
import "./conferences/main.tsp";
import "./faxes/main.tsp";
import "./incoming-phone-numbers/main.tsp";
import "./imported-phone-numbers/main.tsp";
import "./cxml-scripts/main.tsp";
import "./messages/main.tsp";
import "./recordings/main.tsp";
import "./transcriptions/main.tsp";
import "./queues/main.tsp";
import "./tokens/main.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@tagMetadata(ACCOUNTS_TAG, ACCOUNTS_TAG_METADATA)
@tagMetadata(APPLICATIONS_TAG, APPLICATIONS_TAG_METADATA)
@tagMetadata(AVAILABLE_PHONE_NUMBERS_TAG, AVAILABLE_PHONE_NUMBERS_TAG_METADATA)
@tagMetadata(CALLS_TAG, CALLS_TAG_METADATA)
@tagMetadata(STREAMS_TAG, STREAMS_TAG_METADATA)
@tagMetadata(CONFERENCES_TAG, CONFERENCES_TAG_METADATA)
@tagMetadata(CONFERENCE_PARTICIPANTS_TAG, CONFERENCE_PARTICIPANTS_TAG_METADATA)
@tagMetadata(CONFERENCE_RECORDINGS_TAG, CONFERENCE_RECORDINGS_TAG_METADATA)
@tagMetadata(CONFERENCE_STREAMS_TAG, CONFERENCE_STREAMS_TAG_METADATA)
@tagMetadata(CXML_SCRIPTS_TAG, CXML_SCRIPTS_TAG_METADATA)
@tagMetadata(FAXES_TAG, FAXES_TAG_METADATA)
@tagMetadata(FAX_MEDIA_TAG, FAX_MEDIA_TAG_METADATA)
@tagMetadata(INCOMING_PHONE_NUMBERS_TAG, INCOMING_PHONE_NUMBERS_TAG_METADATA)
@tagMetadata(IMPORTED_PHONE_NUMBERS_TAG, IMPORTED_PHONE_NUMBERS_TAG_METADATA)
@tagMetadata(MESSAGES_TAG, MESSAGES_TAG_METADATA)
@tagMetadata(MESSAGE_MEDIA_TAG, MESSAGE_MEDIA_TAG_METADATA)
@tagMetadata(QUEUES_TAG, QUEUES_TAG_METADATA)
@tagMetadata(QUEUE_MEMBERS_TAG, QUEUE_MEMBERS_TAG_METADATA)
@tagMetadata(RECORDINGS_TAG, RECORDINGS_TAG_METADATA)
@tagMetadata(TRANSCRIPTIONS_TAG, TRANSCRIPTIONS_TAG_METADATA)
@tagMetadata(TOKENS_TAG, TOKENS_TAG_METADATA)
@service(#{ title: "Compatibility API" })
@info(#{ version: "1.0.0" })
@server(
  "https://{space_name}.signalwire.com/api/laml/2010-04-01",
  "SignalWire Compatibility API",
  {
    @doc("Your SignalWire Space name")
    @example("YOUR_SPACE")
    space_name: string = "YOUR_SPACE",
  }
)
@useAuth(SignalWireBasicAuth)
namespace CompatibilityAPI;
