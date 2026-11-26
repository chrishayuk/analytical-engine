//! A language server for `.bab` pages, over standard input and output
//! (`babbage lsp`). Problems as the page is typed: lines not in the notation,
//! and every statement of the sheet the run does not reach. Hover on an
//! operation shows what it took, from where, what it made and the store after
//! it; hover on a variable (`v3''`) shows the number it names. Colours come as
//! semantic tokens, so the same server colours the editor in VS Code and on
//! the web.

use crate::expr::show_var;
use crate::json::{self, obj, Json};
use crate::machine::{run, Run, Source, Step};
use crate::page::{read_all, Page};
use std::collections::HashMap;
use std::io::{BufRead, Write};

pub const TOKEN_TYPES: &[&str] = &[
    "comment",   // 0 notes
    "string",    // 1 the sheet's words
    "keyword",   // 2 directives
    "number",    // 3 figures
    "operator",  // 4 × ÷ + − | * = C
    "variable",  // 5 v1 v3''
    "parameter", // 6 the letters: a b′ x
    "macro",     // 7 Sheet, No.
];

/// (start, length, type) in characters, for one line.
pub fn line_tokens(text: &str) -> Vec<(usize, usize, usize)> {
    let cs: Vec<char> = text.chars().collect();
    let mut out = vec![];
    let lead = cs.iter().take_while(|c| c.is_whitespace()).count();
    if cs.get(lead) == Some(&'%') {
        out.push((lead, cs.len() - lead, 0));
        return out;
    }
    // the directive word
    let mut i = lead;
    while i < cs.len() && !cs[i].is_whitespace() {
        i += 1;
    }
    if i > lead {
        let word: String = cs[lead..i].iter().collect();
        out.push((lead, i - lead, if word == "Sheet" || word == "No." { 7 } else { 2 }));
    }
    let counts = cs[lead..i].iter().collect::<String>() == "States";
    let free_text = matches!(
        cs[lead..i].iter().collect::<String>().as_str(),
        "Sheet" | "No." | "Date" | "Title" | "Image" | "Remark" | "Unrun"
    );
    while i < cs.len() {
        let c = cs[i];
        if c == '%' && i > 0 && cs[i - 1] == ' ' {
            out.push((i, cs.len() - i, 0));
            break;
        }
        if c == '"' {
            let mut j = i + 1;
            while j < cs.len() && cs[j] != '"' {
                j += 1;
            }
            let end = (j + 1).min(cs.len());
            out.push((i, end - i, 1));
            i = end;
            continue;
        }
        if free_text {
            i += 1;
            continue;
        }
        if c == 'v' && cs.get(i + 1).is_some_and(|d| d.is_ascii_digit()) {
            let mut j = i + 1;
            while j < cs.len() && cs[j].is_ascii_digit() {
                j += 1;
            }
            while j < cs.len() && matches!(cs[j], '\'' | '′' | '″' | '‴') {
                j += 1;
            }
            out.push((i, j - i, 5));
            i = j;
            continue;
        }
        if c.is_ascii_digit() {
            let mut j = i;
            while j < cs.len() && cs[j].is_ascii_digit() {
                j += 1;
            }
            out.push((i, j - i, 3));
            i = j;
            continue;
        }
        if c == 'C' {
            out.push((i, 1, 4));
            i += 1;
            continue;
        }
        if counts && c.is_alphabetic() {
            // great, small, total …: the names of counts, not letters
            let mut j = i + 1;
            while j < cs.len() && cs[j].is_alphabetic() {
                j += 1;
            }
            out.push((i, j - i, 2));
            i = j;
            continue;
        }
        if c.is_alphabetic() {
            let mut j = i + 1;
            if c.is_ascii_lowercase() || !c.is_ascii() {
                while j < cs.len() && matches!(cs[j], '\'' | '′') {
                    j += 1;
                }
                out.push((i, j - i, 6));
            } else {
                while j < cs.len() && cs[j].is_alphabetic() {
                    j += 1;
                }
            }
            i = j;
            continue;
        }
        if "×÷+−-|*=·/✱".contains(c) {
            out.push((i, 1, 4));
        }
        i += 1;
    }
    out
}

