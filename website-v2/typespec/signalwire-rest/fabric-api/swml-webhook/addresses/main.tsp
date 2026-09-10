import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/responses.tsp";
import "../../../types";
import "../../tags.tsp";
import "../../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/resources/swml_webhooks/{swml_webhook_id}/addresses")
namespace FabricAPI.SWMLWebhookAddresses {
  @tag(SWML_WEBHOOK_TAG)
  @friendlyName("SWML Webhooks")
  interface SWMLWebhookAddresses {
    @operationId("list_swml_webhook_addresses")
    @summary("List SWML Webhook Addresses")
    @doc("""
      This endpoint returns a list of addresses associated with a specific SWML webhook.
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list(...SWMLWebhookIDPath):
      | SWMLWebhookAddressListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
