import { setExtension, getExtensions, getTagsMetadata } from "@typespec/openapi";

// ── String helpers ───────────────────────────────────────────────────

function toSnakeCase(str) {
  return str.replace(/([A-Z])/g, "_$1").toLowerCase().replace(/^_/, "");
}

function toHumanReadable(str) {
  const words = str.replace(/([A-Z])/g, " $1").trim().split(/\s+/);
  return words
    .map((w, i) => (i === 0 ? w.charAt(0).toUpperCase() + w.slice(1).toLowerCase() : w.toLowerCase()))
    .join(" ");
}

// ── Decorator reading ────────────────────────────────────────────────

function getDecoratorArg(type, decoratorName) {
  for (const dec of type.decorators || []) {
    if (dec.definition?.name === decoratorName) {
      return dec.args?.[0]?.jsValue;
    }
  }
  return undefined;
}

// ── Schema serialization ─────────────────────────────────────────────

function modelToJsonSchema(model, seen) {
  if (!seen) seen = new Set();
  if (seen.has(model)) return { type: "object" };
  seen.add(model);

  const properties = {};
  const required = [];

  for (const [name, prop] of model.properties) {
    const schema = typeToSchema(prop.type, seen);
    const doc = getDecoratorArg(prop, "@doc");
    if (doc) schema.description = doc;
    const example = getDecoratorArg(prop, "@example");
    if (example !== undefined) schema.example = example;
    properties[name] = schema;
    if (!prop.optional) required.push(name);
  }

  const result = { type: "object", properties };
  if (required.length > 0) result.required = required;
  const doc = getDecoratorArg(model, "@doc");
  if (doc) result.description = doc;

  seen.delete(model);
  return result;
}

function typeToSchema(type, seen) {
  if (!seen) seen = new Set();

  switch (type.kind) {
    case "Scalar": {
      const n = type.name;
      if (n === "string" || n === "url") return { type: "string" };
      if (n === "boolean") return { type: "boolean" };
      if (["int32", "int64", "integer", "uint32", "uint64"].includes(n)) return { type: "integer" };
      if (["float", "float32", "float64", "numeric"].includes(n)) return { type: "number" };
      if (n === "utcDateTime") return { type: "string", format: "date-time" };
      if (type.baseScalar) return typeToSchema(type.baseScalar, seen);
      return { type: "string" };
    }
    case "Intrinsic":
      return type.name === "null" ? { type: "null" } : {};
    case "Union": {
      const variants = [...type.variants.values()];
      const nullVariant = variants.find((v) => v.type.kind === "Intrinsic" && v.type.name === "null");
      const nonNull = variants.filter((v) => !(v.type.kind === "Intrinsic" && v.type.name === "null"));

      if (nonNull.every((v) => v.type.kind === "String") && nonNull.length > 0) {
        const schema = { type: "string", enum: nonNull.map((v) => v.type.value) };
        return nullVariant ? { oneOf: [schema, { type: "null" }] } : schema;
      }

      const schemas = variants.map((v) => typeToSchema(v.type, seen));
      if (schemas.length === 2 && nullVariant) {
        const s = schemas.find((s) => s.type !== "null");
        if (s) return { ...s, nullable: true };
      }
      return { oneOf: schemas };
    }
    case "String":
      return { type: "string", enum: [type.value] };
    case "Number":
      return { type: "number", enum: [type.value] };
    case "Boolean":
      return { type: "boolean", enum: [type.value] };
    case "Model": {
      if (type.indexer?.key?.name === "integer") {
        return { type: "array", items: type.indexer.value ? typeToSchema(type.indexer.value, seen) : {} };
      }
      return modelToJsonSchema(type, seen);
    }
    case "Enum":
      return { type: "string", enum: [...type.members.values()].map((m) => m.value ?? m.name) };
    default:
      return {};
  }
}

// ── Namespace resolution ─────────────────────────────────────────────

