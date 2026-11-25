# Babbage's notations for the Analytical Engine, for Visual Studio Code

Editor support for Charles Babbage's *Notations of calculations for the Analytical Engine* (Science Museum Group, the Babbage Papers, BAB/L), written down so that they can be run. A `.bab` file is one table of one sheet, cell for cell: the store at the start, then each operation as Babbage wrote it, with the operation, what the mill makes, the store cells the row writes (`0` for a column left at zero, `Ca` for a complement, `=x` for a result) and his right-hand formula with its accented variables (`v1'' = v7-v3'`). `babbage` does each operation on the engine as the sheets of its date show it and checks every cell, every accent, every composition and every count the sheet gives. The notation is described in [`docs/notation.md`](../../docs/notation.md).

Nothing else needs installing: `babbage`, which is both the checker and the language server, is built into the extension as WebAssembly.

## What you get

- **Colours** for the heading (`Sheet BAB/L/001`, `No. 1`), the lines of words (`Date`, `Title`, `Image`, `Remark`, `Unrun`), the sheet's words in quotes, the directives (`Letters`, `Unknowns`, `Equation`, `Find`, `Store`, `Working`, `Op`, `Composition`, `States`), the store's variables with their accents (`v1`, `v3''`), the letters (`a`, `b'`, `x`), the complement sign (`C` in `Ca`), the operations (`×`, `÷`, `+`, `−`), Babbage's star, the `|` between the fields of an operation, the counts (`great`, `small`, …) and `%` notes. The language server colours the page too, and its colours take the place of the grammar's.
- **Problems as you type.** A line that is not in the notation is an error, and so is an operation the run cannot do, which stops the run there. Every statement of the sheet that the run does not reach is a warning that says what the run gives instead (`v2 = bc: the row's operation gives bc′`): a store cell, a mill entry, a formula, an accent, a member of a composition, a count.
- **Hover** on an operation to see where each operand came from (a column left at zero, or the table of multiples still standing in the mill), whether a table is made, what the operation gives, what it writes, every statement of the row ✓ or ✗, and the store after it. Hover on a variable, `v3''`, for the number it names in this run. On `Composition`, `States`, `Find` and `Equation` lines, their statements ✓ or ✗; on a directive, what it is.
- **The outline** of a page is its operations, each with its formula.
- **Completion** of the directives, the operations and the counts.
- **Snippets** `page` (a page), `op` (an operation), `transfer`, `equations`, `composition`, `states` and `remark`.
- **Run This Page:** the play button at the top of the editor, or Cmd+Enter (Ctrl+Enter on Windows and Linux). The page appears in a terminal, an operation to a line, with what was read, what was made and written, the table of multiples made or standing, and ✓ or ✗ for each row; then the page's statements and a count of them. **Run This Page, With the Whole Store After Each Operation** adds the store after each row; **Show This Page as Cards** prints the program as operation cards and the variable cards each needs; **Verify Every Page of the Corpus** runs every page built into `babbage`.

## Settings

| Setting | What it does |
| --- | --- |
| `babbage.path` | Use a `babbage` program you built yourself, both as the language server (`babbage lsp`) and to run pages. |
| `babbage.trace.server` | Log the messages exchanged with the language server. |

## Building it

From this folder, with Rust (and its `wasm32-wasip1` target) and Node installed:

```sh
npm install
npm run build        # compiles babbage to WebAssembly, bundles the extension
npm test             # grammar, language server and runner tests
npm run test:vscode  # opens a real VS Code and drives the extension
npm run package      # writes babbage-language-0.1.0.vsix
code --install-extension babbage-language-0.1.0.vsix
```

To try it without installing, open this folder in VS Code and press F5.

## How it fits together

| File | What it is |
| --- | --- |
| `syntaxes/babbage.tmLanguage.json` | The highlighting grammar, used until the language server's colours arrive. |
| `language-configuration.json` | The note character, quotation marks and parentheses. |
| `snippets/babbage.code-snippets` | A page, an operation, a transfer, the equations, a composition, the counts, a remark. |
| `src/extension.js` | Starts the language server and provides the run commands. |
| `server/babbage.wasm` | `babbage`, compiled for WASI: one program for running pages and, as `babbage lsp`, the language server. |
| `server/lsp.js` | Starts `babbage lsp`. |
| `server/run.js` | Runs a page: `babbage FILE`, `babbage --store FILE` or `babbage cards FILE`, with the page as the one file it can open; or `babbage verify`. |
| `server/wasi.js` | A small WASI host for Node, with no dependencies. |

## Licence

Apache License 2.0. See [LICENSE](LICENSE).
