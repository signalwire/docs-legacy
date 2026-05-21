/**
 * Operation examples for the Calling API
 *
 * These examples can be imported and used with @opExample decorator on operations
 */
const callId = "3fa85f64-5717-4562-b3fc-2c963f66afa6";

// Call command examples
const dialCallExample = #{
  request: #{
    command: "dial",
    params: #{
      from: "+15551234567",
      to: "+15559876543",
      url: "https://example.com/swml",
      caller_id: "+15551234567",
      status_url: "https://example.com/status_callback",
      status_events: #["answered", "ended"],
    },
  },
};

const updateCallExample = #{
  request: #{
    command: "update",
    params: #{
      id: callId,
      url: "https://example.com/swml",
      fallback_url: "https://example.com/fallback",
    },
  },
};

const hangupCallExample = #{
  request: #{
    command: "calling.end",
    id: callId,
    params: #{ reason: HangupReason.hangup },
  },
};

const holdCallExample = #{
  request: #{ command: "calling.ai_hold", id: callId, params: #{} },
};

const unholdCallExample = #{
  request: #{ command: "calling.ai_unhold", id: callId, params: #{} },
};

const aiMessageExample = #{
  request: #{
    command: "calling.ai_message",
    id: callId,
    params: #{
      role: "system",
      message_text: "You are now in expert mode. Provide detailed technical responses and use industry terminology.",
    },
  },
};

// Live Transcribe examples
const liveTranscribeStartExample = #{
  request: #{
    command: "calling.live_transcribe",
    id: callId,
    params: #{
      action: #{
        start: #{
          lang: "en-US",
          direction: #[
            TranscribeDirection.`local-caller`,
            TranscribeDirection.`remote-caller`
          ],
          webhook: "https://example.com/transcription-events",
          live_events: true,
          ai_summary: true,
          ai_summary_prompt: "Summarize the key points of this conversation.",
          speech_engine: SpeechEngine.deepgram,
        },
      },
    },
  },
};

const liveTranscribeStopExample = #{
  request: #{
    command: "calling.live_transcribe",
    id: callId,
    params: #{ action: LiveTranscribeStopAction.stop },
  },
};

const liveTranscribeSummarizeExample = #{
  request: #{
    command: "calling.live_transcribe",
    id: callId,
    params: #{
      action: #{
        summarize: #{
          webhook: "https://example.com/summary",
          prompt: "Provide a bullet-point summary of the main topics discussed.",
        },
      },
    },
  },
};

// Live Translate examples
const liveTranslateStartExample = #{
  request: #{
    command: "calling.live_translate",
    id: callId,
    params: #{
      action: #{
        start: #{
          from_lang: "en-US",
          to_lang: "es-ES",
          direction: #[
            TranscribeDirection.`local-caller`,
            TranscribeDirection.`remote-caller`
          ],
          from_voice: "elevenlabs.josh",
          to_voice: "elevenlabs.josh",
          filter_from: "professional",
          webhook: "https://example.com/translation-events",
          live_events: true,
          ai_summary: true,
          speech_engine: SpeechEngine.deepgram,
        },
      },
    },
  },
};

const liveTranslateStopExample = #{
  request: #{
    command: "calling.live_translate",
    id: callId,
    params: #{ action: "stop" },
  },
};

const liveTranslateSummarizeExample = #{
  request: #{
    command: "calling.live_translate",
    id: callId,
    params: #{
      action: #{
        summarize: #{
          webhook: "https://example.com/summary",
          prompt: "Summarize the key agreements reached in both languages.",
        },
      },
    },
  },
};

const liveTranslateInjectExample = #{
  request: #{
    command: "calling.live_translate",
    id: callId,
    params: #{
      action: #{
        inject: #{
          message: "Please hold while I transfer you to a specialist.",
          direction: "remote-caller",
        },
      },
    },
  },
};

// Transfer example
const transferCallExample = #{
  request: #{
    command: "calling.transfer",
    id: callId,
    params: #{ dest: "sip:destination@example.com" },
  },
};

// User Event example
const userEventCallExample = #{
  request: #{
    command: "calling.user_event",
    id: callId,
    params: #{ event: #{ action: "custom_action", data: "example" } },
  },
};
