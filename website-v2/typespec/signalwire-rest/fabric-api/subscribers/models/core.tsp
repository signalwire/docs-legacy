import "../../../types";

using TypeSpec.Http;
using Types;

model SubscriberPathID {
  @doc("Unique ID of a Subscriber.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

model Subscriber {
  @doc("Unique ID of the Subscriber.")
  @example("d369a402-7b43-4512-8735-9d5e1f387814")
  @format("uuid")
  id: uuid;

  @doc("Email of the Subscriber.")
  @example("johndoe@example.com")
  email: string;

  @doc("First name of the Subscriber.")
  @example("John")
  first_name: string;

  @doc("Last name of the Subscriber.")
  @example("Doe")
  last_name: string;

  @doc("Display name of the Subscriber.")
  @example("John Doe")
  display_name: string;

  @doc("Job title of the Subscriber.")
  @example("Software Engineer")
  job_title: string;

  @doc("Timezone of the Subscriber.")
  @example("America/New_York")
  timezone: string;

  @doc("Country of the Subscriber.")
  @example("United States")
  country: string;

  @doc("Region of the Subscriber.")
  @example("New York")
  region: string;

  @doc("Company name of the Subscriber.")
  @example("SignalWire")
  company_name: string;
}
