import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "./models/errors.tsp";
import "../../types";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

namespace DatasphereAPI.Documents {
  @route("/documents")
  @tag(DOCUMENTS_TAG)
  interface Documents {
    @operationId("list_documents")
    @doc("""
      A list of Datasphere Documents.
      
      ${tokenPermissions<"_DataSphere_">}
      """)
    @summary("List Documents")
    list(...DocumentListQuery):
      | DocumentListResponse
      | StatusCode400
      | StatusCode401
      | ListStatusCode422
      | StatusCode500;

    @operationId("get_document")
    @doc("""
      Retrieves a Datasphere Document by ID.
      
      ${tokenPermissions<"_DataSphere_">}
      """)
    @summary("Get a Document")
    @route("/{id}")
    get(...PathID):
      | {
          @statusCode statusCode: 200;
          @body document: Document;
        }
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("create_document")
    @doc("""
      Creates a Datasphere Document.
      
      ${tokenPermissions<"_DataSphere_">}
      """)
    @summary("Create a Document")
    @post
    create(@body body: DocumentCreateRequest):
      | {
          @statusCode statusCode: 201;
          @body document: Document;
        }
      | StatusCode400
      | StatusCode401
      | CreateStatusCode422
      | StatusCode500;

    @operationId("update_document")
    @doc("""
      Updates a Datasphere Document by ID.
      
      ${tokenPermissions<"_DataSphere_">}
      """)
    @summary("Update a Document")
    @patch
    update(...PathID, ...DocumentUpdateRequest):
      | {
          @statusCode statusCode: 200;
          @body document: Document;
        }
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | UpdateStatusCode422
      | StatusCode500;

    @operationId("delete_document")
    @doc("""
      Deletes a Datasphere Document by ID.
      
      ${tokenPermissions<"_DataSphere_">}
      """)
    @summary("Delete a Document")
    @delete
    delete(...PathID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("search_documents")
    @doc("""
      Search Datasphere Documents.
      
      ${tokenPermissions<"_DataSphere_">}
      """)
    @route("/search")
    @summary("Search Documents")
    @post
    search(...DocumentSearchRequest):
      | SearchResponse
      | StatusCode400
      | StatusCode401
      | SearchStatusCode422
      | StatusCode500;
  }
}

namespace DatasphereAPI.Chunks {
  @route("/documents/{documentId}/chunks")
  @tag(CHUNKS_TAG)
  @friendlyName("Chunks")
  interface Chunks {
    @operationId("list_document_chunks")
    @doc("""
      A list of chunks for a Datasphere Document.
      
      ${tokenPermissions<"_DataSphere_">}
      """)
    @summary("List Chunks")
    list(...DocumentPathID, ...ChunkListQuery):
      | ChunkListResponse
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | ListStatusCode422
      | StatusCode500;

    @operationId("get_document_chunk")
    @doc("""
      Retrieves a specific chunk for a Datasphere Document by ID.
      
      ${tokenPermissions<"_DataSphere_">}
      """)
    @summary("Retrieve Chunk")
    @route("/{chunkId}")
    get(...ChunkPathID):
      | ChunkResponse
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | StatusCode500;

    @operationId("delete_document_chunk")
    @doc("""
      Deletes a specific chunk for a Datasphere Document by ID.
      
      ${tokenPermissions<"_DataSphere_">}
      """)
    @summary("Delete Chunk")
    @route("/{chunkId}")
    @delete
    delete(...ChunkPathID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
