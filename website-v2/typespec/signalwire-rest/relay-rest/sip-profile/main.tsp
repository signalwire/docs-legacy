import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "../../types";
import "../tags.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/sip_profile")
namespace RelayRestAPI.SipProfile {
  @tag(SIP_PROFILE_TAG)
  @friendlyName("SIP Profile")
  interface SipProfile {
    @operationId("retrieve_sip_profile")
    @summary("Retrieve a SIP Profile")
    @doc("""
      Retrieves the SIP profile settings for your project.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @get
    read(): SipProfileResponse | StatusCode401 | StatusCode500;

    @operationId("update_sip_profile")
    @summary("Update a SIP Profile")
    @doc("""
      Updates the SIP profile settings for your project.
      
      ${tokenPermissions<"_Voice_">}
      """)
    @put
    update(@body body: UpdateSipProfileRequest):
      | {
          @statusCode statusCode: 201;
          @body sip_profile: SipProfileResponse;
        }
      | StatusCode401
      | ValidationError
      | StatusCode500;
  }
}
