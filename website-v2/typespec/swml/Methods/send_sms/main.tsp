import "@typespec/json-schema";

using TypeSpec.JsonSchema;

@summary("SMSBase object")
model SMSBase {
  @doc("Phone number to send SMS message to in E.164 format.")
  @example("+15559876543")
  to_number: string;

  @doc("Phone number the SMS message will be sent from in E.164 format.")
  @example("+15551234567")
  from_number: string;

  @doc("Region of the world to originate the message from. Chosen based on account preferences or device location if not specified.")
  @example("us")
  region?: string;

  @doc("Array of tags to associate with the message to facilitate log searches.")
  @example(#["notification", "order-confirmation"])
  tags?: string[];
}

@summary("SMS")
model SMSWithBody is SMSBase {
  @doc("Required if `media` is not present. The body of the SMS message.")
  @example("Your order has been confirmed. Thank you!")
  body: string;
}

@summary("MMS")
model SMSWithMedia is SMSBase {
  @doc("Required if `body` is not present. Array of media URLs to include in the message.")
  @example(#["https://example.com/image.png"])
  media: string[];

  @doc("Optional if `media` is present. The body of the SMS message.")
  @example("Check out this image!")
  body?: string;
}

alias SMSPlan = SMSWithBody | SMSWithMedia;

@summary("send_sms Method")
model SendSMS {
  @summary("send_sms")
  @doc("Send an outbound SMS or MMS message to a PSTN phone number.")
  send_sms: SMSPlan;
}
