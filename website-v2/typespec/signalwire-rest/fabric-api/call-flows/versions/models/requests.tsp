import "@typespec/http";
import "@typespec/openapi3";

using TypeSpec.OpenAPI;

@oneOf
union CallFlowVersionDeployRequest {
  CallFlowVersionDeployByDocumentVersion,
  CallFlowVersionDeployByVersionId,
}

@summary("Deploy by document version")
model CallFlowVersionDeployByDocumentVersion {
  @doc("The current revision of the call flow.")
  @example(2)
  document_version: int32;
}

@summary("Deploy by version ID")
model CallFlowVersionDeployByVersionId {
  @doc("Any call flow version ID for this call flow.")
  @example("1313fe58-5e14-4c11-bbe7-6fdfa11fe780")
  @format("uuid")
  call_flow_version_id: uuid;
}
