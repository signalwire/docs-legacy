import "../../Methods";

@summary("request Method")
model Request {
  @summary("request")
  @doc("Send a GET, POST, PUT, or DELETE request to a remote URL.")
  request: {
    @doc("URL to send the HTTPS request to. Authentication can also be set in the URL in the format of username:password@url.")
    @example("https://api.example.com/webhook")
    url: string;

    @doc("The HTTP method to be used for the request. Can be `GET`, `POST`, `PUT`, or `DELETE`.")
    @example("POST")
    method: "GET" | "POST" | "PUT" | "DELETE";

    @doc("Object containing HTTP headers to set. Valid header values are Accept, Authorization, Content-Type, Range, and custom X- headers.")
    @example(#{
      `Content-Type`: "application/json",
      Authorization: "Bearer token123",
    })
    headers?: {
      ...TypeSpec.Record<unknown>;
    };

    @doc("""
      Request body. Content-Type header should be explicitly set, but if not set, the most likely type
      will be set based on the first non-whitespace character.
      """)
    @example(#{ action: "notify", message: "Call completed" })
    body?: string | {
      ...TypeSpec.Record<unknown>;
    };

    @doc("""
      Maximum time in seconds to wait for a response.
      Default is `0` (no timeout).
      """)
    @example(10.0)
    timeout?: float | SWMLVar = 0;

    @doc("""
      Maximum time in seconds to wait for a connection.
      Default is `0` (no timeout).
      """)
    @example(5.0)
    connect_timeout?: float | SWMLVar = 0;

    @doc("""
      Store parsed JSON response as variables.
      Default is `false`.
      """)
    @example(true)
    save_variables?: boolean | SWMLVar = false;
  };
}
