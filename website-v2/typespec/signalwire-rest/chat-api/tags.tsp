import "@typespec/openapi3";

const TOKENS_TAG = "Tokens";

const TOKENS_TAG_METADATA = #{
  description: "Manage Chat tokens.",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on SignalWire REST APIs",
  },
};
