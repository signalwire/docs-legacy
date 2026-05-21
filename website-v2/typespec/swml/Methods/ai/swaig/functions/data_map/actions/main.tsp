import "./swml.tsp";
import "./change_context.tsp";
import "./change_step.tsp";
import "./context_switch.tsp";
import "./hangup.tsp";
import "./hold.tsp";
import "./playback_bg.tsp";
import "./say.tsp";
import "./set_global_data.tsp";
import "./set_meta_data.tsp";
import "./stop.tsp";
import "./stop_playback_bg.tsp";
import "./toggle_functions.tsp";
import "./unset_global_data.tsp";
import "./unset_meta_data.tsp";
import "./user_input.tsp";

@summary("Action union")
union Action {
  SWMLAction,
  ChangeContextAction,
  ChangeStepAction,
  ContextSwitchAction,
  HangupAction,
  HoldAction,
  PlaybackBGAction,
  SayAction,
  SetGlobalDataAction,
  SetMetaDataAction,
  StopAction,
  StopPlaybackBGAction,
  ToggleFunctionsAction,
  UnsetGlobalDataAction,
  UnsetMetaDataAction,
  UserInputAction,
}
