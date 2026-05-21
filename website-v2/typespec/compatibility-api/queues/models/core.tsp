using TypeSpec.Http;

model QueuesAccountSidPath {
  @doc("The unique identifier for the account this Queue is associated with.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  @format("uuid")
  @path
  AccountSid: string;
}

model QueueSidPath {
  @doc("The unique identifier for the queue.")
  @example("b3877c40-da60-4998-90ad-b792e98472qu")
  @format("uuid")
  @path
  Sid: string;
}

model QueueSidPathForMembers {
  @doc("The unique identifier for the queue.")
  @example("b3877c40-da60-4998-90ad-b792e98472qu")
  @format("uuid")
  @path
  QueueSid: string;
}

model QueueMemberCallSidPath {
  @doc("The unique identifier for the call, or the special value 'Front' to reference the member at the front of the queue.")
  @example("b3877c40-da60-4998-90ad-b792e98472ca")
  @path
  CallSid: string;
}

@doc("Queue model.")
model Queue {
  @doc("The unique identifier for the queue.")
  @example("b3877c40-da60-4998-90ad-b792e98472qu")
  @format("uuid")
  sid: string;

  @doc("The unique identifier for the account this Queue is associated with.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  @format("uuid")
  account_sid: string;

  @doc("A description that distinguishes a queue.")
  @example("Queue1")
  friendly_name: string;

  @doc("The maximum number of calls that are allowed to wait in a queue. Null if no limit is set.")
  @example(100)
  max_size: int32 | null;

  @doc("The number of calls currently waiting in the queue.")
  @example(0)
  @minValue(0)
  current_size: int32;

  @doc("The average wait time, in seconds, of callers in a queue.")
  @example(0)
  @minValue(0)
  average_wait_time: int32;

  @doc("The date and time, in RFC 2822 format, the Queue was created.")
  @example("Wed, 26 Sep 2018 18:00:00 +0000")
  date_created: string;

  @doc("The date and time, in RFC 2822 format, the Queue was updated.")
  @example("Thu, 27 Sep 2018 19:00:00 +0000")
  date_updated: string;

  @doc("The version of the SignalWire API.")
  @example("2010-04-01")
  api_version: string;

  @doc("The URI of this resource, relative to the API base URL.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Queues/b3877c40-da60-4998-90ad-b792e98472qu.json")
  uri: string;
}

@doc("Queue member model representing a call waiting in a queue.")
model QueueMember {
  @doc("The unique identifier for the call.")
  @example("b3877c40-da60-4998-90ad-b792e98472ca")
  @format("uuid")
  call_sid: string;

  @doc("The unique identifier for the account.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  @format("uuid")
  account_sid: string;

  @doc("The unique identifier for the queue.")
  @example("b3877c40-da60-4998-90ad-b792e98472qu")
  @format("uuid")
  queue_sid: string;

  @doc("The date and time, in RFC 2822 format, when the member was enqueued.")
  @example("Wed, 26 Sep 2018 18:00:00 +0000")
  date_enqueued: string;

  @doc("The position of the member in the queue (1-indexed).")
  @example(1)
  @minValue(1)
  position: int32;

  @doc("The wait time, in seconds, since the member was enqueued.")
  @example(30)
  @minValue(0)
  wait_time: int32;

  @doc("The type of the queue member.")
  @example("laml_call")
  member_type: string;

  @doc("The URI of this resource, relative to the API base URL.")
  @example("/api/laml/2010-04-01/Accounts/b3877c40-da60-4998-90ad-b792e98472af/Queues/b3877c40-da60-4998-90ad-b792e98472qu/Members/b3877c40-da60-4998-90ad-b792e98472ca.json")
  uri: string;
}
