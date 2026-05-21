import "./decorator.js";

using TypeSpec.Reflection;
using TypeSpec.OpenAPI;

/** Tag specification for a webhook — either a plain name or name with metadata. */
model WebhookTag {
  /** The tag name. */
  name: string;

  /** A description of the tag. */
  description?: string;

  /** External documentation for the tag. */
  externalDocs?: ExternalDocs;
}

/**
 * Attach an OpenAPI webhook definition to the service namespace.
 *
 * Produces a fully-formed entry in the OpenAPI `webhooks` object with an
 * inline JSON schema derived from the payload model. No post-processing
 * scripts or `$ref` resolution required — the output is valid OpenAPI 3.1.
 *
 * ## Targets
 *
 * | Target | Use case |
 * |--------|----------|
 * | **ModelProperty** | Colocate the webhook with the field that configures it (e.g., `status_url`). The webhook is attached to the service namespace automatically. |
 * | **Namespace** | Attach a webhook directly to the service namespace for events not tied to a specific request field. |
 *
 * ## Metadata from standard decorators
 *
 * The decorator reads metadata from standard TypeSpec decorators on the
 * **payload** model — no need to duplicate strings:
 *
 * | Decorator on payload | OpenAPI field | Fallback |
 * |---------------------|---------------|----------|
 * | `@summary("...")` | `summary` | Humanized webhook name |
 * | `@doc("...")` | `description` | _(none)_ |
 *
 * ## Tag resolution
 *
 * Tags are resolved in this priority order:
 *
 * 1. **Explicit `tag` argument** — a string or `WebhookTag` object passed to the decorator.
 * 2. **Interface `@tag` inheritance** — when placed on a ModelProperty, the decorator traces
 *    upward: property → parent model → interface operation → interface `@tag`. This means
 *    webhooks on request fields automatically inherit the tag of the enclosing interface.
 * 3. **No tag** — if neither source provides a tag, the webhook has no tag.
 *
 * If a tag name is provided (via arg or inheritance) that does not already exist in
 * `@tagMetadata`, it is automatically created in the top-level OpenAPI `tags` array.
 * When using the `WebhookTag` object form, `description` and `externalDocs` are included
 * in the created tag entry.
 *
 * ## Deduplication
 *
 * Duplicate webhook names are no-ops — the first declaration wins. This allows the
 * same webhook to be referenced from multiple request fields (e.g., `transcriptionEvent`
 * used by both `live_transcribe` and `live_translate`) without producing duplicate entries.
 *
 * ## Parameters
 *
 * @param name Webhook key in the OpenAPI `webhooks` object (e.g., `"callStatusCallback"`).
 * @param payload Model whose properties become the webhook request body schema.
 *   Standard decorators on this model (`@summary`, `@doc`, `@example`) are read automatically.
 * @param tag Optional. OpenAPI tag for the webhook. Accepts either:
 *   - A **string**: `"Calls"` or a const like `CALLS_TAG`
 *   - A **WebhookTag object**: `#{ name: "Events", description: "Event callbacks" }`
 *   If omitted, the tag is inherited from the enclosing interface's `@tag` decorator
 *   (ModelProperty targets only). If the tag doesn't exist in `@tagMetadata`, it is created.
 * @param operationId Optional. OpenAPI `operationId` for the webhook. Defaults to
 *   `snake_case(name)` (e.g., `"callStatusCallback"` → `"call_status_callback"`).
 *
 * @example Namespace-level webhook with tag object
 * ```typespec
 * @summary("Service event")
 * @doc("Fired when the API state changes.")
 * model ServiceEventPayload {
 *   event: string;
 *   timestamp: string;
 * }
 *
 * @webhook("serviceEvent", ServiceEventPayload, #{ name: "Events", description: "Event callbacks" })
 * namespace MyAPI;
 * ```
 *
 * @example ModelProperty-level webhook inheriting interface tag
 * ```typespec
 * @summary("Call status callback")
 * @doc("Sent when call status changes.")
 * model CallStatusPayload { call_id: string; status: string; }
 *
 * // Tag is inherited from @tag("Calls") on the Calls interface
 * model CreateCallParams {
 *   @webhook("callStatusCallback", CallStatusPayload)
 *   status_url?: url;
 * }
 *
 * @tag("Calls") interface Calls {
 *   @post create(@body body: CreateCallParams): void;
 * }
 * ```
 *
 * @example ModelProperty-level webhook with explicit tag (string or const)
 * ```typespec
 * const CALLS_TAG = "Calls";
 *
 * model FallbackParams {
 *   @webhook("fallbackEvent", FallbackPayload, CALLS_TAG)
 *   fallback_url?: url;
 * }
 * ```
 */
extern dec webhook(
  target: Namespace | ModelProperty,
  name: valueof string,
  payload: Model,
  tag?: valueof (string | WebhookTag),
  operationId?: valueof string
);
