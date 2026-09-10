@summary("send_fax Method")
model SendFax {
  @summary("send_fax")
  @doc("Send a fax.")
  send_fax: {
    @doc("URL to the PDF document to fax.")
    @example("https://example.com/document.pdf")
    document: url;

    @doc("Header text to include on the fax.")
    @example("Invoice #12345")
    header_info?: string;

    @doc("""
      Station identity to report.
      Default is the calling party's caller ID number.
      """)
    @example("+15551234567")
    identity?: string;

    @doc("http or https URL to deliver send_fax status events")
    @example("https://example.com/fax-status")
    status_url?: url;
  };
}
