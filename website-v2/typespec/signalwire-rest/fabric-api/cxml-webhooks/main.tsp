import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "./models/errors.tsp";
import "./addresses";
import "../../types";
import "../tags.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/resources/cxml_webhooks")
namespace FabricAPI.CXMLWebhooks {
  @tag(CXML_WEBHOOK_TAG)
  @friendlyName("cXML Webhooks")
  interface CXMLWebhooks {
    @operationId("list_cxml_webhooks")
    @summary("List cXML Webhooks")
    @doc("""
      A list of cXML Webhooks
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list():
      | CXMLWebhookListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("get_cxml_webhook")
    @summary("Get cXML Webhook")
    @doc("""
      Returns an cXML Webhook by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    read(...CXMLWebhookID):
      | {
          @statusCode statusCode: 200;
          @body cxml_webhook: CXMLWebhookResponse;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("create_cxml_webhook")
    @summary("Create cXML Webhook")
    @doc("""
      Creates an cXML Webhook
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @post
    create(...CXMLWebhookCreateRequest):
      | {
          @statusCode statusCode: 201;
          @body cxml_webhook: CXMLWebhookResponse;
        }
      | StatusCode401
      | StatusCode404
      | CXMLWebhookCreateStatusCode422
      | StatusCode500;

    @operationId("update_cxml_webhook")
    @summary("Update cXML Webhook")
    @doc("""
      Updates an cXML Webhook by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @patch(#{ implicitOptionality: true })
    update(...CXMLWebhookID, ...CXMLWebhookUpdateRequest):
      | {
          @statusCode statusCode: 200;
          @body cxml_webhook: CXMLWebhookResponse;
        }
      | StatusCode401
      | StatusCode404
      | CXMLWebhookUpdateStatusCode422
      | StatusCode500;

    @operationId("delete_cxml_webhook")
    @summary("Delete cXML Webhook")
    @doc("""
      Deletes an cXML Webhook by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @delete
    delete(...CXMLWebhookID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
