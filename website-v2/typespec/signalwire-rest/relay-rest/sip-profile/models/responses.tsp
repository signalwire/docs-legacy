import "./core.tsp";

using TypeSpec.Http;

@doc("Response containing the SIP profile.")
model SipProfileResponse {
  ...SipProfile;
}
