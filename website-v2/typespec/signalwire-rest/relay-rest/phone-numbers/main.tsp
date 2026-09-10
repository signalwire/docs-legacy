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

@route("/phone_numbers")
namespace RelayRestAPI.PhoneNumbers {
  @tag(PHONE_NUMBERS_TAG)
  @friendlyName("Phone Numbers")
  interface PhoneNumbers {
    @operationId("list_phone_numbers")
    @summary("List all Phone Numbers")
    @doc("""
      Returns a list of your Phone Numbers. The phone numbers are returned
      sorted by creation date, with the most recent phone numbers appearing
      first. The list is filterable by sending in any of the following
      parameters.
      
      ${tokenPermissions<"_Numbers_">}
      """)
    list(...ListPhoneNumbersQuery):
      | PhoneNumberListResponse
      | StatusCode400
      | StatusCode401
      | StatusCode500;

    @operationId("purchase_phone_number")
    @summary("Purchase a Phone Number")
    @doc("""
      Purchases a phone number.
      
      ${tokenPermissions<"_Numbers_">}
      """)
    @post
    create(@body body: PurchasePhoneNumberRequest):
      | {
          @statusCode statusCode: 200;
          @body phone_number: PhoneNumberResponse;
        }
      | StatusCode400
      | StatusCode401
      | ValidationError
      | StatusCode500;

    @operationId("retrieve_phone_number")
    @summary("Retrieve a Phone Number")
    @doc("""
      Retrieves the details of a phone number.
      
      ${tokenPermissions<"_Numbers_">}
      """)
    read(...PhoneNumberPathID):
      | PhoneNumberResponse
      | StatusCode401
      | StatusCode404
      | ValidationError
      | StatusCode500;

    @operationId("update_phone_number")
    @summary("Update a Phone Number")
    @doc("""
      Updates a phone number.
      
      ${tokenPermissions<"_Numbers_">}
      """)
    @put
    update(...PhoneNumberPathID, @body body: UpdatePhoneNumberRequest):
      | {
          @statusCode statusCode: 200;
          @body phone_number: PhoneNumberResponse;
        }
      | StatusCode401
      | StatusCode404
      | ValidationError
      | StatusCode500;

    @operationId("release_phone_number")
    @summary("Release a Phone Number")
    @doc("""
      Releases a phone number.
      
      ${tokenPermissions<"_Numbers_">}
      """)
    @delete
    delete(...PhoneNumberPathID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode401
      | StatusCode404
      | ValidationError
      | StatusCode500;

    @operationId("search_available_phone_numbers")
    @summary("Search for available Phone Numbers to Purchase")
    @doc("""
      Searches for available phone numbers to purchase.
      
      ${tokenPermissions<"_Numbers_">}
      """)
    @route("/search")
    @get
    search(
      @query
      @doc("An areacode to search within.")
      areacode?: string,

      @query
      @doc("Search for either local or toll-free numbers. Defaults to local.")
      number_type?: string,

      @query
      @doc("A string of 3 to 7 digits that should be used as the start of a number. Cannot be used in combination with contains or ends_with.")
      starts_with?: string,

      @query
      @doc("A string of 3 to 7 digits that should appear somewhere in the number. Cannot be used in combination with starts_with or ends_with.")
      contains?: string,

      @query
      @doc("A string of 3 to 7 digits that should be used as the end of a number. Cannot be used in combination with starts_with or contains.")
      ends_with?: string,

      @query
      @doc("The maximum number of matches to return. Upper limit of 100. Defaults to 50.")
      max_results?: int32,

      @query
      @doc("A region or state to search within. Must be an ISO 3166-2 alpha-2 code, i.e. TX for Texas. Cannot be used in combination with areacode.")
      region?: string,

      @query
      @doc("A specific City to search within. Must be used in combination with region. Cannot be used in combination with areacode, starts_with, contains, or ends_with.")
      city?: string,
    ): AvailablePhoneNumbersResponse | StatusCode401 | StatusCode500;
  }
}

@route("/imported_phone_numbers")
namespace RelayRestAPI.ImportedPhoneNumbers {
  @tag(IMPORTED_PHONE_NUMBERS_TAG)
  @friendlyName("Imported Phone Numbers")
  interface ImportedPhoneNumbers {
    @operationId("create_imported_phone_number")
    @summary("Import a Phone Number")
    @doc("""
      Import a phone number hosted elsewhere into your SignalWire Space.
      
      **Note:** This is a **Partner API**. To enable it on your SignalWire Space, contact [Sales](https://signalwire.com/company/contact?utm_campaign=devex_sent_em).
      
      ${tokenPermissions<"_Numbers_">}
      """)
    @post
    create(@body body: ImportPhoneNumberRequest):
      | {
          @statusCode statusCode: 201;
          @body phone_number: PhoneNumberResponse;
        }
      | StatusCode401
      | ValidationError
      | StatusCode500;
  }
}

@route("/lookup/phone_number")
namespace RelayRestAPI.PhoneNumberLookup {
  @tag(PHONE_NUMBER_LOOKUP_TAG)
  @friendlyName("Phone Number Lookup")
  interface PhoneNumberLookup {
    @operationId("lookup_phone_number")
    @summary("Phone Number Lookup")
    @doc("""
      This endpoint allows you to look up validity and formatting
      information about a number. You can optionally lookup additional
      information about the number such as carrier and caller ID data.
      
      #### Permissions
      
      No API token scope is required to make a successful request to this endpoint.
      
      [Learn more about API scopes](/docs/platform/your-signalwire-api-space).
      """)
    @route("/{e164_number}")
    @get
    lookup(
      ...E164NumberPath,

      @query
      @doc("Further number information to include in the response, some of which are billable. You can specify: carrier (Lookup full carrier information for the number), cnam (Lookup Caller ID information for the number). Separate multiple values with a comma: include=carrier,cnam.")
      include?: string,
    ):
      | PhoneNumberLookupResponse
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
