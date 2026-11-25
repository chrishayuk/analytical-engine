// Tokenises pages with the same TextMate engine VS Code uses and checks the
// scopes the grammar assigns.
import assert from "node:assert/strict";
import { readFileSync, readdirSync } from "node:fs";
import { createRequire } from "node:module";
import test from "node:test";
import { fileURLToPath } from "node:url";
import oniguruma from "vscode-oniguruma";
import textmate from "vscode-textmate";

const require = createRequire(import.meta.url);
const grammarPath = fileURLToPath(new URL("../syntaxes/babbage.tmLanguage.json", import.meta.url));
const corpus = fileURLToPath(new URL("../../../corpus/", import.meta.url));

const wasm = readFileSync(require.resolve("vscode-oniguruma/release/onig.wasm"));
await oniguruma.loadWASM(wasm.buffer.slice(wasm.byteOffset, wasm.byteOffset + wasm.byteLength));
const registry = new textmate.Registry({
  onigLib: Promise.resolve({
    createOnigScanner: (patterns) => new oniguruma.OnigScanner(patterns),
    createOnigString: (text) => new oniguruma.OnigString(text),
  }),
  loadGrammar: async () => textmate.parseRawGrammar(readFileSync(grammarPath, "utf8"), grammarPath),
});
const grammar = await registry.loadGrammar("source.bab");

/** Each non-blank piece of text with its most specific scope. */
function scopes(source) {
  const out = [];
  let state = textmate.INITIAL;
  for (const line of source.split("\n")) {
    const result = grammar.tokenizeLine(line, state);
    for (const token of result.tokens) {
      const text = line.slice(token.startIndex, token.endIndex);
      if (text.trim()) out.push([text.trim(), token.scopes.at(-1)]);
    }
    state = result.ruleStack;
  }
  return out;
}

const scopeOf = (line, text) => {
  const found = scopes(line).find(([t]) => t === text);
  assert.ok(found, `no token ${text} in ${line}`);
  return found[1];
};

test("headings and notes", () => {
  assert.deepEqual(scopes("Sheet BAB/L/001"), [
    ["Sheet", "keyword.control.heading.babbage"],
    ["BAB/L/001", "entity.name.section.babbage"],
  ]);
  assert.deepEqual(scopes("No. 2"), [
    ["No.", "keyword.control.heading.babbage"],
    ["2", "entity.name.section.babbage"],
  ]);
  assert.deepEqual(scopes("% the cover lists two programs"), [["% the cover lists two programs", "comment.line.percentage.babbage"]]);
  assert.deepEqual(scopes("Working v7   % one working variable").at(-1), ["% one working variable", "comment.line.percentage.babbage"]);
});

test("lines of words: the date, the title, a remark, something not run", () => {
  assert.deepEqual(scopes('Date 4 Aug 1837          "No 1. 4 Aug 1837."   % cover'), [
    ["Date", "keyword.control.directive.babbage"],
    ["4 Aug 1837", "string.unquoted.babbage"],
    ['"', "punctuation.definition.string.begin.babbage"],
    ["No 1. 4 Aug 1837.", "string.quoted.double.babbage"],
    ['"', "punctuation.definition.string.end.babbage"],
    ["% cover", "comment.line.percentage.babbage"],
  ]);
  // algebra inside the sheet's words is not the page's
  assert.equal(scopeOf('Title "Elimination ax + by + c = 0"', "Elimination ax + by + c = 0"), "string.quoted.double.babbage");
  assert.equal(scopeOf('Remark "It at first appeared that variables v7"', "It at first appeared that variables v7"), "string.quoted.double.babbage");
  assert.equal(scopeOf("Image 222/594 upper table", "222/594 upper table"), "string.unquoted.babbage");
  assert.equal(scopes('Unrun "pencil: 6 Mult = 18"')[0][1], "keyword.control.directive.babbage");
});