fn u16_col(text: &str, c: usize) -> usize {
    text.chars().take(c).map(|ch| ch.len_utf16()).sum()
}

fn char_at_u16(text: &str, col16: usize) -> usize {
    let mut n = 0;
    for (i, ch) in text.chars().enumerate() {
        if n >= col16 {
            return i;
        }
        n += ch.len_utf16();
    }
    text.chars().count()
}

fn position(line: usize, character: usize) -> Json {
    obj([("line", line.into()), ("character", character.into())])
}

fn range(line: usize, start: usize, end: usize) -> Json {
    obj([("start", position(line, start)), ("end", position(line, end))])
}

pub struct Analysis {
    pub page: Page,
    pub errors: Vec<(usize, String)>,
    pub run: Run,
}

pub fn analyse(text: &str) -> Analysis {
    let (page, errors) = read_all("page", text);
    let run = run(&page);
    Analysis { page, errors, run }
}

/// (line from 0, severity, message): errors in the notation, then every
/// statement of the sheet that the run does not reach.
pub fn problems(a: &Analysis) -> Vec<(usize, u8, String)> {
    let mut out: Vec<(usize, u8, String)> = a.errors.iter().map(|(n, e)| (n - 1, 1, e.clone())).collect();
    if let (Some(line), Some(s)) = (a.run.stopped_line, &a.run.stopped) {
        out.push((
            line - 1,
            1,
            format!("the run stops here: {s}. Nothing after it is checked"),
        ));
    }
    for c in a.run.all_checks().filter(|c| !c.ok) {
        out.push((c.line.max(1) - 1, 2, format!("{}: {}", c.what, c.detail)));
    }
    out
}

fn diagnostics(uri: &str, text: &str) -> Json {
    let lines: Vec<&str> = text.lines().collect();
    let a = analyse(text);
    let list: Vec<Json> = problems(&a)
        .into_iter()
        .map(|(n, sev, msg)| {
            let l = lines.get(n).copied().unwrap_or("");
            let start = u16_col(l, l.chars().take_while(|c| c.is_whitespace()).count());
            let end = l.encode_utf16().count().max(start + 1);
            obj([
                ("range", range(n, start, end)),
                ("severity", (sev as usize).into()),
                ("source", "babbage".into()),
                ("message", msg.into()),
            ])
        })
        .collect();
    obj([
        ("jsonrpc", "2.0".into()),
        ("method", "textDocument/publishDiagnostics".into()),
        ("params", obj([("uri", uri.into()), ("diagnostics", list.into())])),
    ])
}

fn capabilities() -> Json {
    obj([
        (
            "capabilities",
            obj([
                ("textDocumentSync", 1.into()),
                ("hoverProvider", true.into()),
                ("documentSymbolProvider", true.into()),
                (
                    "semanticTokensProvider",
                    obj([
                        (
                            "legend",
                            obj([
                                (
                                    "tokenTypes",
                                    TOKEN_TYPES.iter().map(|t| Json::from(*t)).collect::<Vec<_>>().into(),
                                ),
                                ("tokenModifiers", Vec::new().into()),
                            ]),
                        ),
                        ("full", true.into()),
                    ]),
                ),
                ("completionProvider", obj([("resolveProvider", false.into())])),
            ]),
        ),
        (
            "serverInfo",
            obj([
                ("name", "babbage".into()),
                ("version", env!("CARGO_PKG_VERSION").into()),
            ]),
        ),
    ])
}

/// (line, start, length, type) in UTF-16 columns, in order.
pub fn semantic(text: &str) -> Vec<(usize, usize, usize, usize)> {
    let mut out = vec![];
    for (n, l) in text.lines().enumerate() {
        let mut toks = line_tokens(l);
        toks.sort_by_key(|t| t.0);
        for (s, len, k) in toks {
            let a = u16_col(l, s);
            let b = u16_col(l, s + len);
            if b > a {
                out.push((n, a, b - a, k));
            }
        }
    }
    out
}

