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

@route("/resources/freeswitch_connectors/{id}/addresses")
namespace FabricAPI.FreeswitchConnectorAddresses {
  @tag(FREESWITCH_CONNECTOR_TAG)
  interface FreeswitchConnectorAddresses {
    @operationId("list_freeswitch_connector_addresses")
    @summary("List FreeSWITCH Connector Addresses")
    @doc("""
      This endpoint returns a list of addresses associated with a specific FreeSWITCH Connector.
      
      ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
      """)
    list(...FreeswitchConnectorAddressPathID):
      | FreeswitchConnectorAddressListResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
