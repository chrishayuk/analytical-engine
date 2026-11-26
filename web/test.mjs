// Runs every page through the WebAssembly build and compares with the
// native build:  node web/test.mjs   (after node web/build.mjs and cargo build --release)
import { execFileSync } from "node:child_process";
import { readFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { babbage } from "./worker.js";
import { answer } from "./lsp-worker.js";

const root = fileURLToPath(new URL("..", import.meta.url));
const module = await WebAssembly.compile(readFileSync(`${root}web/babbage.wasm`));
const native = `${root}target/release/babbage`;
let failed = 0;
const fail = (m) => (failed++, console.log("FAIL " + m));
const pages = JSON.parse(readFileSync(`${root}web/corpus.json`, "utf8"));
for (const page of pages) {
  for (const extra of [[], page.at ? ["--at", page.at] : null].filter(Boolean)) {
    const args = ["json", "-", ...extra];
    const wasm = babbage(module, args, page.text);
    const want = execFileSync(native, args, { input: page.text }).toString();
    if (wasm.out !== want) fail(`${page.name} ${extra.join(" ")}: the wasm build and the native build differ`);
    const run = JSON.parse(wasm.out);
    if (!run.steps.length && /^(Op|Turn) /m.test(page.text)) fail(`${page.name}: no steps`);
  }
}
// the worked example gives x = 1 and y = 2
const two = pages.find((p) => p.name === "L001-2");
const r = JSON.parse(babbage(module, ["json", "-", "--at", two.at], two.text).out);
const num = Object.fromEntries(r.results.map((x) => [x.name, x.held.number]));
if (num.x !== "1" || num.y !== "2") fail(`worked example: x = ${num.x}, y = ${num.y}`);
if (r.statements - r.agree !== 1) fail("L001-2 should have one statement that does not agree");
// the language server answers in the page as it does in an editor
const lines = two.text.split("\n");
const op2 = lines.findIndex((l) => l.startsWith("Op 2"));
const lsp = answer(module, two.text, [
  { method: "textDocument/semanticTokens/full" },
  { method: "textDocument/hover", params: { position: { line: op2, character: 1 } } },
]);
if (!lsp.results[0]?.data?.length) fail("lsp: no semantic tokens");
if (!/table of multiples still standing/.test(lsp.results[1]?.contents?.value ?? "")) fail("lsp: hover on operation 2 does not give the table");
if (lsp.diagnostics.filter((d) => d.severity <= 2).length !== 1) fail("lsp: L001-2 should have one problem");
console.log(`${pages.length} pages through the wasm build, ${failed ? failed + " failed" : "all agree with the native build"}`);
// Strict, through the wasm build: L/017 run as written loses Q0.
{
  const l017 = JSON.parse(readFileSync(`${root}web/corpus.json`, "utf8")).find((p) => p.name === "L017");
  if (l017) {
    const lax = JSON.parse(babbage(module, ["json", "-"], l017.text).out);
    const strict = JSON.parse(babbage(module, ["json", "-", "--strict"], l017.text).out);
    const bad = (r) => JSON.stringify(r).split('"ok":false').length - 1;
    if (!(bad(strict) > bad(lax))) { console.log(`strict should find more on L017: ${bad(lax)} vs ${bad(strict)}`); failed = true; }
    console.log(`L017 through wasm: ${bad(lax)} disagreements, strict ${bad(strict)}`);
  }
}

process.exit(failed ? 1 : 0);