fn semantic_tokens(text: &str) -> Json {
    let mut data = Vec::new();
    let (mut last_line, mut last_start) = (0, 0);
    for (line, start, length, kind) in semantic(text) {
        let delta = if line == last_line { start - last_start } else { start };
        data.extend([line - last_line, delta, length, kind, 0].map(Json::from));
        (last_line, last_start) = (line, start);
    }
    obj([("data", data.into())])
}

fn step_markdown(s: &Step) -> String {
    let r = &s.row;
    let mut md = match r.op {
        Some(op) => format!("**Operation {}** {}", r.number, op.sign()),
        None => format!("**Operation {}**, a transfer", r.number),
    };
    if !r.card_text.is_empty() {
        md += &format!(" `{}`", r.card_text);
    }
    md += "\n\n";
    for (i, (src, v)) in s.cards.operands.iter().enumerate() {
        let what = match src {
            Source::Read(n) => format!("from v{n}, which is left at zero"),
            Source::Table => "from the table of multiples still standing in the mill".into(),
        };
        let role = match (r.op, i) {
            (Some(crate::page::Op::Mul), 0) => "multiplicand",
            (Some(crate::page::Op::Mul), _) => "multiplier",
            (Some(_), 0) => "first",
            (Some(_), _) => "second",
            (None, _) => "moved",
        };
        md += &format!("- {role}: {v}, {what}\n");
    }
    if s.cards.table_formed {
        md += "- a table of multiples of the multiplicand is made\n";
    }
    if let Some(res) = &s.result {
        md += &format!("- result: {res}\n");
    }
    for (c, v) in &s.cards.writes {
        md += &format!("- v{c} ← {v}\n");
    }
    md += "\n";
    for c in &s.checks {
        if c.ok {
            md += &format!("✓ {}  \n", c.what);
        } else {
            md += &format!("✗ {}: {}  \n", c.what, c.detail);
        }
    }
    let cells: Vec<String> = s
        .store_after
        .iter()
        .filter(|(_, h)| !h.is_zero())
        .map(|(c, h)| format!("v{c} {h}"))
        .collect();
    md += &format!("\nStore after: {}", cells.join(" · "));
    md
}

/// Markdown for the hover at (line, UTF-16 column), both from 0.
pub fn hover(text: &str, line: usize, col16: usize) -> Option<String> {
    let l = text.lines().nth(line)?;
    let a = analyse(text);
    let at = char_at_u16(l, col16);
    // a variable under the cursor
    for (s, len, k) in line_tokens(l) {
        if k == 5 && at >= s && at < s + len {
            let tok: String = l.chars().skip(s).take(len).collect();
            if let Ok(crate::expr::Expr::Var(n, p)) = crate::expr::parse(&tok) {
                let h = a.run.history.get(&n);
                return Some(match h.and_then(|h| h.get(p)) {
                    Some(v) => format!("`{}` is v{n} {}: **{v}**", show_var(n, p), crate::expr::changes(p)),
                    None => format!(
                        "`{}` would be v{n} {}, but in this run v{n} changes only {}",
                        show_var(n, p),
                        crate::expr::changes(p),
                        crate::expr::times(h.map_or(0, |h| h.len().saturating_sub(1)))
                    ),
                });
            }
        }
    }
    let n = line + 1;
    if let Some(s) = a.run.steps.iter().find(|s| s.row.line == n) {
        return Some(step_markdown(s));
    }
    let here: Vec<String> = a
        .run
        .checks
        .iter()
        .filter(|c| c.line == n)
        .map(|c| {
            if c.ok {
                format!("✓ {}", c.what)
            } else {
                format!("✗ {}: {}", c.what, c.detail)
            }
        })
        .collect();
    if !here.is_empty() {
        return Some(here.join("  \n"));
    }
    let word = l.split_whitespace().next()?;
    KEYWORD_HELP
        .iter()
        .find(|k| k.0 == word)
        .map(|k| format!("**{}** {}", k.0, k.1))
}

