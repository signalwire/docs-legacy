import "@typespec/http";

using TypeSpec.Http;

@doc("Request body for creating a stream.")
model CreateStreamRequest {
  @doc("RTMP or RTMPS URL. This must be the address of a server accepting incoming RTMP/RTMPS streams.")
  @example("rtmp://broadcaster")
  url: string;
}

@doc("Request body for updating a stream.")
model UpdateStreamRequest {
  @doc("RTMP or RTMPS URL. This must be the address of a server accepting incoming RTMP/RTMPS streams.")
  @example("rtmp://broadcaster")
  url: string;
}
