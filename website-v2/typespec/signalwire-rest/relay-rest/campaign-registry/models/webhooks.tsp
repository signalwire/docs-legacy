import "../../../../_shared/webhook/decorator.tsp";

@summary("10DLC status callback")
@doc("""
  Payload sent by SignalWire to your 10DLC Status Callback URL when the state of a 10DLC registration
  object changes. Use this webhook to monitor the lifecycle of messaging brands, campaigns, number
  assignment orders, and number assignments in real time.

  Configure `status_callback_url` when
  [creating a brand](/apis/space/create-brand),
  [creating a campaign](/apis/space/create-campaign), or
  [creating a number assignment order](/apis/space/create-order).

  ### Brand event types

  | State transition | Event type | Description |
  |------------------|------------|-------------|
  | `pending` → `completed` | `brand_activated` | The brand has been successfully verified and activated. |
  | `pending` → `unverified` | `brand_unverified` | Brand verification failed or additional information is required. |
  | `unverified` → `completed` | `brand_activated` | The brand was previously unverified but is now active. |

  ### Campaign event types

  | State transition | Event type | Description |
  |------------------|------------|-------------|
  | `pending` → `active` | `campaign_activated` | The campaign has been approved and is now active. |
  | `active` → `inactive` | `campaign_deactivated` | The campaign has been deactivated and can no longer send. |

  ### Number assignment order event types

  | State transition | Event type | Description |
  |------------------|------------|-------------|
  | `pending` → `processed` | `number_assignment_order_processed` | The order has been processed and numbers assigned. |

  ### Number assignment event types

  | State transition | Event type | Description |
  |------------------|------------|-------------|
  | `pending` → `failed` | `number_assignment_failed` | The number was not assigned to the campaign. |
  | `failed` → `pending` | `number_assignment_pending` | A failed assignment is being retried. |
  | `pending` → `completed` | `number_assignment_activated` | The number has been successfully assigned to the campaign. |
  """)
model TenDlcStatusCallbackPayload {
  @doc("The unique ID of the project this object is associated with.")
  project_id: string;

  @doc("The timestamp of when the event occurred, in ISO 8601 format.")
  event_at: string;

  @doc("The category of the event.")
  event_category: "brand" | "campaign" | "number_assignment_order" | "number_assignment";

  @doc("""
    The specific type of event that occurred.
    One of: `brand_activated`, `brand_unverified`, `campaign_activated`, `campaign_deactivated`,
    `number_assignment_order_processed`, `number_assignment_failed`, `number_assignment_pending`,
    `number_assignment_activated`.
    """)
  event_type: "brand_activated" | "brand_unverified" | "campaign_activated" | "campaign_deactivated" | "number_assignment_order_processed" | "number_assignment_failed" | "number_assignment_pending" | "number_assignment_activated";

  @doc("The current state of the object after the event. Possible values depend on the object type.")
  state: string;

  @doc("The unique identifier for the brand. Present in all event types.")
  brand_id: string;

  @doc("The unique identifier for the campaign. Present in campaign, number assignment order, and number assignment events.")
  campaign_id?: string;

  @doc("The unique identifier for the number assignment order. Present in number assignment order and number assignment events.")
  number_assignment_order_id?: string;

  @doc("The unique identifier for the number assignment. Present only in number assignment events.")
  number_assignment_id?: string;

  @doc("The unique identifier for the phone route itself. Present only in number assignment events.")
  phone_number_id?: string;

  @doc("The phone number in E.164 format. Present only in number assignment events.")
  phone_number?: string;
}
