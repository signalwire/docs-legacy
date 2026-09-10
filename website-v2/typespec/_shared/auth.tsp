import "@typespec/http";
import "@typespec/openapi";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@doc("""
  SignalWire Basic Authentication using Project ID and API Token.
  
  The client sends HTTP requests with the Authorization header containing
  the word Basic followed by a space and a base64-encoded string of project_id:token.
  The project ID will be used as the username and the API token as the password.
  
  Example:
  ```
  Authorization: Basic base64(project_id:token)
  ```
  """)
@extension(
  "x-fern-basic",
  #{
    username: #{ name: "project_id", env: "SIGNALWIRE_PROJECT_ID" },
    password: #{ name: "api_token", env: "SIGNALWIRE_API_TOKEN" },
  }
)
model SignalWireBasicAuth is BasicAuth;

@doc("""
  SignalWire Bearer Token Authentication for subscriber endpoints.
  The client sends HTTP requests with the Authorization header containing
  the word Bearer followed by a space and the subscriber token.
  
  Example:
  ```
  Authorization: Bearer <subscriber_token>
  ```
  """)
model SignalWireBearerAuth is BearerAuth;