test("an operation: number, operation, mill, store cells, right-hand column", () => {
  assert.deepEqual(scopes("Op 1     ×  | b'a | v1 0, v5 0, v7 b'a | v7 = v5·v1"), [
    ["Op", "keyword.control.directive.babbage"],
    ["1", "constant.numeric.babbage"],
    ["×", "keyword.operator.babbage"],
    ["|", "punctuation.separator.field.babbage"],
    ["b'", "variable.parameter.letter.babbage"],
    ["a", "variable.parameter.letter.babbage"],
    ["|", "punctuation.separator.field.babbage"],
    ["v1", "variable.other.store.babbage"],
    ["0", "constant.numeric.babbage"],
    [",", "punctuation.separator.comma.babbage"],
    ["v5", "variable.other.store.babbage"],
    ["0", "constant.numeric.babbage"],
    [",", "punctuation.separator.comma.babbage"],
    ["v7", "variable.other.store.babbage"],
    ["b'", "variable.parameter.letter.babbage"],
    ["a", "variable.parameter.letter.babbage"],
    ["|", "punctuation.separator.field.babbage"],
    ["v7", "variable.other.store.babbage"],
    ["=", "keyword.operator.babbage"],
    ["v5", "variable.other.store.babbage"],
    ["·", "keyword.operator.babbage"],
    ["v1", "variable.other.store.babbage"],
  ]);
  const seven = "Op 7  *  ÷  | (bc'-b'c)/(b'a-ba') | v1 0, v3 =x, v4 0 | x = v3'' = v4'/v1''";
  assert.equal(scopeOf(seven, "*"), "keyword.other.star.babbage");
  assert.equal(scopeOf(seven, "÷"), "keyword.operator.babbage");
  assert.equal(scopeOf(seven, "v3''"), "variable.other.store.babbage");
  assert.equal(scopeOf(seven, "v1''"), "variable.other.store.babbage");
  assert.equal(scopeOf(seven, "("), "punctuation.parenthesis.babbage");
});

test("complements, transfers and the minus sign", () => {
  const one = "Op 1     ×  | b'a | v1 0, v5 0, v7 b'a, v8 Ca | v7 = v5·v1";
  assert.equal(scopeOf(one, "C"), "keyword.operator.complement.babbage");
  assert.deepEqual(scopes("Op 8        |  | v1 a, v8 0 | v1'' = v1 = a").slice(0, 4), [
    ["Op", "keyword.control.directive.babbage"],
    ["8", "constant.numeric.babbage"],
    ["|", "punctuation.separator.field.babbage"],
    ["|", "punctuation.separator.field.babbage"],
  ]);
  assert.equal(scopeOf("Op 5     −  | bc'-b'c | v1 0 | v4' = v2'-v1'", "−"), "keyword.operator.babbage");
});

test("the store, the counts, the composition", () => {
  assert.deepEqual(scopes("Store v1 = a, v4 = a'"), [
    ["Store", "keyword.control.directive.babbage"],
    ["v1", "variable.other.store.babbage"],
    ["=", "keyword.operator.babbage"],
    ["a", "variable.parameter.letter.babbage"],
    [",", "punctuation.separator.comma.babbage"],
    ["v4", "variable.other.store.babbage"],
    ["=", "keyword.operator.babbage"],
    ["a'", "variable.parameter.letter.babbage"],
  ]);
  assert.deepEqual(scopes("States great 5, small 2").slice(0, 3), [
    ["States", "keyword.control.directive.babbage"],
    ["great", "support.constant.count.babbage"],
    ["5", "constant.numeric.babbage"],
  ]);
  assert.equal(scopeOf("Composition x = v3'' = v4'/v1''", "x"), "variable.parameter.letter.babbage");
});

test("a word that is not in the notation", () => {
  assert.deepEqual(scopes("Frobnicate 3")[0], ["Frobnicate", "invalid.illegal.babbage"]);
  assert.deepEqual(scopes("Opp 3 × | | |")[0], ["Opp", "invalid.illegal.babbage"]);
});

test("every page of the corpus tokenises with nothing marked invalid", () => {
  const files = readdirSync(corpus).filter((f) => f.endsWith(".bab"));
  assert.ok(files.length >= 2);
  for (const file of files) {
    const bad = scopes(readFileSync(corpus + file, "utf8")).filter(([, k]) => k === "invalid.illegal.babbage");
    assert.deepEqual(bad, [], file);
  }
});
