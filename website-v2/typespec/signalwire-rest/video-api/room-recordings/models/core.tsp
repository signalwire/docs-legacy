import "@typespec/http";

using TypeSpec.Http;

model RoomRecordingPathID {
  @path
  @format("uuid")
  @doc("Unique ID of the Room Recording.")
  @example("c22d24f6-5a47-4597-9a23-c7d01e696b92")
  id: string;
}
