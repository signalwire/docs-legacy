import "@typespec/http";
import "@typespec/openapi";
import "./models/responses.tsp";
import "../../../types";
import "./models/core.tsp";
import "../../tags.tsp";
import "../../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

namespace FabricAPI.Subscribers.Addresses {
  @route("/{id}/addresses")
  @tag(SUBSCRIBERS_TAG)
  @friendlyName("Subscriber Addresses")
  @summary("Subscriber Addresses")
  interface SubscriberAddresses {
    @operationId("list_subscriber_addresses")
    @summary("List Subscriber Addresses")
    @doc("""
      List Subscriber Addresses
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list(...SubscriberAddressID):
      | SubscriberAddressesResponse[]
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
