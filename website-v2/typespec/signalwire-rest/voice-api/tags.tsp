import "@typespec/openapi3";

const VOICE_LOGS_TAG = "Logs";

const VOICE_LOGS_TAG_METADATA = #{
  description: "Endpoints related to accessing voice logs",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on Voice API endpoints",
  },
};
