import "@typespec/openapi3";

const AI_CUSTOM_TAG = "AI Agents: Custom";

const AI_CUSTOM_TAG_METADATA = #{
  description: "Endpoints related to creating & managing SignalWire AI Agents",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on SignalWire AI Agent, Fabric API endpoints",
  },
  `x-displayName`: "AI Agents: Custom",
};

const AI_DIALOGFLOW_TAG = "AI Agents: Dialogflow";

const AI_DIALOGFLOW_TAG_METADATA = #{
  description: "Endpoints related to creating & managing Dialogflow Agents",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on Dialogflow Agent, Fabric API endpoints",
  },
  `x-displayName`: "AI Agents: Dialogflow",
};

const CALL_FLOWS_TAG = "Call Flows";

const CALL_FLOWS_TAG_METADATA = #{
  description: "Endpoints related to creating & managing Call Flows",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on Call Flow, Fabric API endpoints",
  },
};

const EMBEDS_TOKENS_TAG = "Embeds Tokens";

const EMBEDS_TOKENS_TAG_METADATA = #{
  description: "Endpoints related to creating & managing Embed Tokens",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on Embed Tokens, Fabric API endpoints",
  },
};

const SWML_WEBHOOK_TAG = "SWML Webhook";

const SWML_WEBHOOK_TAG_METADATA = #{
  description: "Endpoints related to creating & managing SWML Webhooks",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on SWML Webhooks, Fabric API endpoints",
  },
  `x-displayName`: "SWML Webhook",
};

const FABRIC_ADDRESS_TAG = "Fabric Address";

const FABRIC_ADDRESS_TAG_METADATA = #{
  description: "Endpoints related to creating & managing Fabric Addresses",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on Fabric Address, Fabric API endpoints",
  },
};

const FREESWITCH_CONNECTOR_TAG = "FREESWITCH Connector";

const FREESWITCH_CONNECTOR_TAG_METADATA = #{
  description: "Endpoints related to creating & managing FreeSWITCH Connectors",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on FreeSWITCH Connector, Fabric API endpoints",
  },
  `x-displayName`: "FreeSWITCH Connector",
};

const CXML_APPLICATIONS_TAG = "CXML Applications";

const CXML_APPLICATIONS_TAG_METADATA = #{
  description: "Endpoints related to creating & managing cXML Applications",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on cXML Application, Fabric API endpoints",
  },
  `x-displayName`: "cXML Applications",
};

const CXML_SCRIPTS_TAG = "CXML Scripts";

const CXML_SCRIPTS_TAG_METADATA = #{
  description: "Endpoints related to creating & managing cXML Scripts",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on cXML Scripts, Fabric API endpoints",
  },
  `x-displayName`: "cXML Scripts",
};

const CXML_WEBHOOK_TAG = "CXML Webhook";

const CXML_WEBHOOK_TAG_METADATA = #{
  description: "Endpoints related to creating & managing cXML Webhooks",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on cXML Webhook, Fabric API endpoints",
  },
  `x-displayName`: "cXML Webhook",
};

const RELAY_APPLICATION_TAG = "Relay Application";

const RELAY_APPLICATION_TAG_METADATA = #{
  description: "Endpoints related to creating & managing Relay Applications",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on Relay Application, Fabric API endpoints",
  },
};

const RESOURCES_TAG = "Resources";

const RESOURCES_TAG_METADATA = #{
  description: "Endpoints related to creating & managing Resources",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on Resource, Fabric API endpoints",
  },
};

const SIP_ENDPOINTS_TAG = "SIP Endpoints";

const SIP_ENDPOINTS_TAG_METADATA = #{
  description: "Endpoints related to creating & managing SIP Endpoints",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on SIP Endpoint, Fabric API endpoints",
  },
  `x-displayName`: "SIP Endpoints",
};

const SIP_GATEWAY_TAG = "SIP Gateway";

const SIP_GATEWAY_TAG_METADATA = #{
  description: "Endpoints related to creating & managing SIP Gateways",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on SIP Gateway, Fabric API endpoints",
  },
  `x-displayName`: "SIP Gateway",
};

const SUBSCRIBERS_TAG = "Subscribers";

const SUBSCRIBERS_TAG_METADATA = #{
  description: "Endpoints related to creating & managing Subscribers",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on Subscriber, Fabric API endpoints",
  },
};

const SUBSCRIBERS_TOKENS_TAG = "Subscribers: Tokens";

const SUBSCRIBERS_TOKENS_TAG_METADATA = #{
  description: "Endpoints related to creating & managing Subscriber tokens",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on Subscriber token, Fabric API endpoints",
  },
};

const SUBSCRIBER_SIP_ENDPOINT_TAG = "Subscribers: SIP Endpoints";

const SUBSCRIBER_SIP_ENDPOINT_TAG_METADATA = #{
  description: "Endpoints related to creating & managing Subscriber SIP Endpoints",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on Subscriber SIP Endpoint, Fabric API endpoints",
  },
  `x-displayName`: "Subscribers: SIP Endpoints",
};

const SWML_SCRIPTS_TAG = "SWML Scripts";

const SWML_SCRIPTS_TAG_METADATA = #{
  description: "Endpoints related to creating & managing SWML Scripts",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on SWML Script, Fabric API endpoints",
  },
  `x-displayName`: "SWML Scripts",
};

const CONFERENCE_ROOM_TAG = "Conference Rooms";

const CONFERENCE_ROOM_TAG_METADATA = #{
  description: "Endpoints related to creating & managing Conference Rooms",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on Conference Room, Fabric API endpoints",
  },
};

const DOMAIN_APPLICATIONS_TAG = "Domain Applications";

const DOMAIN_APPLICATIONS_TAG_METADATA = #{
  description: "Endpoints related to managing Domain Applications",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on Domain Application, Fabric API endpoints",
  },
};

const PHONE_ROUTES_TAG = "Phone Routes";

const PHONE_ROUTES_TAG_METADATA = #{
  description: "Endpoints related to managing Phone Routes",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on Phone Routes, Fabric API endpoints",
  },
};
