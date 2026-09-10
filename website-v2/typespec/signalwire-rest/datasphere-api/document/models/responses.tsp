import "./enums.tsp";

model DocumentListResponse {
  @doc("A list of documents.")
  data: Document[];

  @doc("Pagination links.")
  links: PaginationResponse;
}

model PaginationResponse {
  @doc("Link of the current page.")
  @example("https://{space_name}.signalwire.com/api/datasphere/documents?page_number=0&page_size=50")
  self: url;

  @doc("Link to the first page.")
  @example("https://{space_name}.signalwire.com/api/datasphere/documents?page_number=0&page_size=50")
  first: url;

  @doc("Link to the next page. Only present when there are more results.")
  @example("https://{space_name}.signalwire.com/api/datasphere/documents?page_number=1&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca")
  next?: url;

  @doc("Link to the previous page. Only present when not on the first page.")
  @example("https://{space_name}.signalwire.com/api/datasphere/documents?page_number=0&page_size=50&page_token=PBbff61159-faab-48b3-959a-3021a8f5beca")
  prev?: url;
}

model SearchResponse {
  @doc("A list of search result chunks.")
  chunks: Chunk[];
}

model ChunkResponse {
  @doc("Unique ID of the chunk.")
  @example("acaa5c49-be5e-4477-bce0-48f4b23b7720")
  id: uuid;

  @doc("Unique ID of the chunk's datasphere document.")
  @example("acaa5c49-be5e-4477-bce0-48f4b23b7720")
  datasphere_document_id: uuid;

  @doc("Unique ID of the project.")
  @example("d369a402-7b43-4512-8735-9d5e1f387814")
  project_id: uuid;

  @doc("Status of the chunk.")
  @example(ChunkStatus.Completed)
  status: ChunkStatus;

  @doc("The tags of the document associated with the chunk.")
  @example(#["sports", "football", "game"])
  tags: string[];

  @doc("Content of the chunk.")
  @example("This is the content from the original document that was chunked.")
  content: string;

  @doc("Chunk Creation Date.")
  @example(utcDateTime.fromISO("2024-05-06T12:20-12Z"))
  created_at: utcDateTime;

  @doc("Chunk Update Date.")
  @example(utcDateTime.fromISO("2024-05-06T12:20-12Z"))
  updated_at: utcDateTime;
}

model ChunkListResponse {
  @doc("A list of chunks.")
  data: ChunkResponse[];

  @doc("Pagination links.")
  links: ChunkPaginationResponse;
}

model ChunkPaginationResponse {
  @doc("Link of the current page.")
  @example("https://{space_name}.signalwire.com/api/datasphere/documents/{document_id}/chunks?page_number=0&page_size=50")
  self: url;

  @doc("Link to the first page.")
  @example("https://{space_name}.signalwire.com/api/datasphere/documents/{document_id}/chunks?page_number=0&page_size=50")
  first: url;

  @doc("Link to the next page. Only present when there are more results.")
  @example("https://{space_name}.signalwire.com/api/datasphere/documents/{document_id}/chunks?page_number=1&page_size=50&page_token=PAbff61159-faab-48b3-959a-3021a8f5beca")
  next?: url;

  @doc("Link to the previous page. Only present when not on the first page.")
  @example("https://{space_name}.signalwire.com/api/datasphere/documents/{document_id}/chunks?page_number=0&page_size=50&page_token=PBbff61159-faab-48b3-959a-3021a8f5beca")
  prev?: url;
}
