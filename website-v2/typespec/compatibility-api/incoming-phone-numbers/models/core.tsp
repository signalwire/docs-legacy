using TypeSpec.Http;

model IncomingPhoneNumbersAccountSidPath {
  @doc("The unique identifier for the account that is associated with this phone number.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  @format("uuid")
  @path
  AccountSid: string;
}

model IncomingPhoneNumberSidPath {
  @doc("The unique identifier of the phone number.")
  @example("b3877c40-da60-4998-90ad-b792e98472pn")
  @format("uuid")
  @path
  Sid: string;
}

@doc("Address requirements.")
enum AddressRequirements {
  None: "none",
  Any: "any",
  Local: "local",
  Foreign: "foreign",
}

@doc("Emergency status.")
enum EmergencyStatus {
  Active: "Active",
  Inactive: "Inactive",
}

@doc("Phone number origin.")
enum PhoneNumberOrigin {
  SignalWire: "signalwire",
  Hosted: "hosted",
}

@doc("Phone number capabilities.")
model IncomingPhoneNumberCapabilities {
  @doc("Whether or not voice is enabled.")
  @example(true)
  voice: boolean;

  @doc("Whether or not SMS is enabled.")
  @example(true)
  sms: boolean;

  @doc("Whether or not MMS is enabled.")
  @example(true)
  mms: boolean;

  @doc("Whether or not fax is enabled.")
  @example(true)
  fax: boolean;
}

@doc("Incoming phone number model.")
model IncomingPhoneNumber {
  @doc("The unique identifier for the account that is associated with this phone number.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472ac")
  account_id: string;

  @doc("The unique identifier for the account that is associated with this phone number.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472ac")
  account_sid: string;

  @doc("Whether or not a registered address with SignalWire is required. Always 'none'.")
  address_requirements: AddressRequirements;

  @doc("The unique identifier for the address associated with this phone number. Always null.")
  @example(null)
  address_sid: string | null;

  @doc("The version of the SignalWire API.")
  @example("2010-04-01")
  api_version: string;

  @doc("New numbers on SignalWire are marked as beta. Always false.")
  @example(false)
  beta: boolean;

  @doc("Whether or not a number can receive calls and messages.")
  capabilities: IncomingPhoneNumberCapabilities;

  @doc("The ISO 3166-1 alpha-2 country code for this phone number.")
  @example("US")
  country_code: string;

  @doc("The date, in RFC 2822 format, this phone number was created.")
  @example("Tue, 25 Sept 2018 23:00:00 +0000")
  date_created: string;

  @doc("The date, in RFC 2822 format, this phone number was updated.")
  @example("Wed, 26 Sept 2018 22:00:00 +0000")
  date_updated: string;

  @doc("The unique identifier of the address associated with E911 for this phone number, or null if not set.")
  @example(null)
  emergency_address_sid: string | null;

  @doc("Whether the phone route has an active E911 address associated. 'Active' or 'Inactive'.")
  @example("Inactive")
  emergency_status: string;

  @doc("A formatted version of the number.")
  @example("(310) 338-6745")
  friendly_name: string;

  @doc("The unique identifier for the identity associated with this phone number. Always null.")
  @example(null)
  identity_sid: string | null;

  @doc("The origin of the phone number.")
  origin: PhoneNumberOrigin;

  @doc("The incoming number in E.164 format.")
  @example("+13103386745")
  phone_number: string;

  @doc("The unique identifier for this phone number.")
  @example("b3877c40-da60-4998-90ad-b792e98472pn")
  sid: string;

  @doc("The unique identifier for the application associated with SMS handling on this phone number, or null if not set.")
  @example(null)
  sms_application_sid: string | null;

  @doc("Whether the request to `SmsFallbackUrl` is a `GET` or a `POST`.")
  @example("POST")
  sms_fallback_method: string;

  @doc("The URL to request if errors occur when fetching SmsUrl, or null if not set.")
  @example(null)
  sms_fallback_url: string | null;

  @doc("Whether the request to SmsUrl is a `GET` or a `POST`.")
  @example("POST")
  sms_method: string;

  @doc("The URL to request when an incoming SMS is received, or null if not set.")
  @example(null)
  sms_url: string | null;

  @doc("The URL to request to pass status updates to, or null if not set.")
  @example(null)
  status_callback: string | null;

  @doc("Whether the request to StatusCallback is a `GET` or a `POST`.")
  @example("POST")
  status_callback_method: string;

  @doc("The unique identifier for the Trunk associated with this phone number. Always null.")
  @example(null)
  trunk_sid: string | null;

  @doc("The URI for this number.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472ac/IncomingPhoneNumbers/b3877c40-da60-4998-90ad-b792e98472pn.json")
  uri: string;

  @doc("The verification status for toll-free numbers. Only present for toll-free numbers.")
  @example("Unverified")
  verification_status?: string;

  @doc("The unique identifier for the application associated with call handling on this phone number, or null if not set.")
  @example(null)
  voice_application_sid: string | null;

  @doc("Whether or not to look up a caller's name in the database. Always null.")
  @example(null)
  voice_caller_id_lookup: boolean | null;

  @doc("Whether the request to VoiceFallbackUrl is a `GET` or a `POST`.")
  @example("POST")
  voice_fallback_method: string;

  @doc("The URL to request if errors occur when fetching `Url`, or null if not set.")
  @example(null)
  voice_fallback_url: string | null;

  @doc("Whether the request to Url is a `GET` or a `POST`.")
  @example("POST")
  voice_method: string;

  @doc("The URL to request when an incoming call is received, or null if not set.")
  @example(null)
  voice_url: string | null;
}
