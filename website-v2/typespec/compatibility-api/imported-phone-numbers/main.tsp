import "@typespec/http";
import "@typespec/openapi";
import "./models/requests.tsp";
import "../incoming-phone-numbers/models/core.tsp";
import "../_shared/errors.tsp";
import "../tags.tsp";
import "../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@route("/Accounts/{AccountSid}/ImportedPhoneNumbers")
namespace CompatibilityAPI.ImportedPhoneNumbers {
  @tag(IMPORTED_PHONE_NUMBERS_TAG)
  @friendlyName("Imported Phone Numbers")
  interface ImportedPhoneNumbers {
    @operationId("create_imported_phone_number")
    @summary("Import a Phone Number")
    @doc("""
      Import a phone number you already own to your SignalWire Space to use with SignalWire APIs.
      
      **Note:** This is a **Partner API**. To enable it on your SignalWire Space, contact
      [Sales](https://signalwire.com/company/contact?utm_campaign=devex_sent_em).
      
      ${tokenPermissions<"_Numbers_">}
      """)
    @post
    create(
      ...ImportedPhoneNumbersAccountSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: ImportPhoneNumberRequest,
    ):
      | {
          @statusCode statusCode: 201;
          @body body: IncomingPhoneNumber;
        }
      | CompatibilityStatusCode401
      | CompatibilityStatusCode400
      | CompatibilityStatusCode422ImportedPhoneNumber;
  }
}
