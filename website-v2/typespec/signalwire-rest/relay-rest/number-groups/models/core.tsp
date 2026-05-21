import "../../../types";

using TypeSpec.Http;
using Types;

model NumberGroupPathID {
  @doc("Unique ID of the number group.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

model NumberGroupIdPath {
  @doc("Unique ID of the number group.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  NumberGroupId: uuid;
}

model NumberGroupMembershipPathID {
  @doc("Unique ID of the number group membership.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

@doc("Number group model.")
model NumberGroup {
  @doc("The unique identifier of the Number Group on SignalWire. This can be used to update or delete the group programmatically.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  id: uuid;

  @doc("The name given to the number group. Helps to distinguish different groups within your project.")
  @example("My Number Group")
  name: string;

  @doc("Whether the number group uses the same 'From' number for outbound requests to a number, or chooses a random one.")
  @example(false)
  sticky_sender: boolean;

  @doc("The number of phone numbers within the group.")
  @example(4)
  phone_number_count: int32;
}

@doc("Phone number representation within a membership.")
model MembershipPhoneNumber {
  @doc("The unique identifier of the phone number.")
  @format("uuid")
  id?: uuid;

  @doc("The name given to the phone number.")
  @example("Jenny")
  name?: string;

  @doc("The phone number in E.164 format.")
  @example("+15558675309")
  number?: string;

  @doc("The capabilities of the phone number.")
  @example(#["voice", "sms", "mms", "fax"])
  capabilities?: string[];
}

@doc("Number group membership model.")
model NumberGroupMembership {
  @doc("The unique identifier of the Number Group Membership on SignalWire. This can be used to delete the membership programmatically.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  id: uuid;

  @doc("The unique identifier of the Number Group this membership is associated with.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  number_group_id: uuid;

  @doc("A representation of the phone number this membership is associated with.")
  phone_number: MembershipPhoneNumber;

  @doc("The date and time when the membership was created.")
  @example("2023-01-15T10:30:00Z")
  created_at: string;

  @doc("The date and time when the membership was last updated.")
  @example("2023-01-15T10:30:00Z")
  updated_at: string;
}
