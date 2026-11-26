use babbage::machine::run as run_lax;
use babbage::machine::{decisions, run_strict};
use babbage::page::read;
use babbage::rat::Rat;
use babbage::report::{cards_text, run_text, Options};
use babbage::{corpus, page::Page};
use std::collections::BTreeMap;
use std::process::exit;

const USAGE: &str = "\
babbage FILE                 run a page: every operation, every cell of the sheet checked (- reads standard input)
babbage no L001-1            a page of the corpus (babbage list)
babbage FILE --strict        never go on with the sheet's value where it differs (also with verify)
babbage FILE --store         the whole store after each operation
babbage FILE --at a=2,b=3,…  the same run, its values shown at these numbers
babbage cards FILE           the program as operation and variable cards
babbage verify               run every page, and say what agrees
babbage list                 the pages
babbage decisions            the rules of the machine, and what each rests on
babbage json FILE [--at …]   the run as JSON, for the playground
babbage lsp                  a language server on standard input and output";

fn load(arg: &str) -> Page {
    if arg == "-" {
        let mut text = String::new();
        std::io::Read::read_to_string(&mut std::io::stdin(), &mut text).unwrap();
        return read("-", &text).unwrap_or_else(|e| {
            eprintln!("{e}");
            exit(2)
        });
    }
    let (path, text) = match corpus::find(arg) {
        Some((n, t)) => (format!("corpus/{n}.bab"), t.to_string()),
        None => match std::fs::read_to_string(arg) {
            Ok(t) => (arg.to_string(), t),
            Err(e) => {
                eprintln!("{arg}: {e}");
                exit(2)
            }
        },
    };
    read(&path, &text).unwrap_or_else(|e| {
        eprintln!("{e}");
        exit(2)
    })
}

fn parse_at(s: &str) -> BTreeMap<String, Rat> {
    s.split(',')
        .map(|kv| {
            let (k, v) = kv.split_once('=').unwrap_or_else(|| {
                eprintln!("--at a=2,b=3,…");
                exit(2)
            });
            let r = match v.split_once('/') {
                Some((n, d)) => Rat::new(n.trim().parse().unwrap(), d.trim().parse().unwrap()),
                None => Rat::int(v.trim().parse().unwrap()),
            };
            (k.trim().replace('′', "'"), r)
        })
        .collect()
}

fn main() {
    let args: Vec<String> = std::env::args().skip(1).collect();
    let mut o = Options { at: None, store: false };
    let mut rest = vec![];
    let strict = args.iter().any(|a| a == "--strict");
    let run = |p: &Page| if strict { run_strict(p) } else { run_lax(p) };
    let mut i = 0;
    while i < args.len() {
        match args[i].as_str() {
            "--store" => o.store = true,
            "--strict" => {}
            "--at" => {
                i += 1;
                o.at = Some(parse_at(args.get(i).map(String::as_str).unwrap_or("")));
            }
            a => rest.push(a.to_string()),
        }
        i += 1;
    }
    match rest.iter().map(String::as_str).collect::<Vec<_>>().as_slice() {
        [] | ["help"] | ["--help"] => println!("{USAGE}"),
        ["list"] => {
            for (n, t) in corpus::PAGES {
                let p = read(n, t).unwrap();
                println!("{n:<8} {}  No. {}, {}  {}", p.sheet, p.number, p.date, p.title);
            }
        }
        ["decisions"] => {
            for (i, (rule, why)) in decisions().iter().enumerate() {
                println!("{}. {rule}\n   {why}\n", i + 1);
            }
        }
        ["verify"] => {
            let (mut all, mut good, mut bad_pages) = (0, 0, 0);
            for (n, t) in corpus::PAGES {
                let p = read(n, t).unwrap();
                let r = run(&p);
                let cs: Vec<_> = r.all_checks().collect();
                let ok = cs.iter().filter(|c| c.ok).count();
                all += cs.len();
                good += ok;
                let stop = r
                    .stopped
                    .as_ref()
                    .map(|s| format!("  stopped: {s}"))
                    .unwrap_or_default();
                println!("{n:<8} {:>3} statements, {:>3} agree{stop}", cs.len(), ok);
                for c in cs.iter().filter(|c| !c.ok) {
                    println!("         ✗ line {}: {}: {}", c.line, c.what, c.detail);
                }
                if ok != cs.len() || r.stopped.is_some() {
                    bad_pages += 1;
                }
            }
            println!(
                "\n{} pages; {all} statements of the sheets checked, {good} agree{}.",
                corpus::PAGES.len(),
                if strict {
                    " (strict: the run never takes the sheet's value)"
                } else {
                    ""
                }
            );
            if bad_pages > 0 {
                println!("{bad_pages} page(s) with statements that do not agree.");
            }
        }
        ["lsp"] => {
            let stdin = std::io::stdin();
            if let Err(e) = babbage::lsp::serve(&mut stdin.lock(), &mut std::io::stdout()) {
                eprintln!("{e}");
                exit(1)
            }
        }
        ["json", f] => {
            let text = if *f == "-" {
                let mut t = String::new();
                std::io::Read::read_to_string(&mut std::io::stdin(), &mut t).unwrap();
                t
            } else {
                match corpus::find(f) {
                    Some((_, t)) => t.to_string(),
                    None => std::fs::read_to_string(f).unwrap_or_else(|e| {
                        eprintln!("{f}: {e}");
                        exit(2)
                    }),
                }
            };
            println!("{}", babbage::play::run_json(&text, o.at.clone()));
        }
        ["cards", f] => {
            let p = load(f);
            print!("{}", cards_text(&p, &run(&p)));
        }
        ["no", f] | [f] => {
            let p = load(f);
            print!("{}", run_text(&p, &run(&p), &o));
        }
        _ => {
            eprintln!("{USAGE}");
            exit(2)
        }
    }
}
