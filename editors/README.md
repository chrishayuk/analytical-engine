# Babbage's notations in your editor

Two pieces give an editor an understanding of a page:

- **`babbage lsp`**, a language server. It is the `babbage` program itself, given the argument `lsp`, and it works with any editor that speaks the Language Server Protocol.
- **A Visual Studio Code extension** in [`vscode`](vscode), which bundles `babbage` and adds syntax highlighting and run buttons. Its [README](vscode/README.md) lists the features.

Both are built on the reconstruction itself: [`src/page.rs`](../src/page.rs) reads the page, [`src/machine.rs`](../src/machine.rs) is the engine and what each row does on it, and [`src/lsp.rs`](../src/lsp.rs) reports the same checks `babbage FILE` prints. So the editor and `babbage` cannot disagree about what is on the page. The notation is in [`docs/notation.md`](../docs/notation.md).

A `.bab` file is one table of one of Babbage's sheets, a directive to a line: what the sheet is (`Sheet`, `No.`, `Date`, `Title`, `Image`), the letters and the equations (`Letters`, `Unknowns`, `Equation`, `Find`), the store at the start (`Store`, `Working`), each operation as a row of four fields separated by `|` (`Op 2  ×  | b'c | v1 b'c, v3 0 | v1' = v5·v3`), and what the sheet states of the whole (`Composition`, `States`), with what is kept but not run (`Remark`, `Unrun`). Words in double quotes are the sheet's own. `%` starts a note (at the start of a line, or after a space); notes are not on the sheet.

## The language server

In a clone of this repository, `cargo build --release` writes `target/release/babbage`; or `cargo install --path .`.

`babbage lsp` talks on standard input and output. It provides diagnostics, hover, semantic tokens, document symbols and completion.

- **Diagnostics.** A line that is not in the notation is an error; the rest of the page is still read. An operation the run cannot do (an operand that has never held a number, a letter the page does not have) is an error on its row, and nothing after it is checked. Every statement of the sheet that the run does not reach is a warning, with what the run gives: a store cell, a mill entry, the operation's formula, the accents on the variable written, a member of a composition, a count, a result the page states, the solution of its equations.
- **Hover** on an operation shows each operand and where it came from (a column the row leaves at zero, or the table of multiples still standing in the mill), whether a table is made, the result, each cell written, every statement of the row ✓ or ✗, and the store after it. On a variable with its accents (`v3''`), the number it names: the third number v3 has held, in this run. On a `Composition`, `States`, `Find` or `Equation` line, its statements; on a directive, what it is.
- **Semantic tokens** mean an editor with no grammar for the notation still gets colours. The legend is `comment` (notes), `string` (the sheet's words), `keyword` (directives), `number` (figures), `operator` (`×` `÷` `+` `−` `=` `·` `/`, `|`, the star, and the `C` of a complement), `variable` (the store's variables, with their accents), `parameter` (the letters and the names of results) and `macro` (`Sheet` and `No.`).
- **Document symbols** are the operations, each named by its number, operation and formula.
- **Completion** of the directives, the operations and the counts.

It also builds for WASI (`cargo build --release --target wasm32-wasip1`, which writes `target/wasm32-wasip1/release/babbage.wasm`). That one file is both the checker and the server, and is how the VS Code extension runs it.

### Neovim (0.11 or later)

```lua
vim.filetype.add({ extension = { bab = "babbage" } })
vim.lsp.config("babbage", {
  cmd = { "/path/to/babbage", "lsp" },
  filetypes = { "babbage" },
})
vim.lsp.enable("babbage")
```

Neovim colours from semantic tokens without a grammar. To have `gcc` comment a line, add `vim.bo.commentstring = "% %s"` in a `babbage` filetype autocommand.

### Helix

In `languages.toml`:

```toml
[language-server.babbage]
command = "/path/to/babbage"
args = ["lsp"]

[[language]]
name = "babbage"
scope = "source.bab"
file-types = ["bab"]
comment-token = "%"
language-servers = ["babbage"]
```

Helix does not colour from semantic tokens, so without a tree-sitter grammar the page is not highlighted; diagnostics, hover, symbols and completion work.

### Emacs (Eglot)

```elisp
(define-derived-mode babbage-mode text-mode "Babbage"
  (setq-local comment-start "% "))
(add-to-list 'auto-mode-alist '("\\.bab\\'" . babbage-mode))
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '(babbage-mode "/path/to/babbage" "lsp")))
```

### Any other LSP client

Start `babbage lsp` for files that end in `.bab`, with the language id `babbage`. The server wants the whole text on every change (full document sync) and counts positions in UTF-16 code units.

These configurations follow each editor's documented format but have not been run here; the server itself is tested over standard input and output by `vscode/test/lsp.test.mjs`, against both the WebAssembly build and the native program.

## Running a page from the command line

```sh
babbage page.bab
```

prints the page an operation to a line: what was read, the table of multiples made or standing, what was written, and ✓ or ✗ for each row, with what the run gives where a statement is not reached; then the page's statements and a count of them. `babbage page.bab --store` adds the whole store after each operation, `babbage cards page.bab` prints the program as operation and variable cards, and `babbage verify` runs every page of the corpus. A line not in the notation stops `babbage page.bab` with `path:line: message` and status 2; a statement that does not agree does not change the exit status.
