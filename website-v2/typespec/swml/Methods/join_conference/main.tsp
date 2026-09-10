import "@typespec/json-schema";
import "../../Shared/Types/main.tsp";
import "../../Methods";

using TypeSpec.JsonSchema;

@summary("JoinConferenceObject object")
model JoinConferenceObject {
  @doc("Name of conference")
  @example("my-conference-room")
  name: string;

  @doc("Whether to join the conference in a muted state. If set to `true`, the participant will be muted upon joining. Default `false`.")
  @example(false)
  muted?: boolean | SWMLVar = false;

  @doc("Sets the behavior of the beep sound when joining or leaving the conference. Default `\"true\"`.")
  @example("onEnter")
  beep?: "true" | "false" | "onEnter" | "onExit" = "true";

  @doc("Starts the conference when the main participant joins. This means the start action will not wait on more participants to join before starting. Default `true`.")
  @example(true)
  start_on_enter?: boolean | SWMLVar = true;

  @doc("Ends the conference when the main participant leaves. This means the end action will not wait on more participants to leave before ending. Default `false`.")
  @example(false)
  end_on_exit?: boolean | SWMLVar = false;

  @doc("A URL that will play media when the conference is put on hold. Default hold music will be played if not set")
  @example("https://example.com/hold-music.mp3")
  wait_url?: url | SWMLVar;

  @doc("The maximum number of participants allowed in the conference. If the limit is reached, new participants will not be able to join. Default `100000`.")
  @minValue(2)
  @maxValue(100000)
  @example(50)
  max_participants?: integer | SWMLVar = 100000;

  @doc("Enables or disables recording of the conference. Default `\"do-not-record\"`.")
  @example("record-from-start")
  record?: "do-not-record" | "record-from-start" = "do-not-record";

  @doc("Specifies the geographical region where the conference will be hosted. Default not set")
  @example("us-east")
  region?: string;

  @doc("If set to `trim-silence`, it will remove silence from the start of the recording. If set to `do-not-trim`, it will keep the silence. Default `\"trim-silence\"`.")
  @example("trim-silence")
  trim?: "trim-silence" | "do-not-trim" = "trim-silence";

  @doc("""
    Coach accepts a call SID of a call that is currently connected to an in-progress conference.
    Specifying a call SID that does not exist or is no longer connected will result in a failure.
    """)
  @example("b3877ee3-6f3c-4985-8066-6d24e3f65e12")
  coach?: string;

  @doc("The events to listen for and send to the status callback URL. Default not set")
  @example("join")
  status_callback_event?:
    | "start"
    | "end"
    | "join"
    | "leave"
    | "mute"
    | "hold"
    | "modify"
    | "speaker"
    | "announcement";

  @doc("The URL to which status events will be sent. This URL must be publicly accessible and able to handle HTTP requests. Default not set")
  @example("https://example.com/conference-status")
  status_callback?: url;

  @doc("The HTTP method to use when sending status events to the status callback URL. Default `\"POST\"`.")
  @example("POST")
  status_callback_method?: "GET" | "POST" = "POST";

  @doc("The URL to which recording status events will be sent. This URL must be publicly accessible and able to handle HTTP requests. Default not set")
  @example("https://example.com/recording-status")
  recording_status_callback?: url;

  @doc("The HTTP method to use when sending recording status events to the recording status callback URL. Default `\"POST\"`.")
  @example("POST")
  recording_status_callback_method?: "GET" | "POST" = "POST";

  @doc("The events to listen for and send to the recording status callback URL. Default not set")
  @example("completed")
  recording_status_callback_event?: "in-progress" | "completed" | "absent";

  @doc("""
    Allows the user to specify a custom action to be executed when the conference result is returned (typically when it has ended). 
    The actions can a `switch` object or a `cond` array.
    The `switch` object allows for conditional execution based on the result of the conference, while
    the `cond` array allows for multiple conditions to be checked in sequence.
    If neither is provided, the default action will be to end the conference.
    """)
  result?: Switch.switch | Cond.cond;
}

@summary("join_conference Method")
model JoinConference {
  @doc("""
    Join an ad-hoc audio conference started on either the SignalWire or Compatibility API.
    This method allows you to connect the current call to a named conference where multiple participants can communicate simultaneously.
    """)
  @summary("join_conference")
  join_conference: JoinConferenceObject;
}
