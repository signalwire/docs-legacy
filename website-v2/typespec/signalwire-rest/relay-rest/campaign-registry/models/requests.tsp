import "./core.tsp";

using TypeSpec.Http;

@doc("Legal entity type for brand registration.")
enum LegalEntityType {
  PRIVATE_PROFIT: "PRIVATE_PROFIT",
  PUBLIC_PROFIT: "PUBLIC_PROFIT",
  NON_PROFIT: "NON_PROFIT",
  GOVERNMENT: "GOVERNMENT",
}

@doc("Company vertical/industry classification.")
enum CompanyVertical {
  AGRICULTURE: "AGRICULTURE",
  COMMUNICATION: "COMMUNICATION",
  CONSTRUCTION: "CONSTRUCTION",
  EDUCATION: "EDUCATION",
  ENERGY: "ENERGY",
  ENTERTAINMENT: "ENTERTAINMENT",
  FINANCIAL: "FINANCIAL",
  GAMBLING: "GAMBLING",
  GOVERNMENT: "GOVERNMENT",
  HEALTHCARE: "HEALTHCARE",
  HOSPITALITY: "HOSPITALITY",
  HUMAN_RESOURCES: "HUMAN_RESOURCES",
  INSURANCE: "INSURANCE",
  LEGAL: "LEGAL",
  MANUFACTURING: "MANUFACTURING",
  NGO: "NGO",
  POLITICAL: "POLITICAL",
  POSTAL: "POSTAL",
  PROFESSIONAL: "PROFESSIONAL",
  REAL_ESTATE: "REAL_ESTATE",
  RETAIL: "RETAIL",
  TECHNOLOGY: "TECHNOLOGY",
  TRANSPORTATION: "TRANSPORTATION",
}

@doc("Request body for registering a new managed brand for 10DLC registration.")
model CreateManagedBrandRequest {
  @doc("Brand/Marketing/DBA name of the business.")
  @example("My Brand")
  @minLength(3)
  @maxLength(64)
  name: string;

  @doc("The legal name of the business.")
  @example("BrandCo")
  @minLength(3)
  @maxLength(64)
  company_name: string;

  @doc("A company contact email for this brand.")
  @example("brand_info@example.com")
  @minLength(3)
  @maxLength(64)
  contact_email: string;

  @doc("A contact phone number for this brand.")
  @example("+18995551212")
  @minLength(3)
  @maxLength(64)
  contact_phone: string;

  @doc("Country of registration.")
  @example("United States")
  ein_issuing_country: string;

  @doc("What type of legal entity is the organization?")
  @example(LegalEntityType.PRIVATE_PROFIT)
  legal_entity_type: LegalEntityType;

  @doc("Company EIN Number/Tax ID.")
  @example("12-3456789")
  ein: string;

  @doc("Full company address.")
  @example("123 Brand St, Hill Valley CA, 91905")
  company_address: string;

  @doc("An optional Vertical for the brand.")
  @example(CompanyVertical.HEALTHCARE)
  company_vertical?: CompanyVertical;

  @doc("Link to the company website.")
  @example("www.example.com")
  company_website: string;

  @doc("Specify a URL to receive webhook notifications when your brand's state changes. See the [10DLC status callback](/docs/apis/relay-rest/campaign-registry/webhooks/ten-dlc-status-callback) docs for the webhook payload.")
  @example("https://example.com/handle_callback")
  @format("uri")
  status_callback_url?: string;
}

@doc("Request body for importing a self-registered CSP brand. Use this when you have already registered your brand directly with TCR.")
model CreateCspBrandRequest {
  @doc("Set to true to indicate this is a self-registered CSP brand.")
  @example(true)
  csp_self_registered: true;

  @doc("Brand/Marketing/DBA name of the business.")
  @example("My Brand")
  @minLength(3)
  @maxLength(64)
  name: string;

  @doc("The approved Brand ID from TCR. Required for CSP/self-registered brands.")
  @example("B123456")
  csp_brand_reference: string;

  @doc("Specify a URL to receive webhook notifications when your brand's state changes. See the [10DLC status callback](/docs/apis/relay-rest/campaign-registry/webhooks/ten-dlc-status-callback) docs for the webhook payload.")
  @example("https://example.com/handle_callback")
  @format("uri")
  status_callback_url?: string;
}

