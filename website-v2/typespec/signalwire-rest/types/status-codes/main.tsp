import "@typespec/http";

using TypeSpec.Http;

namespace Types.StatusCodes {
  // ============================================================================
  // Base Error Models (reusable across all APIs)
  // ============================================================================

  @doc("Access is unauthorized.")
  @error
  model StatusCode401 {
    @statusCode statusCode: 401;
    error: "Unauthorized";
  }

  @doc("Access is forbidden.")
  @error
  model StatusCode403 {
    @statusCode statusCode: 403;
    error: "Forbidden";
  }

  @doc("The server cannot find the requested resource.")
  @error
  model StatusCode404 {
    @statusCode statusCode: 404;
    error: "Not Found";
  }

  @doc("An internal server error occurred.")
  @error
  model StatusCode500 {
    @statusCode statusCode: 500;
    error: "Internal Server Error";
  }

  @doc("The request is invalid.")
  @error
  model StatusCode400 {
    @statusCode statusCode: 400;
    error: "Bad Request";
  }

  // ============================================================================
  // Space API / Applications Error Format
  // Used by: /api/relay/rest, /api/rest/applications
  // Format: { errors: [{ detail, status, title, code }] }
  // ============================================================================

  @doc("Details about a specific validation error.")
  model SpaceApiErrorItem {
    @doc("A description of what caused the error.")
    @example("Label can't be blank")
    detail: string;

    @doc("The HTTP status code.")
    @example("422")
    status: string;

    @doc("A short summary of the error type.")
    @example("Invalid Attribute")
    title: string;

    @doc("The error code.")
    @example("422")
    code: string;
  }

  @doc("The request failed validation. See errors for details.")
  @error
  model ValidationError {
    @statusCode statusCode: 422;

    @doc("List of validation errors.")
    errors: SpaceApiErrorItem[];
  }

  // ============================================================================
  // REST/Fabric API Error Format (APIErrors::GenerateResponse)
  // Used by: /api/rest/*, /api/fabric/*, /api/private/*
  // Format: { errors: [{ type, code, message, attribute, url }] }
  // ============================================================================

  @doc("Details about a specific error.")
  model RestApiErrorItem {
    @doc("The category of error.")
    @example("validation_error")
    type: string;

    @doc("A specific error code.")
    @example("invalid_parameter")
    code: string;

    @doc("A description of what caused the error.")
    @example("Name must be present")
    message: string;

    @doc("The request parameter that caused the error, if applicable.")
    @example("name")
    attribute?: string | null;

    @doc("A link to documentation about this error.")
    @example("https://signalwire.com/docs/apis/error-codes")
    url: string;
  }

  @doc("The request failed validation. See errors for details.")
  @error
  model RestApiValidationError {
    @statusCode statusCode: 422;

    @doc("List of validation errors.")
    errors: RestApiErrorItem[];
  }

  @doc("The request contains invalid parameters. See errors for details.")
  model StatusCode422 is RestApiValidationError;

  // ============================================================================
  // Compatibility API Error Format (Twilio-compatible)
  // Used by: /api/laml
  // Format: { code, message, more_info, status } (flat, no array)
  // ============================================================================

  @doc("The request failed. See the message for details.")
  @error
  model CompatibilityApiError {
    @statusCode statusCode: 400;

    @doc("The error code.")
    @example("10000")
    code: string;

    @doc("A description of what caused the error.")
    @example("A required parameter is missing.")
    message: string;

    @doc("A link to documentation about this error.")
    @example("https://signalwire.com/docs/compatibility-api/reference/error-codes")
    more_info: string;

    @doc("The HTTP status code.")
    @example(400)
    status: int32;
  }
}
