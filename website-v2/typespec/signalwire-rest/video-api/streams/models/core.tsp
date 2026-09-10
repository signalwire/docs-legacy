import "@typespec/http";

using TypeSpec.Http;

model StreamPathID {
  @path
  @format("uuid")
  @doc("Unique ID of the stream.")
  @example("c22d24f6-5a47-4597-9a23-c7d01e696b92")
  id: string;
}

model RoomPathID {
  @path
  @format("uuid")
  @doc("Unique ID of the video room.")
  @example("fe4093d9-58c2-4931-b4b9-5679f82652c6")
  id: string;
}

@doc("A video stream object.")
model Stream {
  @doc("Unique identifier for the stream.")
  @format("uuid")
  @example("c22d24f6-5a47-4597-9a23-c7d01e696b92")
  id: string;

  @doc("RTMP or RTMPS URL. This must be the address of a server accepting incoming RTMP/RTMPS streams.")
  @example("rtmp://broadcaster")
  url: string | null;

  @doc("The type of stream.")
  @example("rtmp")
  stream_type: string | null;

  @doc("The stream's width in pixels.")
  @example(1920)
  width: int32 | null;

  @doc("The stream's height in pixels.")
  @example(1080)
  height: int32 | null;

  @doc("The stream's frames per second.")
  @example(20)
  fps: int32 | null;

  @doc("Timestamp when the stream was created.")
  @example(utcDateTime.fromISO("2022-01-01T10:00:00Z"))
  created_at: utcDateTime;

  @doc("Timestamp when the stream was last updated.")
  @example(utcDateTime.fromISO("2022-01-01T11:00:00Z"))
  updated_at: utcDateTime;
}
