@summary("transfer Method")
model Transfer {
  @summary("transfer")
  @doc("""
    Transfer the execution of the script to a different SWML section, URL, or Relay application.
    Once the transfer is complete, the script will continue executing SWML from the new location.
    """)
  transfer: {
    @doc("""
      Specifies where to transfer to. The value can be one of:
      - <section_name> - section in the SWML document to jump to
      - A URL (http or https) - URL to fetch next document from. Sends HTTP POST.
        Authentication can also be set in the URL in the format of username:password@url.
      - An inline SWML document (as a JSON string)
      """)
    @example("https://example.com/transfer-handler")
    dest: string;

    @doc("""
      Named parameters to send to transfer destination.
      Accepts an object mapping variable names to values.
      Default is not set.
      """)
    @example(#{ department: "sales", priority: "high" })
    params?: {
      ...TypeSpec.Record<unknown>;
    };

    @doc("""
      User data, ignored by SignalWire.
      Accepts an object mapping variable names to values.
      Default is not set.
      """)
    @example(#{ transfer_reason: "escalation", original_agent: "agent_001" })
    meta?: {
      ...TypeSpec.Record<unknown>;
    };
  };
}
