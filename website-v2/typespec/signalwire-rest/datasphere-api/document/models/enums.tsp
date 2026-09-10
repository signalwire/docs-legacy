@doc("Strategy to use when chunking the document.")
enum ChunkingStrategy {
  Sentence: "sentence",
  Paragraph: "paragraph",
  Page: "page",
  Sliding: "sliding",
}

@doc("The current Status of the Document.")
enum DocumentStatus {
  Submitted: "submitted",
  InProgress: "in_progress",
  Completed: "completed",
  Failed: "failed",
}

@doc("The current Status of the Chunk.")
enum ChunkStatus {
  Submitted: "submitted",
  InProgress: "in_progress",
  Completed: "completed",
  Failed: "failed",
}
