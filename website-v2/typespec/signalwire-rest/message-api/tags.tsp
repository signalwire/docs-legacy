import "@typespec/openapi3";

const MESSAGE_LOGS_TAG = "Logs";

const MESSAGE_LOGS_TAG_METADATA = #{
  description: "Endpoints related to accessing message logs",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on Message API endpoints",
  },
};
