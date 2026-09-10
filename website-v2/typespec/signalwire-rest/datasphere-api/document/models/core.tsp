import "@typespec/http";
import "./enums.tsp";

using TypeSpec.Http;

@format("uuid")
@doc("Unique ID of a Document.")
scalar docid extends string;

model PathID {
  @doc("Unique ID of a Document.")
  @example("acaa5c49-be5e-4477-bce0-48f4b23b7720")
  @path
  id: docid;
}

model ChunkPathID {
  @doc("Unique ID of the parent Document.")
  @example("acaa5c49-be5e-4477-bce0-48f4b23b7720")
  @path
  documentId: docid;

  @doc("Unique ID of a Chunk.")
  @example("d369a402-7b43-4512-8735-9d5e1f387814")
  @path
  chunkId: uuid;
}

model DocumentPathID {
  @doc("Unique ID of the Document.")
  @example("acaa5c49-be5e-4477-bce0-48f4b23b7720")
  @path
  documentId: docid;
}

model Document {
  @doc("Unique ID of the Document.")
  @example("acaa5c49-be5e-4477-bce0-48f4b23b7720")
  id: docid;

  @doc("Name of the Document.")
  @example("player_list.pdf")
  filename: string;

  @doc("Status of the Document.")
  @example(DocumentStatus.InProgress)
  status: DocumentStatus;

  @doc("Document tags.")
  @example(#["sports", "football", "game"])
  tags: string[];

  @doc("Strategy used to chunk the document.")
  @example(ChunkingStrategy.Sentence)
  chunking_strategy: ChunkingStrategy;

  @doc("Max Sentences per Chunk. Only present when chunking strategy is 'sentence', null otherwise.")
  @example(80)
  max_sentences_per_chunk: integer | null;

  @doc("Split on Newlines. Only present when chunking strategy is 'sentence', null otherwise.")
  @example(true)
  split_newlines: boolean | null;

  @doc("Overlap Size. Only present when chunking strategy is 'sliding', null otherwise.")
  @example(10)
  overlap_size: integer | null;

  @doc("Chunk Size. Only present when chunking strategy is 'sliding', null otherwise.")
  @example(50)
  chunk_size: integer | null;

  @doc("Number of Chunks in the Document.")
  @example(2345)
  number_of_chunks: integer;

  @doc("URI path to the chunks for this document.")
  @example("/api/rest/datasphere/documents/acaa5c49-be5e-4477-bce0-48f4b23b7720/chunks")
  chunks_uri: string;

  @doc("Document Creation Date.")
  @example(utcDateTime.fromISO("2024-05-06T12:20-12Z"))
  created_at: utcDateTime;

  @doc("Document Update Date.")
  @example(utcDateTime.fromISO("2024-05-06T12:20-12Z"))
  updated_at: utcDateTime;
}

model Chunk {
  @doc("A search result.")
  @example("Cristiano Ronaldo is the highest-paid football player in the world in 2024")
  text: string;

  @doc("Unique ID of the Document.")
  @example("acaa5c49-be5e-4477-bce0-48f4b23b7720")
  document_id: docid;
}
