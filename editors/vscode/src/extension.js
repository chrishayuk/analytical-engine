// The Babbage extension: starts the language server (`babbage lsp`) and adds
// commands that run the page in the editor on the engine and show every cell
// of the sheet checked, the page as cards, and every page of the corpus.
"use strict";

const vscode = require("vscode");
const fs = require("fs");
const os = require("os");
const path = require("path");
const { LanguageClient, TransportKind } = require("vscode-languageclient/node");

/** @type {LanguageClient | undefined} */
let client;

function setting(name) {
  const value = vscode.workspace.getConfiguration("babbage").get(name);
  return typeof value === "string" ? value.trim() : value;
}

async function startServer(context) {
  const custom = setting("path");
  // Built in: babbage compiled to WebAssembly, run by the editor's own Node,
  // so nothing has to be installed.
  const builtIn = { module: context.asAbsolutePath(path.join("server", "lsp.js")), transport: TransportKind.stdio };
  const serverOptions = custom ? { command: custom, args: ["lsp"] } : { run: builtIn, debug: builtIn };
  client = new LanguageClient("babbage", "Babbage notation (babbage)", serverOptions, {
    documentSelector: [{ language: "babbage" }],
  });
  await client.start();
}

async function restartServer(context) {
  if (client) await client.stop().catch(() => {});
  client = undefined;
  await startServer(context);
}

/** Runs babbage as a task in a terminal of its own. `args` come before the file, if there is one. */
async function runTask(context, args, title, file) {
  const custom = setting("path");
  const all = file ? [...args, file] : args;
  const execution = custom
    ? new vscode.ProcessExecution(custom, all)
    : new vscode.ProcessExecution(process.execPath, [context.asAbsolutePath(path.join("server", "run.js")), ...all], {
        env: { ELECTRON_RUN_AS_NODE: "1" },
      });
  const label = file ? `${title} ${path.basename(file)}` : title;
  const task = new vscode.Task({ type: "babbage" }, vscode.TaskScope.Workspace, label, "babbage", execution, []);
  task.presentationOptions = {
    reveal: vscode.TaskRevealKind.Always,
    panel: vscode.TaskPanelKind.Dedicated,
    focus: true,
    clear: true,
    // Without this the terminal first prints the whole command line.
    echo: false,
    showReuseMessage: false,
  };
  await vscode.tasks.executeTask(task);
}

async function runPage(context, args, title) {
  const editor = vscode.window.activeTextEditor;
  if (!editor || editor.document.languageId !== "babbage") {
    vscode.window.showInformationMessage("Open a page of Babbage's notations (.bab) to run it.");
    return;
  }
  const document = editor.document;
  let file = document.uri.fsPath;
  if (document.isUntitled || document.uri.scheme !== "file") {
    // Not on disk yet: run a copy.
    file = path.join(os.tmpdir(), "untitled.bab");
    fs.writeFileSync(file, document.getText());
  } else if (document.isDirty) {
    await document.save();
  }
  await runTask(context, args, title, file);
}

async function activate(context) {
  context.subscriptions.push(
    vscode.commands.registerCommand("babbage.run", () => runPage(context, [], "Run")),
    vscode.commands.registerCommand("babbage.store", () => runPage(context, ["--store"], "Store")),
    vscode.commands.registerCommand("babbage.cards", () => runPage(context, ["cards"], "Cards")),
    vscode.commands.registerCommand("babbage.verify", () => runTask(context, ["verify"], "Verify")),
    vscode.commands.registerCommand("babbage.restartServer", () => restartServer(context)),
    vscode.workspace.onDidChangeConfiguration((event) => {
      if (event.affectsConfiguration("babbage.path")) restartServer(context);
    })
  );
  await startServer(context);
}

function deactivate() {
  return client ? client.stop() : undefined;
}

module.exports = { activate, deactivate };
