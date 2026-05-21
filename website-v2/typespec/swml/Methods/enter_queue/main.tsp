import "@typespec/json-schema";
import "../../Shared/Types/main.tsp";
import "../../Methods";

using TypeSpec.JsonSchema;

@summary("EnterQueueObject object")
model EnterQueueObject {
  @doc("Name of the queue to enter. If a queue with this name does not exist, it will be automatically created.")
  @example("support-queue")
  queue_name: string;

  @doc("""
    SWML to execute after the bridge completes. This defines what should happen after the call is connected to an agent and the bridge ends.
    Can be either:
    - A URL (http or https) that returns a SWML document
    - An inline SWML document (as a JSON string)
    """)
  @example("https://example.com/post-call-survey")
  transfer_after_bridge: string | SWMLVar;

  @doc("HTTP or HTTPS URL to deliver queue status events. Default not set")
  @example("https://example.com/queue-status")
  status_url?: url;

  @doc("URL for media to play while waiting in the queue. Default hold music will be played if not set")
  @example("https://example.com/queue-music.mp3")
  wait_url?: url | SWMLVar;

  @doc("Maximum time in seconds to wait in the queue before timeout. Default `3600`")
  @minValue(1)
  @example(1800)
  wait_time?: integer | SWMLVar = 3600;
}

@summary("enter_queue Method")
model EnterQueue {
  @doc("""
    Place the current call in a named queue where it will wait to be connected to an available agent or resource.
    While waiting, callers will hear music or custom audio.
    When an agent connects to the queue (using the connect method), the caller and agent are bridged together.
    After the bridge completes, execution continues with the SWML script specified in transfer_after_bridge.
    """)
  @summary("enter_queue")
  enter_queue: EnterQueueObject;
}
