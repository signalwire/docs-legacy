import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/responses.tsp";
import "../_shared/errors.tsp";
import "../tags.tsp";
import "../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@route("/Accounts/{AccountSid}/AvailablePhoneNumbers")
namespace CompatibilityAPI.AvailablePhoneNumbers {
  @tag(AVAILABLE_PHONE_NUMBERS_TAG)
  @friendlyName("Available Phone Numbers")
  interface AvailablePhoneNumbers {
    @operationId("list_available_phone_number_resources")
    @summary("List of AvailablePhoneNumber resources")
    @doc("""
      Returns a list of URIs to phone number resources available to the account, categorized by type (Local, Toll-Free, Mobile, etc) and ISO country.
      
      ${tokenPermissions<"_Numbers_">}
      """)
    list(
      ...AvailablePhoneNumbersAccountSidPath,
    ): AvailablePhoneNumberResourcesResponse | CompatibilityStatusCode400 | CompatibilityStatusCode401;

    @operationId("list_available_phone_number_resources_by_country")
    @summary("List of AvailablePhoneNumber resources by country")
    @doc("""
      Returns a list of URIs to phone number resources available to the account in the specified ISO country, categorized by type (Local, Toll-Free, Mobile, etc).
      
      ${tokenPermissions<"_Numbers_">}
      """)
    @route("/{IsoCountry}")
    listByCountry(
      ...AvailablePhoneNumbersAccountSidPath,
      ...IsoCountryPath,
    ): AvailablePhoneNumberByCountryResponse | CompatibilityStatusCode400 | CompatibilityStatusCode401;

    @operationId("search_local_available_phone_numbers")
    @summary("Search for available phone numbers that match your criteria.")
    @doc("""
      Search for Local AvailablePhoneNumbers.
      
      ${tokenPermissions<"_Numbers_">}
      """)
    @route("/{IsoCountry}/Local")
    searchLocal(
      ...AvailablePhoneNumbersAccountSidPath,
      ...IsoCountryPath,

      @query
      @doc("Find numbers in the provided area code. Only available for numbers in US and Canada.")
      @example("213")
      AreaCode?: string,

      @query
      @doc("New numbers on SignalWire are marked as `beta`.")
      @example(false)
      Beta?: boolean,

      @query
      @doc("Find numbers based off of a pattern. Valid characters are `[0-9a-zA-Z]`.")
      @example("555")
      Contains?: string,

      @query
      @doc("Accepted for Twilio compatibility but has no effect on the response.")
      @example(false)
      ExcludeAllAddressRequired?: boolean,

      @query
      @doc("Accepted for Twilio compatibility but has no effect on the response.")
      @example(false)
      ExcludeForeignAddressRequired?: boolean,

      @query
      @doc("Accepted for Twilio compatibility but has no effect on the response.")
      @example(false)
      ExcludeLocalAddressRequired?: boolean,

      @query
      @doc("Not supported. Accepted for Twilio API compatibility.")
      @example(true)
      FaxEnabled?: boolean,

      @query
      @doc("Limits search to a city/locality. Requires InRegion to also be set.")
      @example("Seattle")
      InLocality?: string,

      @query
      @doc("Limits search to same region as number. Must be a two-letter state/province code.")
      @example("WA")
      InRegion?: string,

      @query
      @doc("Not supported. Accepted for Twilio API compatibility.")
      @example(true)
      MmsEnabled?: boolean,

      @query
      @doc("Not supported. Accepted for Twilio API compatibility.")
      @example(true)
      SmsEnabled?: boolean,

      @query
      @doc("Not supported. Accepted for Twilio API compatibility.")
      @example(true)
      VoiceEnabled?: boolean,
    ):
      | AvailablePhoneNumberListResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422;

    @operationId("search_toll_free_available_phone_numbers")
    @summary("Find toll-free numbers")
    @doc("""
      Search for toll-free AvailablePhoneNumbers.
      
      ${tokenPermissions<"_Numbers_">}
      """)
    @route("/{IsoCountry}/TollFree")
    searchTollFree(
      ...AvailablePhoneNumbersAccountSidPath,
      ...IsoCountryPath,

      @query
      @doc("Find numbers in the provided area code. Only available for numbers in US and Canada.")
      @example("213")
      AreaCode?: string,

      @query
      @doc("New numbers on SignalWire are marked as `beta`.")
      @example(false)
      Beta?: boolean,

      @query
      @doc("Find numbers based off of a pattern. Valid characters are `[0-9a-zA-Z]`.")
      @example("555")
      Contains?: string,

      @query
      @doc("Accepted for Twilio compatibility but has no effect on the response.")
      @example(false)
      ExcludeAllAddressRequired?: boolean,

      @query
      @doc("Accepted for Twilio compatibility but has no effect on the response.")
      @example(false)
      ExcludeForeignAddressRequired?: boolean,

      @query
      @doc("Accepted for Twilio compatibility but has no effect on the response.")
      @example(false)
      ExcludeLocalAddressRequired?: boolean,

      @query
      @doc("Not supported. Accepted for Twilio API compatibility.")
      @example(true)
      FaxEnabled?: boolean,

      @query
      @doc("Limits search to a city/locality. Requires InRegion to also be set.")
      @example("Seattle")
      InLocality?: string,

      @query
      @doc("Limits search to same region as number. Must be a two-letter state/province code.")
      @example("WA")
      InRegion?: string,

      @query
      @doc("Not supported. Accepted for Twilio API compatibility.")
      @example(true)
      MmsEnabled?: boolean,

      @query
      @doc("Not supported. Accepted for Twilio API compatibility.")
      @example(true)
      SmsEnabled?: boolean,

      @query
      @doc("Not supported. Accepted for Twilio API compatibility.")
      @example(true)
      VoiceEnabled?: boolean,
    ):
      | AvailablePhoneNumberListResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422;
  }
}
