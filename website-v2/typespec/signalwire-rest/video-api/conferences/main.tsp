import "@typespec/http";
import "@typespec/openapi";
import "../../types/status-codes";
import "../tags.tsp";
import "../_shared/models.tsp";
import "../_shared/errors.tsp";
import "../streams/models/core.tsp";
import "../streams/models/requests.tsp";
import "../streams/models/responses.tsp";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/conferences")
namespace VideoAPI.Conferences {
  @tag(CONFERENCES_TAG)
  @friendlyName("Conferences")
  interface Conferences {
    @operationId("create_video_conference")
    @summary("Create a Video Conference")
    @doc("Create a Video Conference.\n\n${tokenPermissions<"_Video_">}")
    @post
    create(@body body: CreateConferenceRequest):
      | ConferenceResponse
      | StatusCode400
      | StatusCode401
      | VideoStatusCode422
      | StatusCode500;

    @operationId("list_video_conferences")
    @summary("List Video Conferences")
    @doc("List Video Conferences.\n\n${tokenPermissions<"_Video_">}")
    list(...ListConferencesRequest):
      | ListConferencesResponse
      | StatusCode400
      | StatusCode401
      | VideoStatusCode422
      | StatusCode500;

    @operationId("get_video_conference")
    @summary("Find a Video Conference by ID")
    @doc("Find a Video Conference by ID.\n\n${tokenPermissions<"_Video_">}")
    @route("/{id}")
    read(
      ...ConferencePathID,

      @query
      @doc("Specifies whether to include information about the conference's active session (if any).")
      @example(true)
      include_active_session?: boolean,
    ):
      | ConferenceResponse
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | VideoStatusCode422
      | StatusCode500;

    @operationId("update_video_conference")
    @summary("Update a Video Conference")
    @doc("Update a Video Conference.\n\n${tokenPermissions<"_Video_">}")
    @route("/{id}")
    @put
    update(
      ...ConferencePathID,

      @body body: UpdateConferenceRequest,
    ):
      | ConferenceResponse
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | VideoStatusCode422
      | StatusCode500;

    @operationId("delete_video_conference")
    @summary("Delete a Video Conference")
    @doc("Delete a Video Conference.\n\n${tokenPermissions<"_Video_">}")
    @route("/{id}")
    @delete
    delete(
      ...ConferencePathID,
    ):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}

@route("/conferences/{id}/streams")
namespace VideoAPI.ConferenceStreams {
  @tag(STREAMS_TAG)
  @friendlyName("Conference Streams")
  interface ConferenceStreams {
    @operationId("list_conference_streams")
    @summary("List Streams by Conference")
    @doc("${tokenPermissions<"_Video_">}")
    list(
      @path
      @doc("Unique id of a video conference")
      @example("fe4093d9-58c2-4931-b4b9-5679f82652c6")
      id: string,
    ): ListStreamsResponse | StatusCode401 | VideoStatusCode422 | StatusCode500;

    @operationId("create_conference_stream")
    @summary("Create a Stream for a Conference")
    @doc("${tokenPermissions<"_Video_">}")
    @post
    create(
      @path
      @doc("Unique id of a video conference")
      @example("fe4093d9-58c2-4931-b4b9-5679f82652c6")
      id: string,

      @body body: CreateStreamRequest,
    ): StreamResponse | StatusCode401 | VideoStatusCode422 | StatusCode500;
  }
}
