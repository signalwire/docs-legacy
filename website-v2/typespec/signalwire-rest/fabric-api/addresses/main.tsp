import "@typespec/http";
import "@typespec/openapi";
import "../_shared/fabric-address";
import "../../types";
import "../../../_shared/auth.tsp";
import "../tags.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@useAuth(SignalWireBearerAuth)
@route("/addresses")
namespace FabricAPI.FabricAddresses {
  @tag(FABRIC_ADDRESS_TAG)
  @friendlyName("Fabric Address")
  interface FabricAddresses {
    @operationId("list_fabric_addresses")
    @summary("List Fabric Addresses")
    @doc("""
      A list of Fabric Addresses. This endpoint uses the bearer token authentication method with the SAT (Subscriber Access Token) which can be
      generated using the [Create Subscriber Token endpoint](/apis/rest/fabric/subscribers/create-subscriber-token).
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list():
      | FabricAddressesResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("get_fabric_address")
    @summary("Get Fabric Address")
    @doc("""
      Returns a Fabric Address by ID. This endpoint uses the bearer token authentication method with the SAT (Subscriber Access Token) which can be
      generated using the [Create Subscriber Token endpoint](/apis/rest/fabric/subscribers/create-subscriber-token).
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    read(...FabricAddressID):
      | {
          @statusCode statusCode: 200;
          @body fabric_address: FabricAddress;
        }
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
