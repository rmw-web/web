crypto = require("crypto")
digest = crypto.Hash::digest
crypto.Hash::digest = (base) ->
  if base == "urlbase64"
    return digest
      .call(this, "base64")
      .replace(/\+/g, "-")
      .replace(/\//g, "_")
      .replace(/=+$/, "")
  digest.apply(this, arguments)
