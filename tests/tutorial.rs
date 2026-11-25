//! Every page and every command in the tutorial is run, and what it prints is
//! compared with what the tutorial says it prints. `BABBAGE_BLESS=1 cargo test
//! --test tutorial` writes what it prints into the tutorial instead.
//!
//! A page is a fence opened with ```bab (or ```bab --store, and so on),
//! followed by a fence holding its output. A command is a line `$ babbage …`
//! in a ```console fence; its output is the lines after it, up to the next
//! `$` line or the end of the fence.

use std::path::{Path, PathBuf};
use std::process::Command;

fn root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
}

fn babbage(args: &[String]) -> String {
    let out = Command::new(env!("CARGO_BIN_EXE_babbage"))
        .args(args)
        .current_dir(root())
        .output()
        .expect("babbage runs");
    let mut s = String::from_utf8(out.stdout).unwrap();
    s.push_str(&String::from_utf8(out.stderr).unwrap());
    s.trim_end().to_string()
}

/// Split a command line on spaces: the tutorial uses no quoting.
fn words(line: &str) -> Vec<String> {
    line.split_whitespace().skip(1).map(String::from).collect()
}

/// The chapter with every output worked out afresh. `name` keeps the
/// chapters' page files apart.
fn worked(name: &str, text: &str) -> String {
    let lines: Vec<&str> = text.lines().collect();
    let mut out: Vec<String> = Vec::new();
    let mut pages = 0;
    let mut i = 0;
    while i < lines.len() {
        let line = lines[i];
        if line == "```bab" || line.starts_with("```bab ") {
            // the page, then its output in the next fence
            let flags: Vec<String> = line["```bab".len()..].split_whitespace().map(String::from).collect();
            let mut page = String::new();
            out.push(line.to_string());
            i += 1;
            while lines[i] != "```" {
                page.push_str(lines[i]);
                page.push('\n');
                out.push(lines[i].to_string());
                i += 1;
            }
            out.push("```".into());
            i += 1;
            while lines[i].trim().is_empty() {
                out.push(lines[i].to_string());
                i += 1;
            }
            assert!(
                lines[i].starts_with("```"),
                "{name}: a page must be followed by its output"
            );
            out.push(lines[i].to_string());
            i += 1;
            while lines[i] != "```" {
                i += 1;
            }
            pages += 1;
            let file = Path::new(env!("CARGO_TARGET_TMPDIR")).join(format!("{name}-{pages}.bab"));
            std::fs::write(&file, &page).unwrap();
            let mut args = vec![file.to_string_lossy().into_owned()];
            args.extend(flags);
            let got = babbage(&args).replace(&file.to_string_lossy().into_owned(), "page.bab");
            out.push(got);
            out.push("```".into());
            i += 1;
            continue;
        }
        if line == "```console" {
            out.push(line.to_string());
            i += 1;
            while lines[i] != "```" {
                if let Some(cmd) = lines[i].strip_prefix("$ ") {
                    assert!(cmd.starts_with("babbage"), "{name}: only babbage is run: {cmd}");
                    out.push(lines[i].to_string());
                    let got = babbage(&words(cmd));
                    if !got.is_empty() {
                        out.push(got);
                    }
                    i += 1;
                    while lines[i] != "```" && !lines[i].starts_with("$ ") {
                        i += 1;
                    }
                } else {
                    out.push(lines[i].to_string());
                    i += 1;
                }
            }
            out.push("```".into());
            i += 1;
            continue;
        }
        out.push(line.to_string());
        i += 1;
    }
    let mut s = out.join("\n");
    s.push('\n');
    s
}

#[test]
fn every_page_and_command_in_the_tutorial() {
    let dir = root().join("tutorial");
    let mut chapters: Vec<_> = std::fs::read_dir(&dir)
        .unwrap()
        .map(|e| e.unwrap().path())
        .filter(|p| p.extension().map(|e| e == "md").unwrap_or(false))
        .collect();
    chapters.sort();
    assert!(chapters.len() >= 7);
    let mut failures = vec![];
    for path in chapters {
        let text = std::fs::read_to_string(&path).unwrap();
        let name = path.file_stem().unwrap().to_string_lossy().into_owned();
        let fresh = worked(&name, &text);
        if std::env::var("BABBAGE_BLESS").is_ok() {
            if fresh != text {
                std::fs::write(&path, &fresh).unwrap();
            }
            continue;
        }
        if fresh != text {
            let at = text.lines().zip(fresh.lines()).position(|(a, b)| a != b).unwrap_or(0);
            failures.push(format!(
                "{} line {}:\n  says: {}\n  gets: {}",
                path.display(),
                at + 1,
                text.lines().nth(at).unwrap_or(""),
                fresh.lines().nth(at).unwrap_or("")
            ));
        }
    }
    assert!(
        failures.is_empty(),
        "the tutorial and babbage disagree (BABBAGE_BLESS=1 to accept):\n{}",
        failures.join("\n")
    );
}
