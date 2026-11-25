// Starts the language server: babbage compiled for WASI, run as
// `babbage lsp`, talking the Language Server Protocol on standard input and
// output.
"use strict";

const path = require("path");
const { run } = require("./wasi.js");

process.exitCode = run(path.join(__dirname, "babbage.wasm"), { args: ["lsp"] });
