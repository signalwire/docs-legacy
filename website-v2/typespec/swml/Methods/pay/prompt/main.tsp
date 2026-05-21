import "@typespec/json-schema";
import "./actions.tsp";

using TypeSpec.JsonSchema;

model PayPrompts {
  @doc("Array of action objects to execute for this prompt. These actions can either play an audio file or speak a phrase.")
  actions: PayPromptAction[];

  @doc("""
    The payment step this prompt is for. See Payment Steps for a list of available steps.
    
    - `payment-card-number`: Collect the payment card number.
    - `expiration-date`: Collect the payment card expiration date.
    - `security-code`: Collect the payment card security code.
    - `postal-code`: Collect the payment card postal code.
    - `payment-processing`: The step used during the payment processing.
    - `payment-completed`: The step used when the payment is completed.
    - `payment-failed`: The step used when the payment fails.
    - `payment-cancelled`: The step used when the payment is cancelled.
    """)
  @example("payment-card-number")
  for: string;

  @doc("""
    Specifies which payment attempt(s) this prompt applies to. The value increments when a payment fails.
     Use a single number (e.g., "1") or space-separated numbers (e.g., "2 3") to target the specific attempts.
    """)
  @example("1 2")
  attempts?: string;

  @doc("""
    Space-seperated list of card types that are allowed to be used for this prompt.
    
    Supported card types:
        - `visa`
        - `mastercard`
        - `amex`
        - `maestro`
        - `discover`
        - `optima`
        - `jcb`
        - `diners-club`
    """)
  @example("visa mastercard amex")
  card_type?: string;

  @doc("""
    Space-separated list of error types this prompt applies to.
    
    Available error types:
        - `timeout` - User input timeout
        - `invalid-card-number` - Failed card validation
        - `invalid-card-type` - Unsupported card type
        - `invalid-date` - Invalid expiration date
        - `invalid-security-code` - Invalid CVV format
        - `invalid-postal-code` - Invalid postal code format
        - `invalid-bank-routing-number` - Invalid bank routing number
        - `invalid-bank-account-number` - Invalid bank account number
        - `input-matching-failed` - Input matching failed
        - `session-in-progress` - Concurrent session attempt
        - `card-declined` - Payment declined
    """)
  @example("timeout invalid-card-number")
  error_type?: string;
}
