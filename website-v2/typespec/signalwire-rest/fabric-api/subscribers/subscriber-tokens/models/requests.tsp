import "../../../../types";

model SubscriberTokenRequest {
  @doc("A string that uniquely identifies the subscriber. Often it's an email, but can be any other string.")
  @example("john.doe@example.com")
  reference: string;

  @doc("A unixtime (the number of seconds since 1970-01-01 00:00:00) at which the token should no longer be valid. Defaults to 'two hours from now'")
  @example(1693823284)
  expire_at?: integer;

  @doc("The ID of the application that the token is associated with.")
  @example("123e4567-e89b-12d3-a456-426614174000")
  @format("uuid")
  application_id?: uuid;

  @doc("Set or update the subscriber's password. Omit this field or pass an empty string if you don't want to update the password.")
  @example("password123")
  password?: string;

  @doc("Set or update the first name of the subscriber.")
  @example("John")
  first_name?: string;

  @doc("Set or update the last name of the subscriber.")
  @example("Doe")
  last_name?: string;

  @doc("Set or update the display name of the subscriber.")
  @example("John Doe")
  display_name?: string;

  @doc("Set or update the job title of the subscriber.")
  @example("Software Engineer")
  job_title?: string;

  @doc("Set or update the time zone of the subscriber.")
  @example("America/New_York")
  time_zone?: string;

  @doc("Set or update the country of the subscriber.")
  @example("US")
  country?: string;

  @doc("Set or update the region of the subscriber.")
  @example("CA")
  region?: string;

  @doc("Set or update the company name of the subscriber.")
  @example("SignalWire")
  company_name?: string;
}
