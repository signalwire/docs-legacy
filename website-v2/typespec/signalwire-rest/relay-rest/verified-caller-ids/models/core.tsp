import "../../../types";

using TypeSpec.Http;
using Types;

model VerifiedCallerIDPathID {
  @doc("Unique ID of the verified caller ID.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

@doc("Verified caller ID model.")
model VerifiedCallerID {
  @doc("The type of the returned object, this should be verified_caller_id.")
  @example("verified_caller_id")
  type?: string;

  @doc("The unique identifier of the Verified Caller ID on SignalWire.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  id: uuid;

  @doc("String representing the phone number for the caller ID. This must be a valid, routeable phone number in E.164 format.")
  @example("+15551234567")
  number: string;

  @doc("String representing the name portion of the caller ID. If not provided, the default will be the formatted number that has been provided.")
  @example("C-3P0")
  name?: string;

  @doc("String representing the extension of the phone number for the caller ID. This is only used when placing the verification call.")
  @example("1234")
  extension?: string;

  @doc("A boolean representing whether the number has been verified or not.")
  @example(false)
  verified: boolean;

  @doc("Nullable DateTime field representing the date and time that the number was verified. If the number has not been verified, it will be null.")
  verified_at?: utcDateTime;

  @doc("The verification status for the caller ID.")
  @example("Awaiting Verification")
  status?: "Verified" | "Awaiting Verification";
}

@doc("Verification request model.")
model VerificationRequest {
  @doc("The verification code.")
  @example("123456")
  verification_code: string;
}
