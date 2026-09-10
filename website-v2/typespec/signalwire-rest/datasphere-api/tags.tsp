import "@typespec/openapi3";

const DOCUMENTS_TAG = "Documents";

const DOCUMENTS_TAG_METADATA = #{
  description: "Manage Datasphere documents.",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on SignalWire REST APIs",
  },
};

const CHUNKS_TAG = "Chunks";

const CHUNKS_TAG_METADATA = #{
  description: "Manage chunks within Datasphere documents.",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on SignalWire REST APIs",
  },
};
