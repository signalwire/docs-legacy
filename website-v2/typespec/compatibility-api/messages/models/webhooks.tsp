import "../../../_shared/webhook/decorator.tsp";

@summary("SMS status callback")
@doc("""
  Payload sent by SignalWire to your SMS Status Callback URL when the status of an SMS/MMS message changes.

  Configure this callback using the `StatusCallback` parameter when
  [sending an outgoing message](/compatibility-api/rest/create-message).

  There are 8 possible message statuses:

  | Status | Description |
  |--------|-------------|
  | `queued` | The API request was processed and the message is waiting to be sent. |
  | `sending` | The message is being transmitted to the nearest upstream carrier. |
  | `sent` | The nearest upstream carrier has accepted the message. |
  | `delivered` | The nearest upstream carrier confirmed receipt of the message. |
  | `undelivered` | SignalWire received notice from the upstream carrier that the message was not delivered. |
  | `failed` | SignalWire could not send the message. There is no charge for failed messages. |
  | `receiving` | SignalWire has received and is currently processing an inbound message. |
  | `received` | The inbound message has been received by a number in your account. |

  <Note>
  SignalWire only marks a message as `delivered` when it receives a Delivery Receipt (DLR)
  from the receiving carrier confirming entry into the end carrier's network. `sent` means the message
  left SignalWire and reached the downstream peer. Some carriers send delayed DLRs; others send none
  at all. MMS messages never receive DLRs, so they will only ever reach `sent` status.
  </Note>
  """)
model SmsStatusCallbackPayload {
  @doc("""
    The current status of the message at the time of the callback.
    One of: `queued`, `sending`, `sent`, `delivered`, `undelivered`, `failed`, `receiving`, `received`.
    """)
  @example("delivered")
  MessageStatus: "queued" | "sending" | "sent" | "delivered" | "undelivered" | "failed" | "receiving" | "received";

  @doc("If the message has failed or is undelivered, the error code may provide more information about what went wrong.")
  @example("30003")
  ErrorCode?: string;

  @doc("The unique ID of this message.")
  @example("b3877c40-da60-4998-90ad-b792e98472ms")
  MessageSid: string;

  @doc("The unique ID of the project this message is associated with.")
  @example("b3877c40-da60-4998-90ad-b792e98472af")
  AccountSid: string;

  @doc("The From number of the message.")
  @example("+15551234567")
  From: string;

  @doc("The To number of the message.")
  @example("+15559876543")
  To: string;

  @doc("The body of the message.")
  @example("Hey, your order has shipped!")
  Body: string;

  @doc("The number of media files that were included with the message.")
  @example(0)
  NumMedia: int32;

  @doc("""
    The number of segments that make up the entire message.
    If the body exceeds 160 GSM-7 characters or 70 UCS-2 characters, it is automatically split into
    smaller segments that are annotated for reconstruction on the recipient handset.
    """)
  @example(1)
  NumSegments: int32;
}
