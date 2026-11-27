use babbage::machine::run as run_lax;
use babbage::machine::{decisions, run_model, Model};
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
babbage FILE --model=transfer-keeps
                             a competing reading: a transfer moves a number as it is (rule 5 says it complements)
babbage FILE --model=complement-as-held
                             another: the mill takes a complement read as the wheels hold it, −x (rule 24 says x)
babbage FILE --store         the whole store after each operation
babbage FILE --at a=2,b=3,…  the same run, its values shown at these numbers
babbage cards FILE           the program as operation and variable cards
babbage verify               run every page, and say what agrees
babbage list                 the pages
babbage history              each capability: conceived, designed, used, revised (Series N and the corpus)
babbage history pages        each page's capabilities against the record before its date
babbage history pages --as-of 1837-08-04
                             each page against the machine as evidenced by that date: what it needs that is not yet
babbage mechanical [D] [N]   multiplication in the mechanical notation: F001 (1835), F013 (by table), F018 (Jan 1836); band N's timing
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
    let transfer_keeps = args.iter().any(|a| a == "--model=transfer-keeps");
    let complement_as_held = args.iter().any(|a| a == "--model=complement-as-held");
    let run = |p: &Page| {
        if strict || transfer_keeps || complement_as_held {
            run_model(
                p,
                Model {
                    strict,
                    transfer_keeps,
                    complement_as_held,
                },
            )
        } else {
            run_lax(p)
        }
    };
    let mut i = 0;
    while i < args.len() {
        match args[i].as_str() {
            "--store" => o.store = true,
            "--strict" | "--model=transfer-keeps" | "--model=complement-as-held" => {}
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
        ["mechanical", ..] => {
            use babbage::mechanical::{chart, f018_states, in_motion, multiplier, read, Kind, DESIGNS};
            let key = rest.get(1).map(String::as_str).unwrap_or("F001");
            let band: u8 = rest.get(2).and_then(|c| c.parse().ok()).unwrap_or(1);
            println!("Multiplication in the mechanical notation, three designs (Series F).\n");
            let band_of = |sheet: &str, n: u8, text: &str| {
                read(text).unwrap_or_else(|e| {
                    eprintln!("{sheet} band {n}: {e}");
                    exit(2)
                })
            };
            println!("design  band  sheet       rows  marks  unknown  most columns in motion");
            for d in DESIGNS {
                for (sheet, n, text) in d.bands {
                    let b = band_of(sheet, *n, text);
                    let unknown = b.marks.iter().filter(|m| m.kind == Kind::Unknown).count();
                    let peak = in_motion(&b).into_iter().max().unwrap_or(0);
                    let first = b.rows.first().map(|r| r.to_string()).unwrap_or_default();
                    let last = b.rows.last().map(|r| r.to_string()).unwrap_or_default();
                    println!(
                        "{:<6}  {n:>4}  {sheet}  {:>4}  {:>5}  {unknown:>7}  {peak:>3}    {first}…{last}{}",
                        d.key,
                        b.rows.len(),
                        b.marks.len(),
                        b.incomplete
                            .as_ref()
                            .map(|w| format!("  incomplete: {w}"))
                            .unwrap_or_default()
                    );
                }
            }
            println!("\nF001: the multiplier's figures as written, band by band:");
            let seq: Vec<String> = DESIGNS[0]
                .bands
                .iter()
                .map(|(s, n, t)| multiplier(&band_of(s, *n, t).marks))
                .collect();
            println!("  {}", seq.join(" → "));
            println!("\nF018: each product written, against the band's own words (Add: + the multiplicand the band writes; Step up: × 10):");
            let states = f018_states().unwrap_or_else(|e| {
                eprintln!("F018: {e}");
                exit(2)
            });
            for (n, said, p, r) in states {
                let p = p.map(|p| format!("{p:06}")).unwrap_or_else(|| "-".into());
                match r {
                    Ok(()) => println!("  band {n}  {said:<8} {p}  ✓"),
                    Err(e) => println!("  band {n}  {said:<8} {p}  ✗ {e}"),
                }
            }
            if let Some(d) = DESIGNS.iter().find(|d| d.key.eq_ignore_ascii_case(key)) {
                if let Some((sheet, _, text)) = d.bands.iter().find(|b| b.1 == band) {
                    let b = band_of(sheet, band, text);
                    println!("\n{}, band {band} ({sheet}):\n", d.name);
                    print!("{}", chart(&b));
                    if let Some(w) = &b.incomplete {
                        println!("(incomplete: {w})");
                    }
                    println!("\n↓ ↑ arrow (a motion), | its continuation, · rest, w words, ? a mark no source explains, figures as written.");
                }
            }
            println!("\nFigures and words are Babbage's; the checks compare his figures with his words. Nothing simulates the mechanism, and no mark");
            println!("is given a meaning no source gives it (docs/f-cycles.md, docs/f-concordance.md). babbage mechanical [F001|F013|F018] [band]");
        }
        ["control", "run", "-", rest @ ..] => {
            // Every configuration on the deck from standard input, as JSON
            // (the notebook's explorer). --trap / --no-trap: Model D or not.
            let mut text = String::new();
            std::io::Read::read_to_string(&mut std::io::stdin(), &mut text).unwrap();
            let trap = match rest {
                ["--trap"] => Some(true),
                ["--no-trap"] => Some(false),
                _ => None,
            };
            match babbage::sketch::read(&text) {
                Err(e) => {
                    let mut out = String::new();
                    babbage::json::obj([("error", e.into())]).write(&mut out);
                    println!("{out}");
                }
                Ok(d) => {
                    let mut out = String::new();
                    babbage::sketch::report_json(&d, trap).write(&mut out);
                    println!("{out}");
                }
            }
        }
        ["control", "minsky", prog, regs, ending] => {
            // A counter machine translated into a deck: add or mul, the
            // counters as 3,4, and loop | trap1838 | trap1837.
            use babbage::minsky::{compile_with, Ending, Ins};
            let add = [Ins::Dec(1, 1, 2), Ins::Inc(0, 0), Ins::Halt];
            let mul = [
                Ins::Dec(0, 1, 6),
                Ins::Dec(1, 2, 4),
                Ins::Inc(2, 3),
                Ins::Inc(3, 1),
                Ins::Dec(3, 5, 0),
                Ins::Inc(1, 4),
                Ins::Halt,
            ];
            let p: &[Ins] = if *prog == "mul" { &mul } else { &add };
            let regs: Vec<i64> = regs.split(',').map(|r| r.parse().unwrap()).collect();
            let e = match *ending {
                "trap1838" => Ending::Trap1838,
                "trap1837" => Ending::Trap1837,
                _ => Ending::CountInLoop,
            };
            print!("{}", compile_with(prog, p, &regs, e));
        }
        ["control", "lean-cases", dir, n] => {
            // The cases of the differential test against the Lean model
            // (scripts/lean-diff.sh): DIR/NAME.deck for Lean, DIR/NAME.rust.
            let n: usize = n.parse().unwrap_or_else(|_| {
                eprintln!("babbage control lean-cases DIR N");
                exit(2)
            });
            std::fs::create_dir_all(dir).unwrap();
            let cases = babbage::difftest::cases(n);
            for (name, deck, rust) in &cases {
                std::fs::write(format!("{dir}/{name}.deck"), deck).unwrap();
                std::fs::write(format!("{dir}/{name}.rust"), rust).unwrap();
            }
            println!("{} cases written to {dir}", cases.len());
        }
        ["control", ..] => {
            use babbage::sketch::{accepts, expected, read, run, CONFIGS, DECKS};
            println!("The control mechanisms of the Sketch Books, by date: which decks each accepts (docs/expressiveness.md).\n");
            for c in CONFIGS {
                println!(
                    "  {:<10} {}{}",
                    c.key,
                    c.source,
                    if c.found { "" } else { "  [NOT FOUND in the pages read]" }
                );
            }
            for (name, text) in DECKS {
                let d = read(text).unwrap_or_else(|e| {
                    eprintln!("{name}: {e}");
                    exit(2)
                });
                println!("\n{name}: {}", d.title);
                for c in CONFIGS {
                    let line = match accepts(c, &d) {
                        Err(e) => format!("not accepted: {e}"),
                        Ok(()) => match run(c, &d) {
                            Err(e) => format!("fails: {e}"),
                            Ok(o) => {
                                let bad = expected(&d, &o);
                                let shown: Vec<String> = o.results.iter().take(4).map(|v| v.to_string()).collect();
                                format!(
                                    "{} {}; {} result{}: {}{}; mill {}; wheels −1 ×{}{}",
                                    if bad.is_empty() { "✓" } else { "✗" },
                                    if o.halted { "halts" } else { "runs on" },
                                    o.results.len(),
                                    if o.results.len() == 1 { "" } else { "s" },
                                    shown.join(", "),
                                    if o.results.len() > 4 { ", …" } else { "" },
                                    o.mill
                                        .iter()
                                        .map(|(k, v)| format!("{k}{v}"))
                                        .collect::<Vec<_>>()
                                        .join(" "),
                                    o.wheel_steps,
                                    if bad.is_empty() {
                                        String::new()
                                    } else {
                                        format!("  ✗ {}", bad.join("; "))
                                    }
                                )
                            }
                        },
                    };
                    println!("  {:<10} {line}", c.key);
                }
            }
            println!("\nA deck runs on only where the observer stops it (Stop), as L/023's table does. Nothing here chooses between cards.");
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
            let m = Model {
                strict,
                transfer_keeps,
                complement_as_held,
            };
            println!("{}", babbage::play::run_json_with(&text, o.at.clone(), m));
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
