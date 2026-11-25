// Runs a page:  node run.js [--store | cards] page.bab
//               node run.js verify
// The page is read here and given to babbage as the one file it can open,
// under its own name, so babbage needs no access to the disk. `verify` runs
// every page of the corpus compiled into babbage, and needs no file.
"use strict";

const fs = require("fs");
const path = require("path");
const { run } = require("./wasi.js");

const wasm = path.join(__dirname, "babbage.wasm");
const args = process.argv.slice(2);

if (args.length === 1 && args[0] === "verify") {
  process.exitCode = run(wasm, { args: ["verify"], keyboard: false });
} else {
  const file = args.pop();
  if (!file || file.startsWith("--") || file === "cards") {
    console.error("usage: run.js [--store | cards] page.bab   or   run.js verify");
    process.exit(2);
  }
  let page;
  try {
    page = fs.readFileSync(file);
  } catch (error) {
    console.error(`babbage: cannot read ${file}: ${error.message}`);
    process.exit(2);
  }
  const base = path.basename(file);
  // A name that starts with a dash would be read as an option.
  const name = base.startsWith("-") ? `./${base}` : base;
  process.exitCode = run(wasm, { args: [...args, name], files: { [base]: page }, keyboard: false });
}