pub const KEYWORD_HELP: &[(&str, &str)] = &[
    ("Sheet", "the archive reference of the sheet: `Sheet BAB/L/001`"),
    ("No.", "Babbage's number for the program on the sheet"),
    ("Date", "the date the sheet gives"),
    ("Title", "the heading of the table, quoted"),
    ("Image", "the Science Museum Group image the table is read from"),
    ("Letters", "the letters the values are made of: `Letters a b c a' b' c'`"),
    ("Unknowns", "the unknowns of the equations: `Unknowns x y`"),
    ("Equation", "an equation the sheet solves: `Equation a x + b y + c = 0`"),
    ("Find", "a result as the sheet states it: `Find x = (bc'-b'c)/(b'a-ba')`"),
    ("Store", "what the store holds at the start: `Store v1 = a, v2 = b`"),
    ("Working", "the working variables: `Working v7`"),
    (
        "Op",
        "an operation: `Op 1 × | b'a | v1 0, v5 0, v7 b'a | v7 = v5·v1` (number, operation, mill, store cells, formula)",
    ),
    (
        "In",
        "numbers given to the store from outside the table, between operations: `In v1 f1, v2 g1`",
    ),
    (
        "Composition",
        "the sheet's composition of a result: each member equal to the one before (ending `= 0`: as equations)",
    ),
    (
        "States",
        "the counts the sheet gives: great, small, total, variables, working, occupied",
    ),
    ("Remark", "the sheet's remark, quoted, not run"),
    ("Unrun", "something on the sheet transcribed but not run (pencil, scribbles)"),
];

fn completion() -> Json {
    let mut items: Vec<Json> = KEYWORD_HELP
        .iter()
        .map(|(k, d)| obj([("label", (*k).into()), ("kind", 14.into()), ("detail", (*d).into())]))
        .collect();
    for (op, d) in [
        ("×", "multiplication"),
        ("÷", "division"),
        ("+", "addition"),
        ("−", "subtraction"),
    ] {
        items.push(obj([("label", op.into()), ("kind", 24.into()), ("detail", d.into())]));
    }
    for w in ["great", "small", "total", "variables", "working", "occupied"] {
        items.push(obj([
            ("label", w.into()),
            ("kind", 6.into()),
            ("detail", "a count".into()),
        ]));
    }
    items.into()
}

fn symbols(text: &str) -> Json {
    let a = analyse(text);
    let lines: Vec<&str> = text.lines().collect();
    let w = |n: usize| lines.get(n).map_or(0, |l| l.encode_utf16().count());
    let mut out = vec![];
    for r in &a.page.rows {
        let n = r.line - 1;
        let name = match r.op {
            Some(op) => format!("{} {}  {}", r.number, op.sign(), r.card_text),
            None => format!("{}  {}", r.number, r.card_text),
        };
        out.push(obj([
            ("name", name.into()),
            ("kind", 12.into()),
            ("range", range(n, 0, w(n))),
            ("selectionRange", range(n, 0, w(n))),
        ]));
    }
    out.into()
}

fn answer(method: &str, params: &Json, docs: &HashMap<String, String>) -> Option<Json> {
    let uri = params.get("textDocument").get("uri").str().unwrap_or("");
    let text = docs.get(uri).map(String::as_str).unwrap_or("");
    let line = params.get("position").get("line").num().unwrap_or(0);
    let col = params.get("position").get("character").num().unwrap_or(0);
    Some(match method {
        "initialize" => capabilities(),
        "shutdown" => Json::Null,
        "textDocument/hover" => match hover(text, line, col) {
            Some(h) => obj([("contents", obj([("kind", "markdown".into()), ("value", h.into())]))]),
            None => Json::Null,
        },
        "textDocument/semanticTokens/full" => semantic_tokens(text),
        "textDocument/documentSymbol" => symbols(text),
        "textDocument/completion" => completion(),
        _ => return None,
    })
}

