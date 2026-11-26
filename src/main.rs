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
babbage history              each capability: conceived, designed, used, revised (Series N and the corpus)
babbage history pages        each page's capabilities against the record before its date
babbage history pages --as-of 1837-08-04
                             each page against the machine as evidenced by that date: what it needs that is not yet
babbage uses [FILE]          the machine's capabilities each page needs, and the rows that need them
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
    let mut as_of: Option<String> = None;
    let run = |p: &Page| if strict { run_strict(p) } else { run_lax(p) };
    let mut i = 0;
    while i < args.len() {
        match args[i].as_str() {
            "--store" => o.store = true,
            "--strict" => {}
            "--as-of" => {
                i += 1;
                as_of = args.get(i).cloned();
            }
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
        ["history"] | ["history", "pages"] => {
            use babbage::history::{chronology, sheet_date, standing, used, Standing, When, CAPABILITIES};
            let record = chronology().unwrap_or_else(|e| {
                eprintln!("{e}");
                exit(2)
            });
            // Every page's date and the capabilities it uses.
            let pages: Vec<(String, Option<When>, Vec<&str>)> = corpus::PAGES
                .iter()
                .map(|(n, t)| {
                    let p = read(n, t).unwrap();
                    let u = used(&p, &run(&p));
                    let caps = CAPABILITIES.iter().map(|c| c.0).filter(|c| u.contains_key(c)).collect();
                    (n.to_string(), sheet_date(&p.date), caps)
                })
                .collect();
            let users = |cap: &str| -> Vec<When> {
                pages
                    .iter()
                    .filter(|p| p.2.contains(&cap))
                    .filter_map(|p| p.1)
                    .collect()
            };
            if rest.len() == 1 {
                for (cap, what) in CAPABILITIES {
                    println!("{cap}: {what}");
                    for kind in ["conceived", "designed"] {
                        for direct in [true, false] {
                            if let Some(e) = record
                                .iter()
                                .filter(|e| e.capability == *cap && e.kind == kind && e.direct == direct)
                                .min_by_key(|e| e.when)
                            {
                                let rel = if direct { "" } else { " (related)" };
                                println!(
                                    "  {kind:<10}{rel:<10} {:<16} {}: \"{}\"",
                                    e.when.to_string(),
                                    e.source,
                                    e.words
                                );
                            }
                        }
                    }
                    let mut us: Vec<(&String, &Option<When>)> = pages
                        .iter()
                        .filter(|p| p.2.contains(cap))
                        .map(|p| (&p.0, &p.1))
                        .collect();
                    us.sort_by_key(|u| {
                        u.1.map(|w| (0, w)).unwrap_or((
                            1,
                            When {
                                year: 0,
                                month: 0,
                                day: 0,
                                before: false,
                            },
                        ))
                    });
                    match us.first() {
                        Some((n, Some(w))) => println!(
                            "  {:<20} {:<16} {n} (first of {} pages)",
                            "used",
                            w.to_string(),
                            us.len()
                        ),
                        Some((n, None)) => {
                            println!("  {:<20} {:<16} {n} (undated; {} pages)", "used", "undated", us.len())
                        }
                        None => println!("  {:<20} not in the corpus", "used"),
                    }
                    for e in record.iter().filter(|e| e.capability == *cap && e.kind == "revised") {
                        println!(
                            "  {:<20} {:<16} {}: \"{}\"",
                            "revised",
                            e.when.to_string(),
                            e.source,
                            e.words
                        );
                    }
                }
            } else if let Some(d) = &as_of {
                // The machine as evidenced by a date: a capability is there
                // if the history records it (direct) by then, or a sheet
                // dated by then uses it. Nothing is enabled or disabled: the
                // run is the same; this says what it needed that was not yet.
                let Some(at) = babbage::history::parse_iso(d) else {
                    eprintln!("--as-of 1837-08-04");
                    exit(2)
                };
                let there = |c: &str| {
                    record
                        .iter()
                        .any(|e| e.capability == c && e.direct && e.when.not_after(&at) == Some(true))
                        || users(c).iter().any(|u| u.not_after(&at) == Some(true))
                };
                println!("The machine as evidenced by {at}:");
                for (n, date, caps) in &pages {
                    let missing: Vec<&str> = caps.iter().copied().filter(|c| !there(c)).collect();
                    let when = date.map(|w| w.to_string()).unwrap_or_else(|| "undated".into());
                    if missing.is_empty() {
                        println!("{n:<8} {when:<18} runs");
                    } else {
                        println!("{n:<8} {when:<18} needs {}", missing.join(", "));
                    }
                }
            } else {
                for (n, date, caps) in &pages {
                    let Some(at) = date else {
                        println!("{n:<8} undated: {}", caps.join(" "));
                        continue;
                    };
                    let parts: Vec<String> = caps
                        .iter()
                        .map(|c| {
                            let mark = match standing(c, at, &record, &users(c)) {
                                Standing::Recorded => "recorded",
                                Standing::RelatedOnly => "related only",
                                Standing::UsedBefore => "used before",
                                Standing::FirstHere => "first here",
                                Standing::SameMonth => "same month",
                            };
                            format!("{c} ({mark})")
                        })
                        .collect();
                    println!("{n:<8} {:<17} {}", at.to_string(), parts.join(", "));
                }
            }
        }
        ["uses"] => {
            let names: Vec<&str> = babbage::history::CAPABILITIES.iter().map(|c| c.0).collect();
            for (n, t) in corpus::PAGES {
                let p = read(n, t).unwrap();
                let u = babbage::history::used(&p, &run(&p));
                let have: Vec<&str> = names.iter().copied().filter(|c| u.contains_key(c)).collect();
                println!("{n:<8} {:<12} {}", p.date, have.join(" "));
            }
        }
        ["uses", f] => {
            let p = load(f);
            let u = babbage::history::used(&p, &run(&p));
            for (name, what) in babbage::history::CAPABILITIES {
                if let Some(rows) = u.get(name) {
                    let rows: Vec<String> = rows.iter().filter(|r| **r > 0).map(|r| r.to_string()).collect();
                    let at = if rows.is_empty() {
                        "the page".to_string()
                    } else {
                        format!("rows {}", rows.join(", "))
                    };
                    println!("{name:<20} {at}\n{:<20} {what}", "");
                }
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