function findServiceNamespace(target, program) {
  // Walk up from the target
  let current = target;
  while (current) {
    if (current.kind === "Namespace" && current.decorators?.some((d) => d.definition?.name === "@service")) {
      return current;
    }
    current =
      current.kind === "ModelProperty" ? current.model :
      current.kind === "Model" ? (current.namespace || current.model) :
      current.namespace ?? null;
  }

  // Fallback: search all top-level namespaces
  for (const ns of program.checker.getGlobalNamespaceType().namespaces.values()) {
    if (ns.decorators?.some((d) => d.definition?.name === "@service")) return ns;
  }
  return null;
}

// ── Tag creation ────────────────────────────────────────────────────

function ensureTag(program, namespace, tagName, tagMetadata) {
  const tags = getTagsMetadata(program, namespace);
  if (!tags) return;
  if (tags[tagName]) return;
  tags[tagName] = tagMetadata || {};
}

// ── Tag resolution (deferred to $onValidate) ─────────────────────────

const pendingTags = [];

function collectModelsFromType(type, models, seen) {
  if (!type || seen.has(type)) return;
  seen.add(type);

  if (type.kind === "Model") {
    models.add(type);
    for (const prop of type.properties?.values() || []) collectModelsFromType(prop.type, models, seen);
    for (const src of type.sourceModels || []) collectModelsFromType(src.model, models, seen);
    if (type.baseModel) collectModelsFromType(type.baseModel, models, seen);
  } else if (type.kind === "Union") {
    for (const v of type.variants?.values() || []) collectModelsFromType(v.type, models, seen);
  }
}

function buildModelTagMap(ns, map) {
  if (!map) map = new Map();

  for (const iface of ns.interfaces?.values() || []) {
    const tag = getDecoratorArg(iface, "@tag");
    if (!tag) continue;
    for (const op of iface.operations?.values() || []) {
      const models = new Set();
      const seen = new Set();
      for (const param of op.parameters?.properties?.values() || []) {
        collectModelsFromType(param.type, models, seen);
      }
      for (const model of models) {
        if (!map.has(model)) map.set(model, tag);
      }
    }
  }

  for (const child of ns.namespaces?.values() || []) buildModelTagMap(child, map);
  return map;
}

// ── Decorator entry point ────────────────────────────────────────────

function parseTag(tag) {
  if (!tag) return null;
  if (typeof tag === "string") return { name: tag };
  return tag;
}

export function $webhook(context, target, name, payload, tag, operationId) {
  const namespace = findServiceNamespace(target, context.program);
  if (!namespace) return;

  // Deduplicate — first declaration wins
  const existing = getExtensions(context.program, namespace).get("webhooks");
  if (existing?.[name]) return;

  const post = {
    operationId: operationId ?? toSnakeCase(name),
    summary: getDecoratorArg(payload, "@summary") ?? toHumanReadable(name),
    requestBody: {
      required: true,
      content: { "application/json": { schema: modelToJsonSchema(payload) } },
    },
    responses: { 200: { description: "Webhook received" } },
  };

  const description = getDecoratorArg(payload, "@doc");
  if (description) post.description = description;

  // Tag resolution deferred to $onValidate — @tagMetadata not yet available at decorator time
  pendingTags.push({ post, target, namespace, explicitTag: parseTag(tag) });

  setExtension(context.program, namespace, "webhooks", { ...(existing || {}), [name]: { post } });
}

// ── $onValidate: resolve tags after all types are ready ──────────────

export function $onValidate(program) {
  if (pendingTags.length === 0) return;

  const cache = new Map();
  for (const { post, target, namespace, explicitTag } of pendingTags) {
    let tagName;
    let tagMetadata;

    if (explicitTag) {
      tagName = explicitTag.name;
      const { name: _, ...meta } = explicitTag;
      tagMetadata = Object.keys(meta).length > 0 ? meta : undefined;
    } else {
      if (!cache.has(namespace)) cache.set(namespace, buildModelTagMap(namespace));
      const model = target.kind === "ModelProperty" ? target.model : null;
      tagName = model ? cache.get(namespace).get(model) : undefined;
    }

    if (tagName) {
      post.tags = [tagName];
      ensureTag(program, namespace, tagName, tagMetadata);
    }
  }

  pendingTags.length = 0;
}