alias CreateBrandRequest = CreateManagedBrandRequest | CreateCspBrandRequest;

@doc("Request body for updating a brand.")
model UpdateBrandRequest {
  @doc("Brand/Marketing/DBA name of the business if applicable.")
  @example("My Brand")
  name?: string;

  @doc("A company contact email for this brand.")
  @example("brand_info@example.com")
  contact_email?: string;

  @doc("A contact phone number for this brand.")
  @example("+18995551212")
  contact_phone?: string;

  @doc("Optional: Specify a URL to receive webhook notifications when your brand's state changes. See the [10DLC status callback](/docs/apis/relay-rest/campaign-registry/webhooks/ten-dlc-status-callback) docs for the webhook payload.")
  @example("https://example.com/handle_callback")
  status_callback_url?: string;
}

@doc("Request body for creating a managed campaign. Used when the brand is a managed (non-CSP) brand.")
model CreateManagedCampaignRequest {
  @doc("A name for the campaign.")
  @example("My Campaign")
  @minLength(3)
  @maxLength(64)
  name: string;

  @doc("The ID of the brand to associate with this campaign.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  brand_id: uuid;

  @doc("An SMS Use Case category for the campaign.")
  @example("MARKETING")
  sms_use_case: string;

  @doc("A sub use case category. Required for MIXED (2-5 sub use cases) or LOW_VOLUME_MIXED (1-5 sub use cases) campaigns. Must not be provided for other use cases.")
  sub_use_cases?: string[];

  @doc("Campaign Verify token. Required if sms_use_case is POLITICAL_SECTION_527.")
  campaign_verify_token?: string;

  @doc("A description for the campaign.")
  @example("This campaign sends appointment reminders to patients who have opted in to receive notifications from their healthcare provider.")
  @minLength(40)
  description: string;

  @doc("Sample message template/content.")
  @example("Hi John, this is a reminder that your appointment is tomorrow at 2pm. Reply STOP to unsubscribe.")
  @minLength(20)
  sample1: string;

  @doc("Second sample message template/content.")
  @example("Your prescription is ready for pickup at Main St Pharmacy. Reply STOP to unsubscribe.")
  @minLength(20)
  sample2: string;

  @doc("Third sample message template/content.")
  @minLength(20)
  sample3?: string;

  @doc("Fourth sample message template/content.")
  @minLength(20)
  sample4?: string;

  @doc("Fifth sample message template/content.")
  @minLength(20)
  sample5?: string;

  @doc("If your messaging content will be modified in any way beyond what you shared in your templates, please describe the nature of how the content will change.")
  dynamic_messages?: string;

  @doc("Please describe the call to action/message flow your intended recipients will experience.")
  @example("Users will opt in to receive messages from their doctor through a written form and we will send them an opt in message. Appointment reminders will then be sent ahead of their appointments.")
  @minLength(40)
  message_flow: string;

  @doc("Please share the message subscribers receive when they opt in.")
  @example("Thanks for subscribing to appointment reminders. Reply STOP to cancel at any time.")
  @minLength(20)
  opt_in_message?: string;

  @doc("Please share the message subscribers receive when they opt out.")
  @example("You have successfully been opted out. Reply START to opt back in at any time.")
  @minLength(20)
  opt_out_message: string;

  @doc("Please share the message subscribers receive when they request help.")
  @example("For help, contact support@example.com or call 1-800-555-0123. Reply STOP to unsubscribe.")
  @minLength(20)
  help_message: string;

  @doc("Opt in keywords that subscribers can use. Must be comma-separated values with no spaces between keywords.")
  @example("START,SUBSCRIBE,OPTIN")
  opt_in_keywords?: string;

  @doc("Opt out keywords that subscribers can use. Must be comma-separated values with no spaces between keywords.")
  @example("STOP,UNSUBSCRIBE,OPTOUT")
  opt_out_keywords?: string;

  @doc("Help keywords that subscribers can use. Must be comma-separated values with no spaces between keywords.")
  @example("HELP,INFO,SUPPORT")
  help_keywords?: string;

  @doc("Will 50 or more numbers be used with this single campaign?")
  @example(false)
  number_pooling_required: boolean;

  @doc("If you will be using number pooling, please provide an explanation as to why it is needed. Required if number_pooling_required is true.")
  @example("We have customer reps in every state and they each need their own number with local area code.")
  number_pooling_per_campaign?: string;

  @doc("Will this campaign include content related to direct lending or other loan agreements?")
  @example(false)
  direct_lending: boolean;

  @doc("Will you be using an embedded link of any kind? Note that public URL shorteners (bitly, tinyurl) will not be accepted.")
  @example(false)
  embedded_link: boolean;

  @doc("Are you using an embedded phone number (except the required HELP information contact phone number)?")
  @example(false)
  embedded_phone: boolean;

  @doc("Will this campaign include any age gated content as defined by carrier and CTA guidelines?")
  @example(false)
  age_gated_content: boolean;

  @doc("Is there any intent of this campaign to generate leads?")
  @example(false)
  lead_generation: boolean;

  @doc("I agree to the terms and conditions which do not allow me to use this campaign for affiliate marketing.")
  @example(true)
  terms_and_conditions: boolean;

  @doc("Specify a URL to receive webhook notifications when your campaign's state changes. See the [10DLC status callback](/docs/apis/relay-rest/campaign-registry/webhooks/ten-dlc-status-callback) docs for the webhook payload.")
  @example("https://example.com/handle_callback")
  @format("uri")
  status_callback_url?: string;
}

@doc("Request body for creating a partner/CSP campaign. Used when the brand is a CSP (self-registered) brand.")
model CreatePartnerCampaignRequest {
  @doc("A name for the campaign.")
  @example("My Campaign")
  @minLength(3)
  @maxLength(64)
  name: string;

  @doc("The ID of the brand to associate with this campaign. Must be a CSP/partner brand.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  brand_id: uuid;

  @doc("The approved Campaign ID from TCR. Required for CSP/self-registered campaigns.")
  @example("C123456")
  csp_campaign_reference: string;

  @doc("Specify a URL to receive webhook notifications when your campaign's state changes. See the [10DLC status callback](/docs/apis/relay-rest/campaign-registry/webhooks/ten-dlc-status-callback) docs for the webhook payload.")
  @example("https://example.com/handle_callback")
  @format("uri")
  status_callback_url?: string;
}

alias CreateCampaignRequest = CreateManagedCampaignRequest | CreatePartnerCampaignRequest;

@doc("Request body for updating a campaign.")
model UpdateCampaignRequest {
  @doc("A name for the campaign.")
  @example("My Campaign")
  name?: string;
}

@doc("Request body for creating an order.")
model CreateOrderRequest {
  @doc("A list of phone numbers in E164 format.")
  @example(#["+15558675309"])
  phone_numbers?: string[];

  @doc("Optional: Specify a URL to receive webhook notifications when your number assignment order and the number assignments that belong to it change state. See the [10DLC status callback](/docs/apis/relay-rest/campaign-registry/webhooks/ten-dlc-status-callback) docs for the webhook payload.")
  @example("https://example.com/handle_callback")
  status_callback_url?: string;
}

@doc("Request body for assigning a number to a campaign.")
model AssignNumberRequest {
  @doc("The phone number ID to assign.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  phone_number_id: uuid;
}

@doc("Query parameters for filtering brands.")
model ListBrandsQuery {
  @doc("The name given to the brand. Will return all Brands containing this value as a substring.")
  @query
  filter_name?: string;

  @doc("The state of the brand in the registration process, such as pending or completed. Will return all Brands with this value.")
  @query
  filter_state?: BrandState;
}

@doc("Query parameters for filtering campaigns.")
model ListCampaignsQuery {
  @doc("The name given to the campaign. Will return all Campaigns containing this value as a substring.")
  @query
  filter_name?: string;

  @doc("The state of the campaign in the registration process, such as pending or active. Will return all campaigns with this value.")
  @query
  filter_state?: CampaignState;
}

@doc("Query parameters for filtering number assignments.")
model ListAssignmentsQuery {
  @doc("The state of the assignments in the registration process, such as pending or completed. Will return all assignments with this value.")
  @query
  filter_state?: AssignmentState;
}

@doc("Query parameters for filtering orders.")
model ListOrdersQuery {
  @doc("The state of the orders in the registration process, such as pending or processed. Will return all orders with this value.")
  @query
  filter_state?: OrderState;
}
