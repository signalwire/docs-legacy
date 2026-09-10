@summary("send_digits Method")
model SendDigits {
  @summary("send_digits")
  @doc("Send digit presses as DTMF tones.")
  send_digits: {
    @doc("The digits to send. Valid values are 0123456789*#ABCDWw. Character W is a 1 second delay, and w is a 500ms delay.")
    @example("1234#")
    digits: string;
  };
}
