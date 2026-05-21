import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "../_shared/errors.tsp";
import "../tags.tsp";
import "../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@route("/Accounts/{AccountSid}/IncomingPhoneNumbers")
namespace CompatibilityAPI.IncomingPhoneNumbers {
  @tag(INCOMING_PHONE_NUMBERS_TAG)
  @friendlyName("Incoming Phone Numbers")
  interface IncomingPhoneNumbers {
    @operationId("list_incoming_phone_numbers")
    @summary("List all Incoming Phone Numbers")
    @doc("""
      List all incoming phone numbers.
      
      ${tokenPermissions<"_Numbers_">}
      """)
    list(
      ...IncomingPhoneNumbersAccountSidPath,

      @query
      @doc("The page index to retrieve. Zero-indexed.")
      @minValue(0)
      @example(0)
      Page?: int32 = 0,

      @query
      @doc("The number of results per page. Default is 50, maximum is 1000.")
      @minValue(1)
      @maxValue(1000)
      @example(50)
      PageSize?: int32 = 50,

      @query
      @doc("Token for cursor-based pagination. Required when Page > 0.")
      @example("PAb3877c40da604998")
      PageToken?: string,

      @query
      @doc("Only show numbers that match this pattern.")
      @example("+1310")
      PhoneNumber?: string,

      @query
      @doc("Only show numbers with this friendly name.")
      @example("My Phone")
      FriendlyName?: string,
    ):
      | IncomingPhoneNumberListResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422;

    @operationId("create_incoming_phone_number")
    @summary("Create an Incoming Phone Number")
    @doc("""
      Purchase and provision a new incoming phone number.
      
      ${tokenPermissions<"_Numbers_">}
      """)
    @post
    create(
      ...IncomingPhoneNumbersAccountSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: CreateIncomingPhoneNumberRequest,
    ):
      | IncomingPhoneNumberCreatedResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422;

    @operationId("retrieve_incoming_phone_number")
    @summary("Retrieve an incoming phone number")
    @doc("""
      Retrieve an incoming phone number.
      
      ${tokenPermissions<"_Numbers_">}
      """)
    @route("/{Sid}")
    read(...IncomingPhoneNumbersAccountSidPath, ...IncomingPhoneNumberSidPath):
      | IncomingPhoneNumberResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404;

    @operationId("update_incoming_phone_number")
    @summary("Update an incoming phone number")
    @doc("""
      Update an incoming phone number.
      
      ${tokenPermissions<"_Numbers_">}
      """)
    @post
    @route("/{Sid}")
    update(
      ...IncomingPhoneNumbersAccountSidPath,
      ...IncomingPhoneNumberSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: UpdateIncomingPhoneNumberRequest,
    ):
      | IncomingPhoneNumberResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422;

    @operationId("delete_incoming_phone_number")
    @summary("Delete an incoming phone number")
    @doc("""
      Release an incoming phone number. The number will be removed from your account.
      
      Note: Numbers cannot be released within a cooldown period after purchase.
      
      ${tokenPermissions<"_Numbers_">}
      """)
    @delete
    @route("/{Sid}")
    delete(
      ...IncomingPhoneNumbersAccountSidPath,
      ...IncomingPhoneNumberSidPath,
    ):
      | CompatibilityStatusCode204
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode409
      | CompatibilityStatusCode422;
  }
}
