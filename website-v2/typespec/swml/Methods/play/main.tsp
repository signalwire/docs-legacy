import "@typespec/json-schema";
import "../../Shared/Types/main.tsp";

using TypeSpec.JsonSchema;

@pattern("^(http://.*|https://.*|ring: ?[0-9.]*: ?[a-zA-Z]{2}|say: ?.*|silence: ?[0-9.]*|ring: ?[a-zA-Z]{2})$")
scalar play_url extends string;

@summary("PlayBase object")
model PlayBase {
  @doc("If `true`, the call will automatically answer as the sound is playing. If `false`, you will start playing the audio during early media. Default `true`.")
  @example(true)
  auto_answer?: boolean | SWMLVar = true;

  @doc("""
    Volume level for the audio file.
    Default is `0`.
    Valid range is -40 to 40.
    """)
  @minValue(-40)
  @maxValue(40)
  @example(10)
  volume?: float | SWMLVar = 0;

  @doc("The voice to use for the text to speech.")
  @example("Polly.Joanna")
  say_voice?: string = "Polly.Salli";

  @doc("The language to use for the text to speech.")
  @example("en-US")
  say_language?: string = "en-US";

  @doc("Gender to use for the text to speech.")
  @example("female")
  say_gender?: string = "female";

  @doc("http or https URL to deliver play status events")
  @example("https://example.com/play-status")
  status_url?: url;
}

@summary("Single URL")
@doc("Play with a single URL")
model PlayWithURL is PlayBase {
  @doc("""
    URL to play.
    Required if `urls` is not present.
    Allowed URLs are:
        - http:// or https:// - audio file to GET
        - ring:[duration:]<country code> - ring tone to play. For example: ring:us to play single ring or ring:20.0:us to play ring for 20 seconds.
        - say:<text to speak> - Sentence to say
        - silence: <duration> - seconds of silence to play
    """)
  @example("https://example.com/welcome.mp3")
  url: play_url | SWMLVar;
}

@summary("Multiple URLs")
model PlayWithURLS is PlayBase {
  @doc("""
    Array of URLs to play.
    Required if `url` is not present.
    Allowed URLs are:
        - http:// or https:// - audio file to GET
        - ring:[duration:]<country code> - ring tone to play. For example: ring:us to play single ring or ring:20.0:us to play ring for 20 seconds.
        - say:<text to speak> - Sentence to say
        - silence: <duration> - seconds of silence to play
    """)
  @example(#[
    "https://example.com/intro.mp3",
    "say:Welcome to our service",
    "silence:2"
  ])
  urls: play_url[] | SWMLVar[];
}

alias PlayUnion = PlayWithURL | PlayWithURLS;

@summary("play Method")
model Play {
  @oneOf
  @summary("play")
  @doc("Play file(s), ringtones, speech or silence.")
  play: PlayUnion;
}
