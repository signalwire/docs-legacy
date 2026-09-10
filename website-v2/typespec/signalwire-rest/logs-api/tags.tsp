import "@typespec/openapi3";

const CONFERENCES_TAG = "Conferences";

const CONFERENCES_TAG_METADATA = #{
  description: "Manage and query conference log data.",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on SignalWire REST APIs",
  },
};