fn read_message(input: &mut impl BufRead) -> Option<Json> {
    let mut length = None;
    loop {
        let mut line = String::new();
        if input.read_line(&mut line).ok()? == 0 {
            return None;
        }
        let line = line.trim_end();
        if line.is_empty() {
            break;
        }
        if let Some((name, value)) = line.split_once(':') {
            if name.eq_ignore_ascii_case("content-length") {
                length = value.trim().parse::<usize>().ok();
            }
        }
    }
    let mut body = vec![0; length?];
    input.read_exact(&mut body).ok()?;
    json::parse(&String::from_utf8_lossy(&body)).ok()
}

fn send(output: &mut impl Write, message: Json) {
    let mut body = String::new();
    message.write(&mut body);
    let _ = write!(output, "Content-Length: {}\r\n\r\n{}", body.len(), body);
    let _ = output.flush();
}

pub fn serve(input: &mut impl BufRead, output: &mut impl Write) -> Result<(), String> {
    let mut docs: HashMap<String, String> = HashMap::new();
    let mut shutting_down = false;
    while let Some(message) = read_message(input) {
        let method = message.get("method").str().unwrap_or("").to_string();
        let params = message.get("params");
        let id = message.get("id").clone();
        let uri = params.get("textDocument").get("uri").str().unwrap_or("").to_string();
        match method.as_str() {
            "exit" => {
                return if shutting_down {
                    Ok(())
                } else {
                    Err("exit without shutdown".into())
                }
            }
            "textDocument/didOpen" => {
                let text = params.get("textDocument").get("text").str().unwrap_or("").to_string();
                send(output, diagnostics(&uri, &text));
                docs.insert(uri, text);
            }
            "textDocument/didChange" => {
                if let Some(text) = params
                    .get("contentChanges")
                    .items()
                    .last()
                    .and_then(|c| c.get("text").str())
                {
                    send(output, diagnostics(&uri, text));
                    docs.insert(uri, text.to_string());
                }
            }
            "textDocument/didClose" => {
                docs.remove(&uri);
                send(output, diagnostics(&uri, ""));
            }
            _ if id == Json::Null => {}
            _ => {
                shutting_down |= method == "shutdown";
                let reply = match answer(&method, params, &docs) {
                    Some(result) => obj([("jsonrpc", "2.0".into()), ("id", id), ("result", result)]),
                    None => obj([
                        ("jsonrpc", "2.0".into()),
                        ("id", id),
                        (
                            "error",
                            obj([
                                ("code", Json::Num(-32601.0)),
                                ("message", format!("method not found: {method}").into()),
                            ]),
                        ),
                    ]),
                };
                send(output, reply);
            }
        }
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    const P1: &str = include_str!("../corpus/L001-1.bab");

    #[test]
    fn hover_on_an_operation_and_a_variable() {
        let lines: Vec<&str> = P1.lines().collect();
        let op2 = lines.iter().position(|l| l.starts_with("Op 2")).unwrap();
        let h = hover(P1, op2, 2).unwrap();
        assert!(h.contains("table of multiples still standing"), "{h}");
        let col = lines[op2].find("v1'").unwrap();
        let h = hover(P1, op2, col + 1).unwrap();
        assert!(h.contains("v1 after 1 change") && h.contains("b′c"), "{h}");
    }

    #[test]
    fn tokens_and_problems() {
        assert!(!semantic(P1).is_empty());
        let states = line_tokens("States great 5, small 2");
        assert_eq!(states, vec![(0, 6, 2), (7, 5, 2), (13, 1, 3), (16, 5, 2), (22, 1, 3)]);
        assert!(problems(&analyse(P1)).is_empty());
        let bad = P1.replace("Op 3", "Opp 3");
        let p = problems(&analyse(&bad));
        assert!(p.iter().any(|(_, s, m)| *s == 1 && m.contains("`Opp`")), "{p:?}");
    }
}
