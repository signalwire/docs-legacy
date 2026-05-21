import "@typespec/http";
import "../../conferences/models/core.tsp";

using TypeSpec.Http;

model ConferenceTokenPathID {
  @path
  @format("uuid")
  @doc("Unique ID of the conference token.")
  @example("c22d24f6-5a47-4597-9a23-c7d01e696b92")
  id: string;
}

@doc("A conference token object.")
model ConferenceToken {
  @doc("Unique identifier for the conference token.")
  @format("uuid")
  @example("c22d24f6-5a47-4597-9a23-c7d01e696b92")
  id: string;

  @doc("Name of the conference token.")
  @example("My First Token")
  name: string | null;

  @doc("Conference token's randomly generated sequence.")
  @example("vpt_62c65414de4d067d07415a7ced8183be")
  token: string;

  @doc("List of permissions.")
  @example(#["room.member.audio_mute"])
  scopes: string[];
}
