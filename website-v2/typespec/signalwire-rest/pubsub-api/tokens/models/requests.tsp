import "@typespec/json-schema";

using TypeSpec.JsonSchema;

/* Model is used to work-around a bug in the rest api plugin, not a TypeSpec issue. Duplicate description must be present and usage of a model is required.
Otherwise the property will render a additionalProperty with the exact same description as the top level property holding additionalProperties. */
@doc("An arbitrary JSON object available to store stateful application information in. Must be valid JSON and have a maximum size of 2,000 characters.")
@example(#{ display_name: "Joe", an_array: #["foo", "bar", "baz"] })
model PubSubState is Record<unknown>;

model NewPubSubToken {
  @minValue(1)
  @maxValue(43200)
  @example(15)
  @doc("The maximum time, in minutes, for which the access token will be valid. Between 1 and 43,200 (30 days).")
  ttl: integer;

  @minProperties(1)
  @maxProperties(500)
  @doc("""
    Each channel with `write` and `read` objects with boolean as values. Max of 500 channels inside main `channels`.
    Either `read`, `write`, or both are required inside each channel and default to false.
    Each channel name can be up to 250 characters. Must be valid JSON.
    """)
  @example(#{
    channela: #{ read: true, write: false },
    channelb: #{ read: true },
  })
  channels: PubSubChannels;

  @doc("The unique identifier of the member. Up to 250 characters. If not specified, a random UUID will be generated.")
  @example("John Doe")
  @maxLength(250)
  member_id?: string;

  /* Model is used to work-around a bug in the rest api plugin, not a TypeSpec issue. Duplicate description must be present and usage of a model is required.
    Otherwise the property will render a additionalProperty with the exact same description as the top level property holding additionalProperties. */
  @doc("An arbitrary JSON object available to store stateful application information in. Must be valid JSON and have a maximum size of 2,000 characters.")
  @example(#{ display_name: "Joe", an_array: #["foo", "bar", "baz"] })
  state?: PubSubState = #{};
}

@doc("""
  User-defined channel names. Each channel is an object with `read` and/or `write` properties.
  Max of 500 channels. Either `read`, `write`, or both are required inside each channel and default to `false`.
  Each channel name can be up to 250 characters. Must be valid JSON.
  """)
@example(#{
  channela: #{ read: true, write: false },
  channelb: #{ read: true },
})
model PubSubChannels is Record<PubSubPermission>;

@summary("Read Permission")
model PubSubPermissionWithRead {
  @doc("Gives the token read access to the channel.")
  @example(true)
  read: boolean;

  @doc("Gives the token write access to the channel.")
  @example(false)
  write?: boolean;
}

@summary("Write Permission")
model PubSubPermissionWithWrite {
  @doc("Gives the token read access to the channel.")
  @example(true)
  read?: boolean;

  @doc("Gives the token write access to the channel.")
  @example(false)
  write: boolean;
}

alias PubSubPermission = PubSubPermissionWithRead | PubSubPermissionWithWrite;
