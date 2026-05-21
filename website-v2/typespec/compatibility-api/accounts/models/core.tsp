using TypeSpec.Http;

model AccountPathSid {
  @doc("The Project ID that uniquely identifies the Project to retrieve.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  @format("uuid")
  @path
  Sid: string;
}

@doc("The status of the Project.")
enum AccountStatus {
  Active: "active",
}

@doc("The type of the Project.")
enum AccountType {
  Full: "Full",
}

@doc("A Map of sub-resources that are linked to the given Project.")
model SubresourceUris {
  @doc("URI for addresses. Not supported.")
  @example(null)
  addresses: null;

  @doc("URI for available phone numbers.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/AvailablePhoneNumbers")
  available_phone_numbers: string;

  @doc("URI for applications.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Applications")
  applications: string;

  @doc("URI for authorized connect apps. Not supported.")
  @example(null)
  authorized_connect_apps: null;

  @doc("URI for calls.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Calls")
  calls: string;

  @doc("URI for conferences.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Conferences")
  conferences: string;

  @doc("URI for connect apps. Not supported.")
  @example(null)
  connect_apps: null;

  @doc("URI for incoming phone numbers.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/IncomingPhoneNumbers")
  incoming_phone_numbers: string;

  @doc("URI for keys. Not supported.")
  @example(null)
  keys: null;

  @doc("URI for notifications. Not supported.")
  @example(null)
  notifications: null;

  @doc("URI for outgoing caller IDs. Not supported.")
  @example(null)
  outgoing_caller_ids: null;

  @doc("URI for queues.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Queues")
  queues: string;

  @doc("URI for recordings.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Recordings")
  recordings: string;

  @doc("URI for sandbox. Not supported.")
  @example(null)
  sandbox: null;

  @doc("URI for SIP. Not supported.")
  @example(null)
  sip: null;

  @doc("URI for short codes. Not supported.")
  @example(null)
  short_codes: null;

  @doc("URI for messages.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Messages")
  messages: string;

  @doc("URI for transcriptions.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Transcriptions")
  transcriptions: string;

  @doc("URI for usage. Not supported.")
  @example(null)
  usage: null;
}

@doc("Account/Project model representing a SignalWire project.")
model Account {
  @doc("The unique identifier for this Project.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  sid: string;

  @doc("The name of the Project.")
  @example("My Project")
  friendly_name: string;

  @doc("The status of the Project. Always 'active'.")
  status: AccountStatus;

  @doc("The authorization token for this Project. Always returns 'redacted' for security.")
  @example("redacted")
  auth_token: string;

  @doc("The date and time this Project was created, in RFC 2822 format.")
  @example("Sat, 15 Sep 2018 10:00:00 +0000")
  date_created: string;

  @doc("The date and time this Project was last updated, in RFC 2822 format.")
  @example("Sat, 16 Sep 2018 10:00:00 +0000")
  date_updated: string;

  @doc("The type of the Project. Always 'Full'.")
  type: AccountType;

  @doc("The Project ID of the parent project. For parent projects, this is the same as sid.")
  @format("uuid")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  owner_account_sid: string;

  @doc("The preferred region for the Project.")
  @example("us-east")
  region_preference: string;

  @doc("The URI for the Project.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af")
  uri: string;

  @doc("Whether this project is a sub-project of another project.")
  @example(false)
  subproject: boolean;

  @doc("The signing key for the Project. Only returned once when a subproject is created. Subsequent requests return null.")
  @example(null)
  signing_key: string | null;

  @doc("A map of URIs for sub-resources linked to this Project.")
  subresource_uris: SubresourceUris;
}
