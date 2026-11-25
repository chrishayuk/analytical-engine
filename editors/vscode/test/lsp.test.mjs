// Talks to the language server the way an editor does: over standard input
// and output. It tests the WebAssembly build the extension ships and, when
// it has been built, the native program other editors would use.
import assert from "node:assert/strict";
import { spawn } from "node:child_process";
import { existsSync } from "node:fs";
import test from "node:test";
import { fileURLToPath } from "node:url";

const here = fileURLToPath(new URL("..", import.meta.url));
const native = fileURLToPath(new URL("../../../target/release/babbage", import.meta.url));
const servers = [["WebAssembly", process.execPath, [`${here}server/lsp.js`, "--stdio"]]];
if (existsSync(native)) servers.push(["native", native, ["lsp"]]);

function connect(command, args) {
  const child = spawn(command, args, { stdio: ["pipe", "pipe", "inherit"] });
  let buffer = Buffer.alloc(0);
  const waiting = [];
  const arrived = [];
  child.stdout.on("data", (chunk) => {
    buffer = Buffer.concat([buffer, chunk]);
    for (;;) {
      const header = buffer.indexOf("\r\n\r\n");
      if (header === -1) return;
      const length = Number(/Content-Length: (\d+)/i.exec(buffer.subarray(0, header).toString())[1]);
      if (buffer.length < header + 4 + length) return;
      const message = JSON.parse(buffer.subarray(header + 4, header + 4 + length).toString());
      buffer = buffer.subarray(header + 4 + length);
      const next = waiting.shift();
      if (next) next(message);
      else arrived.push(message);
    }
  });
  const send = (message) => {
    const body = JSON.stringify({ jsonrpc: "2.0", ...message });
    child.stdin.write(`Content-Length: ${Buffer.byteLength(body)}\r\n\r\n${body}`);
  };
  const receive = () => new Promise((resolve) => (arrived.length ? resolve(arrived.shift()) : waiting.push(resolve)));
  let id = 0;
  const request = async (method, params) => {
    send({ id: ++id, method, params });
    const reply = await receive();
    assert.equal(reply.id, id);
    return reply.result;
  };
  const exited = new Promise((resolve) => child.on("exit", resolve));
  return { send, receive, request, exited, kill: () => child.kill() };
}

const uri = "file:///L001-1.bab";
// BAB/L/001 No. 1 (corpus/L001-1.bab, shortened), with operation 4's store
// cell written bc where the operation gives bc′.
const page = `% No. 1, with a cell the operation does not give.
Sheet BAB/L/001
No. 1
Date 4 Aug 1837          "No 1. 4 Aug 1837."
Letters a b c a' b' c'
Unknowns x y
Equation a x + b y + c = 0
Equation a' x + b' y + c' = 0
Find x = (bc'-b'c)/(b'a-ba')
Store v1 = a, v2 = b, v3 = c, v4 = a', v5 = b', v6 = c'
Working v7
Op 1     ×  | b'a                 | v1 0, v5 0, v7 b'a        | v7 = v5·v1
Op 2     ×  | b'c                 | v1 b'c, v3 0              | v1' = v5·v3
Op 3     ×  | ba'                 | v2 0, v3 ba', v4 0        | v3' = v2·v4
Op 4     ×  | bc'                 | v2 bc, v6 0               | v2' = v2·v6
Op 5     −  | bc'-b'c             | v1 0, v2 0, v4 bc'-b'c    | v4' = v2'-v1'
Op 6     −  | b'a-ba'             | v1 b'a-ba', v3 0, v7 0    | v1'' = v7-v3'
Op 7  *  ÷  | (bc'-b'c)/(b'a-ba') | v1 0, v3 =x, v4 0         | x = v3'' = v4'/v1''
Composition x = v3'' = v4'/v1'' = (bc'-b'c)/(b'a-ba')
States great 5, small 2, total 7, variables 6, working 1, occupied 7
`;

/** Semantic tokens as [line, column, length, type name]. */
function decode(data, legend) {
  const out = [];
  let line = 0;
  let column = 0;
  for (let i = 0; i < data.length; i += 5) {
    line += data[i];
    column = data[i] ? data[i + 1] : column + data[i + 1];
    out.push([line, column, data[i + 2], legend[data[i + 3]]]);
  }
  return out;
}

/** Accents as typed: v3″ and v3′′ are v3''. */
const plain = (s) => s.replaceAll("‴", "'''").replaceAll("″", "''").replaceAll("′", "'");

const LEGEND = ["comment", "string", "keyword", "number", "operator", "variable", "parameter", "macro"];

