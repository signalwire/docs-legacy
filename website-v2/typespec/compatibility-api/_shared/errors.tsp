using TypeSpec.Http;

@doc("Error response model.")
model CompatibilityErrorResponse {
  @doc("Error code.")
  @example(20003)
  code: int32;

  @doc("Error message.")
  @example("Authentication failed")
  message: string;

  @doc("URL for more information about the error.")
  @example("https://signalwire.com/docs/compatibility-api/reference/errors")
  more_info: string;

  @doc("HTTP status code.")
  @example(401)
  status: int32;
}

@doc("Error item in the errors array format.")
model CompatibilityErrorArrayItem {
  @doc("The numeric string identifying the API error code")
  @example("30010")
  code?: string;

  @doc("Error text")
  @example("Maxpriceperminute was exceeded. This call's cost is 0.008 per minute.")
  message?: string;

  @doc("Url for more information on error code")
  @example("https://signalwire.com/docs/rest/compatibility-api/error-codes")
  more_info?: string;
}

@doc("Error response with errors array format.")
model CompatibilityErrorArrayResponse {
  @doc("A list of errors")
  errors?: CompatibilityErrorArrayItem[];
}

@doc("The request was invalid or cannot be processed. Check the error details for more information.")
model CompatibilityStatusCode400 {
  @statusCode statusCode: 400;
  @body error: CompatibilityErrorResponse;
}

@doc("The request was invalid. Review the errors array for specific issues with your request.")
model CompatibilityStatusCode400Array {
  @statusCode statusCode: 400;
  @body body: CompatibilityErrorArrayResponse;
}

@doc("Authentication failed. Please verify your credentials and try again.")
model CompatibilityStatusCode401 {
  @statusCode statusCode: 401;
  @body error: CompatibilityErrorResponse;
}

@doc("The requested resource was not found. Please verify the resource identifier.")
model CompatibilityStatusCode404 {
  @statusCode statusCode: 404;
  @body error: CompatibilityErrorResponse;
}

@doc("The request could not be processed due to validation errors. Check the error details for more information.")
model CompatibilityStatusCode422 {
  @statusCode statusCode: 422;
  @body error: CompatibilityErrorResponse;
}

@doc("Error response with errors array of strings format.")
model CompatibilityErrorStringArrayResponse {
  @doc("List of validation error messages.")
  @example(#["Validation error message"])
  errors: string[];
}

@doc("The request could not be processed due to validation errors. Review the errors array for specific issues.")
model CompatibilityStatusCode422StringArray {
  @statusCode statusCode: 422;
  @body body: CompatibilityErrorStringArrayResponse;
}

@doc("204 No Content response.")
model CompatibilityStatusCode204 {
  @statusCode statusCode: 204;
}

@doc("Token validation error response model.")
model CompatibilityTokenValidationError {
  @doc("Error type.")
  type?: string;

  @doc("Error code.")
  code?: string;

  @doc("Error message.")
  message?: string;

  @doc("Request parameter associated with this error.")
  attribute?: string;

  @doc("Link to developer resource for this error.")
  @format("uri")
  url?: string;
}

@doc("The token request could not be processed due to validation errors. Check the error details for the specific issue.")
model CompatibilityStatusCode422Token {
  @statusCode statusCode: 422;
  @body body: CompatibilityTokenValidationError;
}

@doc("Error response model with string code for ImportedPhoneNumbers.")
model CompatibilityImportedPhoneNumberError {
  @doc("The error code.")
  @example("10000")
  code?: string;

  @doc("A human-readable error message.")
  @example("Number type can't be blank")
  message?: string;

  @doc("A URL to more information about the error.")
  @example("https://signalwire.com/docs/rest/compatibility-api/overview/error-codes")
  more_info?: string;

  @doc("The HTTP status code.")
  @example(400)
  status?: int32;
}

@doc("The phone number import request could not be processed due to validation errors. Check the error details for more information.")
model CompatibilityStatusCode422ImportedPhoneNumber {
  @statusCode statusCode: 422;
  @body body: CompatibilityImportedPhoneNumberError;
}

@doc("The request conflicts with the current state of the resource. The operation cannot be completed.")
model CompatibilityStatusCode409 {
  @statusCode statusCode: 409;
  @body error: CompatibilityErrorResponse;
}

@doc("The service is temporarily unavailable. Please try again later.")
model CompatibilityStatusCode503 {
  @statusCode statusCode: 503;
  @body error: CompatibilityErrorResponse;
}
