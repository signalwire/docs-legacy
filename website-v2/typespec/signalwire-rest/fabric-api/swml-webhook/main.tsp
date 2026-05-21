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

@route("/resources/swml_webhooks")
namespace FabricAPI.SWMLWebhooks {
  @tag(SWML_WEBHOOK_TAG)
  @friendlyName("SWML Webhooks")
  interface SWMLWebhooks {
    @operationId("list_swml_webhooks")
    @summary("List SWML Webhooks")
    @doc("""
      A list of SWML Webhooks
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list():
      | SWMLWebhookListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("get_swml_webhook")
    @summary("Get SWML Webhook")
    @doc("""
      Returns an SWML Webhook by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    read(...SWMLWebhookID):
      | {
          @statusCode statusCode: 200;
          @body swml_webhook: SWMLWebhookResponse;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("create_swml_webhook")
    @summary("Create SWML Webhook")
    @doc("""
      Creates an SWML Webhook
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @post
    create(...SWMLWebhookCreateRequest):
      | {
          @statusCode statusCode: 201;
          @body swml_webhook: SWMLWebhookResponse;
        }
      | StatusCode401
      | StatusCode404
      | SwmlWebhookCreateStatusCode422
      | StatusCode500;

    @operationId("update_swml_webhook")
    @summary("Update SWML Webhook")
    @doc("""
      Updates an SWML Webhook by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @patch(#{ implicitOptionality: true })
    update(...SWMLWebhookID, ...SWMLWebhookUpdateRequest):
      | {
          @statusCode statusCode: 200;
          @body swml_webhook: SWMLWebhookResponse;
        }
      | StatusCode401
      | StatusCode404
      | SwmlWebhookUpdateStatusCode422
      | StatusCode500;

    @operationId("delete_swml_webhook")
    @summary("Delete SWML Webhook")
    @doc("""
      Deletes an SWML Webhook by ID
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    @delete
    delete(...SWMLWebhookID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