for (const [name, command, args] of servers) {
  test(`${name} server: a session from initialize to exit`, async (t) => {
    const server = connect(command, args);
    // A failed assertion must not leave the server running, or the test never ends.
    t.after(() => server.kill());
    const initialised = await server.request("initialize", { processId: null, rootUri: null, capabilities: {} });
    assert.equal(initialised.serverInfo.name, "babbage");
    const capabilities = initialised.capabilities;
    assert.equal(capabilities.textDocumentSync, 1);
    assert.equal(capabilities.hoverProvider, true);
    assert.equal(capabilities.documentSymbolProvider, true);
    assert.ok(capabilities.completionProvider);
    const legend = capabilities.semanticTokensProvider.legend.tokenTypes;
    assert.deepEqual(legend, LEGEND);
    server.send({ method: "initialized", params: {} });

    server.send({ method: "textDocument/didOpen", params: { textDocument: { uri, languageId: "babbage", version: 1, text: page } } });
    const opened = await server.receive();
    assert.equal(opened.method, "textDocument/publishDiagnostics");
    assert.equal(opened.params.uri, uri);
    // bc is not what operation 4 gives: a warning on its line, and nothing in the notation is wrong
    const wrong = opened.params.diagnostics.filter((d) => d.severity === 2);
    assert.ok(wrong.length >= 1);
    assert.ok(wrong.every((d) => d.source === "babbage"));
    const four = wrong.find((d) => d.range.start.line === 14);
    assert.ok(four, JSON.stringify(wrong));
    assert.match(four.message, /^v2 = bc: .*\bgives bc′/);
    assert.deepEqual(opened.params.diagnostics.filter((d) => d.severity === 1), []);

    const at = (line, character) => ({ textDocument: { uri }, position: { line, character } });
    const hover = async (line, character) => (await server.request("textDocument/hover", at(line, character)))?.contents.value;
    // on an operation: where each operand came from, and the store after
    const two = await hover(12, 1);
    assert.match(plain(two), /^\*\*Operation 2\*\* × `v1' = v5·v3`/);
    assert.match(two, /multiplicand: b′, from the table of multiples still standing in the mill/);
    assert.match(two, /multiplier: c, from v3, which is left at zero/);
    assert.match(plain(two), /✓ v1' written/);
    assert.match(two, /Store after: v1 b′c · v2 b/);
    assert.match(await hover(11, 1), /a table of multiples of the multiplicand is made/);
    assert.match(await hover(14, 1), /✗ v2 = bc: .*\bgives bc′/);
    // on a variable: the number it names
    const lines = page.split("\n");
    assert.match(await hover(12, lines[12].indexOf("v1'") + 1), /`v1′` .*\*\*b′c\*\*/);
    assert.match(await hover(17, lines[17].lastIndexOf("v1''") + 2), /`v1(″|′′)` .*\*\*ab′ - a′b\*\*/);
    // on the page's statements, and on a directive
    assert.match(await hover(19, 1), /✓ great = 5/);
    assert.match(plain(await hover(18, 1)), /✓ composition: x = v3''/);
    assert.match(await hover(9, 1), /what the store holds at the start/);

    const { data } = await server.request("textDocument/semanticTokens/full", { textDocument: { uri } });
    const tokens = decode(data, legend);
    const kinds = (line) => tokens.filter((k) => k[0] === line).map((k) => k[3]);
    assert.deepEqual(kinds(0), ["comment"]);
    assert.deepEqual(kinds(1), ["macro"]);
    assert.deepEqual(kinds(3), ["keyword", "string"]);
    assert.deepEqual(kinds(9).slice(0, 4), ["keyword", "variable", "operator", "parameter"]);
    assert.deepEqual(kinds(11), [
      "keyword", "number", "operator", "operator", "parameter", "parameter", "operator",
      "variable", "number", "variable", "number", "variable", "parameter", "parameter", "operator",
      "variable", "operator", "variable", "operator", "variable",
    ]);
    // an accented variable is one token
    const v3 = tokens.find((k) => k[0] === 17 && k[1] === lines[17].indexOf("v3''"));
    assert.deepEqual(v3.slice(2), [4, "variable"]);

    const symbols = await server.request("textDocument/documentSymbol", { textDocument: { uri } });
    assert.deepEqual(symbols.map((s) => plain(s.name)), [
      "1 ×  v7 = v5·v1", "2 ×  v1' = v5·v3", "3 ×  v3' = v2·v4", "4 ×  v2' = v2·v6",
      "5 −  v4' = v2'-v1'", "6 −  v1'' = v7-v3'", "7 ÷  x = v3'' = v4'/v1''",
    ]);
    assert.equal(symbols[0].range.start.line, 11);
    const completion = await server.request("textDocument/completion", at(20, 0));
    const labels = completion.map((c) => c.label);
    for (const label of ["Op", "Store", "Composition", "States", "×", "÷", "−", "great", "occupied"]) {
      assert.ok(labels.includes(label), label);
    }

    server.send({ method: "textDocument/didChange", params: { textDocument: { uri, version: 2 }, contentChanges: [{ text: "Sheet X\nFrobnicate 3\n" }] } });
    const broken = await server.receive();
    const errors = broken.params.diagnostics.filter((d) => d.severity === 1);
    assert.equal(errors[0].range.start.line, 1);
    assert.match(errors[0].message, /`Frobnicate` is not a line of a page/);

    server.send({ method: "textDocument/didClose", params: { textDocument: { uri } } });
    const closed = await server.receive();
    assert.deepEqual(closed.params.diagnostics, []);

    assert.equal(await server.request("shutdown", null), null);
    server.send({ method: "exit" });
    assert.equal(await server.exited, 0);
  });

  test(`${name} server: the counts on a States line are words, not letters`, async (t) => {
    const server = connect(command, args);
    t.after(() => server.kill());
    await server.request("initialize", { processId: null, rootUri: null, capabilities: {} });
    server.send({ method: "textDocument/didOpen", params: { textDocument: { uri, languageId: "babbage", version: 1, text: page } } });
    await server.receive();
    const { data } = await server.request("textDocument/semanticTokens/full", { textDocument: { uri } });
    const onStates = decode(data, LEGEND).filter((k) => k[0] === 19);
    assert.equal(onStates.filter((k) => k[3] === "parameter").length, 0);
  });
}
