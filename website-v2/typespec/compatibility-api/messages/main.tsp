import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "./models/webhooks.tsp";
import "../_shared/errors.tsp";
import "../tags.tsp";
import "../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@route("/Accounts/{AccountSid}/Messages")
namespace CompatibilityAPI.Messages {
  @tag(MESSAGES_TAG)
  @friendlyName("Messages")
  interface Messages {
    @operationId("list_messages")
    @summary("List all Messages")
    @doc("""
      List all messages.
      
      ${tokenPermissions<"_Messaging_">}
      """)
    list(
      ...MessagesAccountSidPath,

      @query
      @doc("Only return messages sent on this particular date, formatted as YYYY-MM-DD in UTC.")
      @example("2024-01-15")
      DateSent?: string,

      @query("DateSent<")
      @doc("Only return messages sent before this date, formatted as YYYY-MM-DD in UTC.")
      @example("2024-01-15")
      DateSentBefore?: string,

      @query("DateSent>")
      @doc("Only return messages sent after this date, formatted as YYYY-MM-DD in UTC.")
      @example("2024-01-01")
      DateSentAfter?: string,

      @query
      @doc("The phone number in E.164 format. For inbound messages, this will be the remote phone number who sent the message. For outbound messages, this will be one of your SignalWire phone numbers.")
      @example("+15551234567")
      From?: string,

      @query
      @doc("The phone number in E.164 format that received the message. For inbound messages, this is one of your SignalWire phone numbers; for outbound messages, this is the remote phone number that received the message.")
      @example("+15557654321")
      To?: string,

      @query
      @doc("Current status of the message.")
      @example(MessageStatus.Delivered)
      Status?: MessageStatus,

      @query
      @doc("The page number to retrieve. Default is 0.")
      @minValue(0)
      @example(0)
      Page?: int32 = 0,

      @query
      @doc("The number of items per page. Default is 50, maximum is 1000.")
      @minValue(1)
      @maxValue(1000)
      @example(50)
      PageSize?: int32 = 50,

      @query
      @doc("The token for cursor-based pagination. Must start with 'PA' or 'PB'.")
      @example("PAb3877c40da604998")
      PageToken?: string,
    ):
      | MessageListResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422;

    @operationId("create_message")
    @summary("Create a Message")
    @doc("""
      Create and send a message.
      
      ${tokenPermissions<"_Messaging_">}
      """)
    @post
    create(
      ...MessagesAccountSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: CreateMessageRequest,
    ):
      | MessageCreatedResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422;

    @operationId("retrieve_message")
    @summary("Retrieve a Message")
    @doc("""
      Retrieve a single message.
      
      ${tokenPermissions<"_Messaging_">}
      """)
    @route("/{Sid}")
    read(...MessagesAccountSidPath, ...MessageSidPath):
      | MessageResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404;

    @operationId("update_message")
    @summary("Update a Message")
    @doc("""
      Update a message body after it has been sent. Currently, the only supported update is redacting the message by setting the body to an empty string. Messages that are still in progress (queued or initiated status) cannot be updated.
      
      ${tokenPermissions<"_Messaging_">}
      """)
    @post
    @route("/{Sid}")
    update(
      ...MessagesAccountSidPath,
      ...MessageSidPath,
      @header contentType: "application/x-www-form-urlencoded",
      @body body: UpdateMessageRequest,
    ):
      | MessageResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422;

    @operationId("delete_message")
    @summary("Delete a Message")
    @doc("""
      Delete a message. Messages that are still in progress (queued status) cannot be deleted.
      
      ${tokenPermissions<"_Messaging_">}
      """)
    @delete
    @route("/{Sid}")
    delete(...MessagesAccountSidPath, ...MessageSidPath):
      | CompatibilityStatusCode204
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422;
  }

  @tag(MESSAGE_MEDIA_TAG)
  @friendlyName("Message Media")
  @route("/{MessageSid}/Media")
  interface MessageMedia {
    @operationId("list_media")
    @summary("List Message Media")
    @doc("""
      List all media for a message.
      
      ${tokenPermissions<"_Messaging_">}
      """)
    list(
      ...MessagesAccountSidPath,
      ...MessageSidPathForMedia,

      @query
      @doc("Only return media created on this particular date, formatted as YYYY-MM-DD in UTC.")
      @example("2024-01-15")
      DateCreated?: string,

      @query("DateCreated<")
      @doc("Only return media created before this date, formatted as YYYY-MM-DD in UTC.")
      @example("2024-01-15")
      DateCreatedBefore?: string,

      @query("DateCreated>")
      @doc("Only return media created after this date, formatted as YYYY-MM-DD in UTC.")
      @example("2024-01-01")
      DateCreatedAfter?: string,

      @query
      @doc("The page number to retrieve. Default is 0.")
      @minValue(0)
      @example(0)
      Page?: int32 = 0,

      @query
      @doc("The number of items per page. Default is 50, maximum is 1000.")
      @minValue(1)
      @maxValue(1000)
      @example(50)
      PageSize?: int32 = 50,

      @query
      @doc("The token for cursor-based pagination. Must start with 'PA' or 'PB'.")
      @example("PAb3877c40da604998")
      PageToken?: string,
    ):
      | MessageMediaListResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode422;

    @operationId("retrieve_media")
    @summary("Retrieve Message Media")
    @doc("""
      Retrieve media for a message.
      
      ${tokenPermissions<"_Messaging_">}
      """)
    @route("/{Sid}")
    read(
      ...MessagesAccountSidPath,
      ...MessageSidPathForMedia,
      ...MessageSidPath,
    ):
      | MessageMediaResponse
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404;

    @operationId("delete_message_media")
    @summary("Delete Message Media")
    @doc("""
      Delete media for a message. Media cannot be deleted if the parent message is still in progress (initiated or queued status).
      
      ${tokenPermissions<"_Messaging_">}
      """)
    @delete
    @route("/{Sid}")
    delete(
      ...MessagesAccountSidPath,
      ...MessageSidPathForMedia,
      ...MessageSidPath,
    ):
      | CompatibilityStatusCode204
      | CompatibilityStatusCode400
      | CompatibilityStatusCode401
      | CompatibilityStatusCode404
      | CompatibilityStatusCode422;
  }
}
