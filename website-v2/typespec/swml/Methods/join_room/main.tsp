import "../../Methods";

@summary("join_room Method")
model JoinRoom {
  @doc("Join a RELAY room. If the room doesn't exist, it creates a new room.")
  @summary("join_room")
  join_room: {
    @doc("Name of the room to join. Allowed characters: A-Z, a-z, 0-9, underscore, and hyphen.")
    @example("my-video-room")
    name: string;
  };
}
