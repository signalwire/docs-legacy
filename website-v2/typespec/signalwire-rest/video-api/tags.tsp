import "@typespec/openapi";

using TypeSpec.OpenAPI;

const ROOMS_TAG = "Rooms";
const ROOMS_TAG_METADATA = #{
  description: "Manage video rooms",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on SignalWire REST APIs",
  },
};

const STREAMS_TAG = "Streams";
const STREAMS_TAG_METADATA = #{
  description: "Manage video streams",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on SignalWire REST APIs",
  },
};

const ROOM_SESSIONS_TAG = "Room Sessions";
const ROOM_SESSIONS_TAG_METADATA = #{
  description: "Manage room sessions",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on SignalWire REST APIs",
  },
};

const ROOM_TOKENS_TAG = "Room Tokens";
const ROOM_TOKENS_TAG_METADATA = #{
  description: "Manage room tokens",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on SignalWire REST APIs",
  },
};

const ROOM_RECORDINGS_TAG = "Room Recordings";
const ROOM_RECORDINGS_TAG_METADATA = #{
  description: "Manage room recordings",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on SignalWire REST APIs",
  },
};

const CONFERENCES_TAG = "Conferences";
const CONFERENCES_TAG_METADATA = #{
  description: "Manage video conferences",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on SignalWire REST APIs",
  },
};

const CONFERENCE_TOKENS_TAG = "Conference Tokens";
const CONFERENCE_TOKENS_TAG_METADATA = #{
  description: "Manage conference tokens",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on SignalWire REST APIs",
  },
};

const LOGS_TAG = "Logs";
const LOGS_TAG_METADATA = #{
  description: "View video logs",
  externalDocs: #{
    url: "https://signalwire.com/docs/apis",
    description: "Developer documentation on SignalWire REST APIs",
  },
};
