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

@route("/resources/cxml_webhooks/{cxml_webhook_id}/addresses")
namespace FabricAPI.CXMLWebhook.Addresses {
  @tag(CXML_WEBHOOK_TAG)
  @friendlyName("cXML Webhooks")
  interface CXMLWebhookAddresses {
    @operationId("list_cxml_webhook_addresses")
    @summary("List cXML Webhook Addresses")
    @doc("""
      This endpoint returns a list of addresses associated with a specific cXML Webhook.
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list(...CXMLWebhookIDPath):
      | CXMLWebhookAddressListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
