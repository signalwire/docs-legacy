import "./core.tsp";

using TypeSpec.Http;

@doc("Request body for creating an address.")
model CreateAddressRequest {
  @doc("A friendly name given to the address to help distinguish and search for different addresses within your project.")
  @example("My Address")
  @maxLength(250)
  label: string;

  @doc("The ISO 3166 Alpha 2 country code.")
  @example("US")
  country: string;

  @doc("First name of the occupant associated with this address.")
  @example("Emmett")
  @maxLength(250)
  first_name: string;

  @doc("Last name of the occupant associated with this address.")
  @example("Brown")
  @maxLength(250)
  last_name: string;

  @doc("The number portion of the street address.")
  @example("1640")
  @maxLength(250)
  street_number: string;

  @doc("The name portion of the street address.")
  @example("Riverside Drive")
  @maxLength(250)
  street_name: string;

  @doc("If the address is divided into multiple sub-addresses, this identifies how the address is divided. Possible values are: Apartment, Basement, Building, Department, Floor, Office, Penthouse, Suite, Trailer, Unit.")
  @example(AddressType.Apartment)
  address_type?: AddressType;

  @doc("If the address is divided into multiple sub-addresses, this identifies the particular sub-address.")
  @example("42")
  address_number?: string;

  @doc("The city portion of the street address.")
  @example("Alexandria")
  @maxLength(250)
  city: string;

  @doc("The state/province/region of the street address. In the USA and Canada, use the two-letter abbreviated form.")
  @example("CA")
  state: string;

  @doc("The postal code of the street address.")
  @example("91905")
  @maxLength(250)
  postal_code: string;
}
