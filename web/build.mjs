// Builds the files the playground needs:  node web/build.mjs
//   web/babbage.wasm   babbage, compiled for WASI: the checker and the language server (`babbage lsp`)
//   web/corpus.json    every page of the transcription, in the order of the archive
import { execSync } from "node:child_process";
import { copyFileSync, readFileSync, readdirSync, writeFileSync } from "node:fs";
import { fileURLToPath } from "node:url";

const root = fileURLToPath(new URL("..", import.meta.url));
execSync("cargo build --release --target wasm32-wasip1", { cwd: root, stdio: "inherit" });
copyFileSync(`${root}target/wasm32-wasip1/release/babbage.wasm`, `${root}web/babbage.wasm`);

// A worked example for each sheet's letters, for the "numbers" view: chosen
// here, not on the sheet. 2x + 3y - 8 = 0 and 5x - y - 3 = 0: x = 1, y = 2.
const examples = {
  "BAB/L/001": { at: "a=2,b=3,c=-8,a'=5,b'=-1,c'=-3", example: "2x + 3y − 8 = 0, 5x − y − 3 = 0 (x = 1, y = 2)" },
  // (2 + 3x + 3x² + 3x³ + 3x⁴ + 3x⁵ + x⁶)/(2 + x) = 1 + x + x² + x³ + x⁴ + x⁵.
  "BAB/L/002": { at: "a=2,b=1,A0=2,A1=3,A2=3,A3=3,A4=3,A5=3,A6=1", example: "(2 + 3x + 3x² + 3x³ + 3x⁴ + 3x⁵ + x⁶)/(2 + x) = 1 + x + x² + x³ + x⁴ + x⁵ (λ6 = 0)" },
};

const names = readdirSync(`${root}corpus`).filter((f) => f.endsWith(".bab")).map((f) => f.slice(0, -4)).sort();
const pages = names.map((name) => {
  const text = readFileSync(`${root}corpus/${name}.bab`, "utf8");
  const sheet = (/^Sheet (.*)$/m.exec(text) || [, ""])[1].trim();
  const no = (/^No\. (.*)$/m.exec(text) || [, ""])[1].trim();
  const date = (/^Date ([^"%]*)/m.exec(text) || [, ""])[1].trim();
  const title = `${sheet} No. ${no}${date ? ", " + date : ""}`;
  return { name, title, sheet, text, ...(examples[sheet] ?? {}) };
});
writeFileSync(`${root}web/corpus.json`, JSON.stringify(pages));
console.log(`web/babbage.wasm, web/corpus.json (${pages.length} pages) written`);
