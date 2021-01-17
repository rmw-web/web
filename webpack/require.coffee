
fs = require("fs-extra")
require.extensions[".txt"] = (module, filename) =>
  module.exports = fs.readFileSync(filename, "utf8").trim()
