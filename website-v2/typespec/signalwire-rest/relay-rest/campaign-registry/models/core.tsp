import "../../../types";

using TypeSpec.Http;
using Types;

model BrandPathID {
  @doc("Unique ID of the brand.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

model CampaignPathID {
  @doc("Unique ID of the campaign.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

model AssignedNumberPathID {
  @doc("Unique ID of the assigned number.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

model OrderPathID {
  @doc("Unique ID of the order.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

@doc("Brand state.")
enum BrandState {
  pending: "pending",
  unverified: "unverified",
  completed: "completed",
}

@doc("Campaign state.")
enum CampaignState {
  pending: "pending",
  active: "active",
  inactive: "inactive",
}

@doc("Order state.")
enum OrderState {
  pending: "pending",
  processing: "processing",
  processed: "processed",
  failed: "failed",
}

@doc("Assignment state.")
enum AssignmentState {
  pending: "pending",
  completed: "completed",
  failed: "failed",
}

@doc("Brand model for 10DLC registration.")
model Brand {
  @doc("The unique identifier of the brand.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  id: uuid;

  @doc("The current state of the brand.")
  @example("pending")
  state?: string;

  @doc("Brand/Marketing/DBA name of the business if applicable.")
  @example("My Brand")
  name?: string;

  @doc("The legal name of the business.")
  @example("BrandCo")
  company_name?: string;

  @doc("A company contact email for this brand.")
  @example("brand_info@example.com")
  contact_email?: string;

  @doc("A contact phone number for this brand.")
  @example("+18995551212")
  contact_phone?: string;

  @doc("Country of registration.")
  @example("United States")
  ein_issuing_country?: string;

  @doc("What type of legal entity is the organization? (PRIVATE_PROFIT, PUBLIC_PROFIT, NON_PROFIT)")
  @example("Private Company")
  legal_entity_type?: string;

  @doc("Company EIN Number/Tax ID.")
  @example("12-3456789")
  ein?: string;

  @doc("Full company address.")
  @example("123 Brand St, Hill Valley CA, 91905")
  company_address?: string;

  @doc("An optional Vertical for the brand (REAL_ESTATE, HEALTHCARE, ENERGY, ENTERTAINMENT, RETAIL, AGRICULTURE, INSURANCE, EDUCATION, HOSPITALITY, FINANCIAL, GAMBLING, CONSTRUCTION, NGO, MANUFACTURING, GOVERNMENT, TECHNOLOGY, COMMUNICATION).")
  @example("Healthcare")
  company_vertical?: string;

  @doc("Link to the company website.")
  @example("www.example.com")
  company_website?: string;

  @doc("If you are your own Campaign Service Provider, this is the approved Brand ID (Mandatory for CSPs, otherwise please omit).")
  csp_brand_reference?: string;

  @doc("This value must be true for all self-registered brands.")
  @example(false)
  csp_self_registered?: boolean;

  @doc("Optional: Specify a URL to receive webhook notifications when your brand's state changes. See the [10DLC status callback](/docs/apis/relay-rest/campaign-registry/webhooks/ten-dlc-status-callback) docs for the webhook payload.")
  @example("https://example.com/handle_callback")
  status_callback_url?: string;

  @doc("Timestamp when the brand was created.")
  created_at?: utcDateTime;

  @doc("Timestamp when the brand was last updated.")
  updated_at?: utcDateTime;
}

@doc("Campaign model for 10DLC registration.")
model Campaign {
  @doc("The unique identifier of the campaign.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  id: uuid;

  @doc("A name for the campaign.")
  @example("My Campaign")
  name?: string;

  @doc("The current state of the campaign.")
  @example("pending")
  state?: string;

  @doc("An SMS Use Case category for the campaign (2FA, ACCOUNT_NOTIFICATION, AGENTS_FRANCHISES, CARRIER_EXEMPT, CHARITY, CUSTOMER_CARE, DELIVERY_NOTIFICATION, EMERGENCY, FRAUD_ALERT, HIGHER_EDUCATION, K12_EDUCATION, LOW_VOLUME_MIXED, MARKETING, MIXED, POLITICAL, POLITICAL_SECTION_527, POLLING_VOTING, PROXY, PUBLIC_SERVICE_ANNOUNCEMENT, SECURITY_ALERT, SOCIAL, SWEEPSTAKE, TRIAL, UCAAS_HIGH_VOLUME, UCAAS_LOW_VOLUME).")
  @example("MARKETING")
  sms_use_case?: string;

  @doc("A sub use case category for MIXED or LOW_VOLUME_MIXED campaigns (CUSTOMER_CARE, HIGHER_EDUCATION, POLLING_VOTING, PUBLIC_SERVICE_ANNOUNCEMENT, MARKETING, SECURITY_ALERT, 2FA, ACCOUNT_NOTIFICATION, DELIVERY_NOTIFICATION, FRAUD_ALERT).")
  sub_use_cases?: string[];

  @doc("Campaign Verify token. Required if sms use case is POLITICAL_SECTION_527.")
  campaign_verify_token?: string;

  @doc("A description for the campaign. Please use at least 40 characters.")
  description?: string;

  @doc("Sample message template/content. At least two samples are required and up to five can be provided. Please use at least 20 characters.")
  @example("this is a sample message your customer might receive")
  sample1?: string;

  @doc("Sample 2.")
  @example("this is a sample message your customer might receive")
  sample2?: string;

  @doc("Sample 3.")
  sample3?: string;

  @doc("Sample 4.")
  sample4?: string;

  @doc("Sample 5.")
  sample5?: string;

  @doc("If your messaging content will be modified in any way beyond what you shared in your templates, please describe the nature of how the content will change.")
  dynamic_templates?: string;

  @doc("Please describe the call to action/message flow your intended recipients will experience.")
  @example("Users will opt in to receive messages from their doctor through a written form and we will send them an opt in message. Appointment reminders will then be sent ahead of their appointments.")
  message_flow?: string;

  @doc("Please share the message subscribers receive when they opt in.")
  @example("Thanks for subscribing. Reply STOP to cancel at any time.")
  opt_in_message?: string;

  @doc("Please share the message subscribers receive when they opt out.")
  @example("You have successfully been opted out. Reply START to opt back in at any time.")
  opt_out_message?: string;

  @doc("Please share the message subscribers receive when they request help.")
  @example("You have successfully been opted out. Reply SUBSCRIBE to opt back in at any time.")
  help_message?: string;

  @doc("Opt in keywords that subscribers can use.")
  @example("Start,Subscribe,Opt In")
  opt_in_keywords?: string = "START";

  @doc("Opt out keywords that subscribers can use.")
  @example("Stop,Opt Out,Unsubscribe")
  opt_out_keywords?: string = "STOP";

  @doc("Help keywords that subscribers can use.")
  @example("Help,Support,Request Call")
  help_keywords?: string = "HELP";

  @doc("Will 50 or more numbers be used with this single campaign? If so, please enter true.")
  @example(true)
  number_pooling_required?: boolean;

  @doc("If you will be using number pooling, please provide an explanation as to why it is needed.")
  @example("We have customer reps in every state and they each need their own number with local area code.")
  number_pooling_per_campaign?: string;

  @doc("Will this campaign include content related to direct lending or other loan agreements?")
  @example(true)
  direct_lending?: boolean;

  @doc("Will you be using an embedded link of any kind? Note that public URL shorteners (bitly, tinyurl) will not be accepted.")
  @example(false)
  embedded_link?: boolean;

  @doc("Are you using an embedded phone number (except the required HELP information contact phone number)?")
  @example(false)
  embedded_phone?: boolean;

  @doc("Will this campaign include any age gated content as defined by carrier and CTA guidelines?")
  @example(true)
  age_gated_content?: boolean;

  @doc("Is there any intent of this campaign to generate leads?")
  @example(true)
  lead_generation?: boolean;

  @doc("If you are your own Campaign Service Provider, what is the approved Campaign ID? (Mandatory for CSPs, otherwise please omit)")
  @example("1231231")
  csp_campaign_reference?: string;

  @doc("Optional: Specify a URL to receive webhook notifications when your campaign's state changes. See the [10DLC status callback](/docs/apis/relay-rest/campaign-registry/webhooks/ten-dlc-status-callback) docs for the webhook payload.")
  @example("https://example.com/handle_callback")
  status_callback_url?: string;

  @doc("Timestamp when the campaign was created.")
  created_at?: utcDateTime;

  @doc("Timestamp when the campaign was last updated.")
  updated_at?: utcDateTime;
}

@doc("Phone number details in an assignment.")
model AssignedPhoneNumber {
  @doc("The unique identifier of the phone number.")
  @format("uuid")
  id?: uuid;

  @doc("The name of the phone number.")
  @example("Jenny")
  name?: string;

  @doc("The phone number in E.164 format.")
  @example("+15558675309")
  number?: string;

  @doc("Optional: Specify a URL to receive webhook notifications. See the [10DLC status callback](/docs/apis/relay-rest/campaign-registry/webhooks/ten-dlc-status-callback) docs for the webhook payload.")
  @example("https://example.com/handle_callback")
  status_callback_url?: string;
}

@doc("Assigned number model for campaign registration.")
model AssignedNumber {
  @doc("The unique identifier of the assignment.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  id: uuid;

  @doc("The current state of the assignment.")
  @example("pending")
  state?: string;

  @doc("The campaign ID associated with the number.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  campaign_id?: uuid;

  @doc("The phone number details.")
  phone_number?: AssignedPhoneNumber;

  @doc("Timestamp when the assignment was created.")
  created_at?: utcDateTime;

  @doc("Timestamp when the assignment was last updated.")
  updated_at?: utcDateTime;
}

@doc("Order model for campaign registry operations.")
model Order {
  @doc("The unique identifier of the order.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  id: uuid;

  @doc("The current state of the order.")
  @example("pending")
  state?: string;

  @doc("Timestamp when the order was processed.")
  processed_at?: utcDateTime;

  @doc("Timestamp when the order was created.")
  created_at?: utcDateTime;

  @doc("Timestamp when the order was last updated.")
  updated_at?: utcDateTime;

  @doc("Optional: Specify a URL to receive webhook notifications when your number assignment order and the number assignments that belong to it change state. See the [10DLC status callback](/docs/apis/relay-rest/campaign-registry/webhooks/ten-dlc-status-callback) docs for the webhook payload.")
  @example("https://example.com/handle_callback")
  status_callback_url?: string;
}
