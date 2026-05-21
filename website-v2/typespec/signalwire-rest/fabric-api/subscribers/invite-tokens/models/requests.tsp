model SubscriberInviteTokenCreateRequest {
  @doc("Unique ID of a Subscriber Address")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  address_id: uuid;

  @doc("A unixtime (the number of seconds since 1970-01-01 00:00:00) at which the token should no longer be valid. Defaults to 'two hours from now'")
  @example(1725513600)
  expires_at?: integer;
}
