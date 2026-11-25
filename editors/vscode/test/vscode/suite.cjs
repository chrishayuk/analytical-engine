// Runs inside VS Code. Exercises the extension the way a person would: open
// a page of the corpus, hover, see its problems, outline and colours, and
// run it.
"use strict";

const assert = require("node:assert/strict");
const path = require("node:path");
const vscode = require("vscode");

const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

async function until(what, probe, seconds = 20) {
  for (let i = 0; i < seconds * 10; i++) {
    const value = await probe();
    if (value) return value;
    await sleep(100);
  }
  throw new Error(`timed out waiting for ${what}`);
}

const hoverText = (hovers) =>
  hovers.flatMap((h) => h.contents).map((c) => (typeof c === "string" ? c : c.value)).join("\n");

/** Runs a command that starts a babbage task and returns the task's exit code. */
async function taskExit(command) {
  const finished = new Promise((resolve) => {
    const listener = vscode.tasks.onDidEndTaskProcess((event) => {
      if (event.execution.task.definition.type === "babbage") {
        listener.dispose();
        resolve(event.exitCode);
      }
    });
  });
  await vscode.commands.executeCommand(command);
  return Promise.race([finished, sleep(20000).then(() => "timed out")]);
}

exports.run = async function run() {
  const folder = vscode.workspace.workspaceFolders[0].uri.fsPath;
  const document = await vscode.workspace.openTextDocument(path.join(folder, "L001-1.bab"));
  await vscode.window.showTextDocument(document);
  assert.equal(document.languageId, "babbage", "the .bab extension selects the language");

  const line = (text) => {
    for (let i = 0; i < document.lineCount; i++) if (document.lineAt(i).text.startsWith(text)) return i;
    throw new Error(`no line ${text}`);
  };

  // The server is ready when it answers a hover.
  const two = new vscode.Position(line("Op 2"), 1);
  const hovers = await until("a hover from the language server", async () => {
    const found = await vscode.commands.executeCommand("vscode.executeHoverProvider", document.uri, two);
    return found.length ? found : undefined;
  });
  assert.match(hoverText(hovers), /table of multiples still standing in the mill/);
  const states = await vscode.commands.executeCommand("vscode.executeHoverProvider", document.uri, new vscode.Position(line("States"), 1));
  assert.match(hoverText(states), /✓ great = 5/);
  console.log("hover ok");

  const legend = await vscode.commands.executeCommand("vscode.provideDocumentSemanticTokensLegend", document.uri);
  assert.deepEqual(legend.tokenTypes, ["comment", "string", "keyword", "number", "operator", "variable", "parameter", "macro"]);
  const tokens = await vscode.commands.executeCommand("vscode.provideDocumentSemanticTokens", document.uri);
  assert.ok(tokens.data.length > 0);
  const symbols = await vscode.commands.executeCommand("vscode.executeDocumentSymbolProvider", document.uri);
  assert.equal(symbols.length, 7);
  assert.equal(symbols[0].name, "1 ×  v7 = v5·v1");
  console.log("symbols and semantic tokens ok");

  // A page with a cell the operation does not give and a line that is not in the notation.
  const broken = await vscode.workspace.openTextDocument({
    language: "babbage",
    content:
      "Sheet probe\nLetters a b\nStore v1 = a, v2 = b\nWorking v3\nOp 1  ×  | ab | v1 0, v2 0, v3 b | v3 = v1·v2\nFrobnicate 3\n",
  });
  await vscode.window.showTextDocument(broken);
  const problems = await until("diagnostics", () => {
    const found = vscode.languages.getDiagnostics(broken.uri);
    return found.length >= 2 ? found : undefined;
  });
  const wrong = problems.find((p) => p.severity === vscode.DiagnosticSeverity.Warning);
  assert.match(wrong.message, /^v3 = b: .*\bgives ab/);
  assert.equal(wrong.range.start.line, 4);
  const error = problems.find((p) => p.severity === vscode.DiagnosticSeverity.Error);
  assert.equal(error.source, "babbage");
  assert.equal(error.range.start.line, 5);
  console.log("diagnostics ok");

  const completion = await vscode.commands.executeCommand("vscode.executeCompletionItemProvider", broken.uri, new vscode.Position(6, 0));
  const labels = completion.items.map((i) => (typeof i.label === "string" ? i.label : i.label.label));
  assert.ok(labels.includes("Composition"));
  console.log("completion ok");

  // Run This Page, the cards, the store, and verify: tasks that end with exit code 0.
  await vscode.window.showTextDocument(document);
  assert.equal(await taskExit("babbage.run"), 0);
  console.log("run ok");
  assert.equal(await taskExit("babbage.cards"), 0);
  console.log("cards ok");
  assert.equal(await taskExit("babbage.store"), 0);
  console.log("store ok");
  assert.equal(await taskExit("babbage.verify"), 0);
  console.log("verify ok");
};
