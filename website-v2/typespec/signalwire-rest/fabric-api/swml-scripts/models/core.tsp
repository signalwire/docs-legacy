import "../../../types";
import "../../_shared/const.tsp";
import "../../_shared/enums.tsp";

using TypeSpec.Http;

model SwmlScriptPathID {
  @doc("Unique ID of a SWML Script.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  @path
  id: uuid;
}

model SwmlScript {
  @doc("Unique ID of a SWML Script.")
  @example("3fa85f64-5717-4562-b3fc-2c963f66afa6")
  @format("uuid")
  id: uuid;

  @doc("The SWML script contents")
  @example(SWML_EXAMPLE)
  contents: string;

  @doc("The url where the SWML script is hosted at.")
  @example("https://example.com/swml_script")
  request_url: url;

  @doc("The displayed name of the SWML scipt")
  @example("Booking Assistant")
  display_name: string;

  @doc("URL to send status callbacks to")
  @example("https://website.com/status")
  @format("uri")
  status_callback_url?: url;

  @doc("HTTP method to use for status callbacks")
  @example(UrlMethodType.Post)
  status_callback_method?: UrlMethodType.Post;
}
