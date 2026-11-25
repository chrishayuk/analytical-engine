// Runs every page of the corpus through the runner the "Run This Page"
// command uses, and compares what it prints, and its exit status, with what
// the native babbage does, when that has been built.
import assert from "node:assert/strict";
import { spawnSync } from "node:child_process";
import { existsSync, mkdtempSync, readdirSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import test from "node:test";
import { fileURLToPath } from "node:url";

const runner = fileURLToPath(new URL("../server/run.js", import.meta.url));
const corpus = fileURLToPath(new URL("../../../corpus/", import.meta.url));
const native = fileURLToPath(new URL("../../../target/release/babbage", import.meta.url));

function run(text, options = [], name = "page.bab") {
  const file = join(mkdtempSync(join(tmpdir(), "babbage-")), name);
  writeFileSync(file, text);
  return { file, ...spawnSync(process.execPath, [runner, ...options, file]) };
}

// Two multiplications by a, the table of a kept between them.
const page = `Sheet probe
No. 0
Letters a b c d
Store v1 = a, v2 = b, v3 = c, v4 = d
Working v5 v7
Op 1  ×  | ab   | v1 0, v2 0, v5 ab   | v5 = v1·v2
Op 2  ×  | ad   | v4 0, v7 ad         | v7 = v1·v4
`;

test("the built-in babbage runs every page of the corpus as the native one does", () => {
  const names = readdirSync(corpus).filter((f) => f.endsWith(".bab"));
  assert.ok(names.length >= 2);
  for (const file of names) {
    const result = spawnSync(process.execPath, [runner, corpus + file]);
    assert.equal(result.status, 0, `${file}: ${result.stderr}`);
    const out = result.stdout.toString();
    assert.match(out, /^BAB\/L\/\d+ +No\. /, file);
    assert.match(out, /\n\d+ statements of the sheet checked: \d+ agree, \d+ do not\.\n/, file);
    if (existsSync(native)) {
      assert.equal(out, spawnSync(native, [corpus + file]).stdout.toString(), file);
      for (const extra of [["--store"], ["cards"]]) {
        const mine = spawnSync(process.execPath, [runner, ...extra, corpus + file]).stdout.toString();
        assert.equal(mine, spawnSync(native, [...extra, corpus + file]).stdout.toString(), `${extra} ${file}`);
      }
    }
  }
});

test("No. 1 of BAB/L/001: every statement agrees", () => {
  const out = spawnSync(process.execPath, [runner, corpus + "L001-1.bab"]).stdout.toString();
  assert.match(out, /^ +2 +× +v1['′] = v5·v3 +table of b′ standing; v3 → 0; v1 = b′c +✓ \d+$/m);
  assert.match(out, /^✓ x solves the equations$/m);
  assert.match(out, /42 statements of the sheet checked: 42 agree, 0 do not\./);
});

test("a page is run, the table of a kept in the mill", () => {
  const result = run(page);
  assert.equal(result.status, 0, result.stderr.toString());
  const out = result.stdout.toString();
  assert.match(out, /table of a made; v1 v2 → 0; v5 = ab/);
  assert.match(out, /table of a standing; v4 → 0; v7 = ad/);
  assert.match(out, /Tables of multiples made: 1\./);
});

test("cards and the whole store", () => {
  const cards = run(page, ["cards"]).stdout.toString();
  assert.match(cards, /^ +2 +× +\(table kept\), v4 +v7$/m);
  const store = run(page, ["--store"]).stdout.toString();
  assert.match(store, /store: v3 c, v4 d, v5 ab$/m);
});

test("a cell the operation does not give is marked with what it gives", () => {
  const out = run(page.replace("v7 ad ", "v7 bd ")).stdout.toString();
  assert.match(out, /✗ v7 = bd: .*\bgives ad/);
  assert.match(out, /do not\./);
});

test("verify runs every page compiled in", () => {
  const result = spawnSync(process.execPath, [runner, "verify"]);
  assert.equal(result.status, 0, result.stderr.toString());
  assert.match(result.stdout.toString(), /^L001-1 +\d+ statements, +\d+ agree$/m);
  if (existsSync(native)) assert.equal(result.stdout.toString(), spawnSync(native, ["verify"]).stdout.toString());
});

test("the page is the only file babbage can open, whatever its name", () => {
  // a name that starts with a dash is not taken for an option
  const result = run(page, [], "-odd name.bab");
  assert.equal(result.status, 0, result.stderr.toString());
  assert.match(result.stdout.toString(), /table of a standing/);
  const missing = spawnSync(process.execPath, [runner, join(tmpdir(), "no-such-page.bab")]);
  assert.equal(missing.status, 2);
  assert.match(missing.stderr.toString(), /cannot read/);
  // a line not in the notation: babbage says where, and stops with status 2
  const bad = run("Sheet X\nFrobnicate 3\n");
  assert.equal(bad.status, 2);
  assert.match(bad.stderr.toString(), /:2: `Frobnicate` is not a line of a page/);
});
