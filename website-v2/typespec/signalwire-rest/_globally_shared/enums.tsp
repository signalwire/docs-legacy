enum Ciphers {
  AEAD_AES_256_GCM_8: "AEAD_AES_256_GCM_8",
  AES_256_CM_HMAC_SHA1_80: "AES_256_CM_HMAC_SHA1_80",
  AES_CM_128_HMAC_SHA1_80: "AES_CM_128_HMAC_SHA1_80",
  AES_256_CM_HMAC_SHA1_32: "AES_256_CM_HMAC_SHA1_32",
  AES_CM_128_HMAC_SHA1_32: "AES_CM_128_HMAC_SHA1_32",
}

enum Codecs {
  PCMU: "PCMU",
  PCMA: "PCMA",
  G722: "G722",
  G729: "G729",
  OPUS: "OPUS",
  VP8: "VP8",
  H264: "H264",
}

enum Encryption {
  Required: "required",
  Optional: "optional",
  Default: "default",
}
