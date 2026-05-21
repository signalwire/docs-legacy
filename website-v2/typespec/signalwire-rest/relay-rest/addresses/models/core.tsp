import "../../../types";

using TypeSpec.Http;
using Types;

model AddressPathID {
  @doc("Unique ID of the address.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

@doc("Address type for sub-addresses.")
enum AddressType {
  Apartment: "Apartment",
  Basement: "Basement",
  Building: "Building",
  Department: "Department",
  Floor: "Floor",
  Office: "Office",
  Penthouse: "Penthouse",
  Suite: "Suite",
  Trailer: "Trailer",
  Unit: "Unit",
}

@doc("Address model representing a physical address for regulatory compliance.")
model Address {
  @doc("The unique identifier of the Address on SignalWire.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  id: uuid;

  @doc("A friendly name given to the address to help distinguish and search for different addresses within your project.")
  @example("My Address")
  label: string;

  @doc("The ISO 3166 Alpha 2 country code.")
  @example("US")
  country: string;

  @doc("First name of the occupant associated with this address.")
  @example("Emmett")
  first_name: string;

  @doc("Last name of the occupant associated with this address.")
  @example("Brown")
  last_name: string;

  @doc("The number portion of the street address.")
  @example("1640")
  street_number: string;

  @doc("The name portion of the street address.")
  @example("Riverside Drive")
  street_name: string;

  @doc("If the address is divided into multiple sub-addresses, this identifies how the address is divided.")
  @example(AddressType.Apartment)
  address_type: AddressType | null;

  @doc("If the address is divided into multiple sub-addresses, this identifies the particular sub-address.")
  @example("42")
  address_number: string | null;

  @doc("The city portion of the street address.")
  @example("Alexandria")
  city: string;

  @doc("The state/province/region of the street address. In the USA and Canada, use the two-letter abbreviated form.")
  @example("CA")
  state: string;

  @doc("The postal code of the street address.")
  @example("91905")
  postal_code: string;

  @doc("The postal code of the street address. Alias for postal_code for backwards compatibility.")
  @example("91905")
  zip_code: string;
}
