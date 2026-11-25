//! A run as JSON (`babbage json FILE`), for the playground: the page, every
//! operation with the cards it needs and the store after it, and every
//! statement checked, so the store and the mill can be drawn and stepped.

use crate::expr::Held;
use crate::json::{obj, Json};
use crate::lsp::{analyse, problems};
use crate::machine::Source;
use crate::page::Cell;
use crate::rat::Rat;
use std::collections::BTreeMap;

fn held(h: &Held, at: &Option<BTreeMap<String, Rat>>) -> Json {
    let (complement, v) = match h {
        Held::Plain(v) => (false, v),
        Held::Complement(v) => (true, v),
    };
    let num = at
        .as_ref()
        .and_then(|at| v.eval(at))
        .map(|r| Json::from(r.to_string()))
        .unwrap_or(Json::Null);
    obj([
        ("text", h.to_string().into()),
        ("complement", complement.into()),
        ("number", num),
        ("zero", h.is_zero().into()),
    ])
}

fn checks_json<'a>(cs: impl Iterator<Item = &'a crate::machine::Check>) -> Json {
    cs.map(|c| {
        obj([
            ("line", c.line.into()),
            ("what", c.what.clone().into()),
            ("ok", c.ok.into()),
            ("detail", c.detail.clone().into()),
        ])
    })
    .collect::<Vec<_>>()
    .into()
}

pub fn run_json(text: &str, at: Option<BTreeMap<String, Rat>>) -> String {
    let a = analyse(text);
    let p = &a.page;
    let r = &a.run;
    let columns: Vec<usize> = {
        let mut c: Vec<usize> = p.store.iter().map(|s| s.0).chain(p.working.iter().copied()).collect();
        c.extend(r.history.keys());
        c.sort();
        c.dedup();
        c
    };
    let start: Vec<Json> = p
        .store
        .iter()
        .map(|(v, _, t)| {
            let h = r.history.get(v).and_then(|h| h.first());
            obj([
                ("v", (*v).into()),
                ("text", t.clone().into()),
                ("held", h.map(|h| held(h, &at)).unwrap_or(Json::Null)),
            ])
        })
        .collect();
    let steps: Vec<Json> = r
        .steps
        .iter()
        .map(|s| {
            let row = &s.row;
            let operands: Vec<Json> = s
                .cards
                .operands
                .iter()
                .map(|(src, v)| {
                    let from = match src {
                        Source::Read(n) => Json::from(*n),
                        Source::Table => Json::Null,
                    };
                    obj([
                        ("from", from),
                        ("table", matches!(src, Source::Table).into()),
                        ("held", held(v, &at)),
                    ])
                })
                .collect();
            obj([
                ("line", row.line.into()),
                ("number", row.number.into()),
                ("star", row.star.into()),
                (
                    "op",
                    row.op.map(|o| Json::from(o.sign().to_string())).unwrap_or(Json::Null),
                ),
                ("card", row.card_text.clone().into()),
                (
                    "cells",
                    row.cells
                        .iter()
                        .map(|(c, cell)| {
                            let t = match cell {
                                Cell::Zero => "0".to_string(),
                                Cell::Named(n) => format!("={n}"),
                                Cell::Value(_, t) => t.clone(),
                            };
                            obj([("v", (*c).into()), ("text", t.into())])
                        })
                        .collect::<Vec<_>>()
                        .into(),
                ),
                (
                    "mill",
                    row.mill.as_ref().map(|m| Json::from(m.1.clone())).unwrap_or(Json::Null),
                ),
                ("operands", operands.into()),
                ("tableMade", s.cards.table_formed.into()),
                ("result", s.result.as_ref().map(|h| held(h, &at)).unwrap_or(Json::Null)),
                (
                    "reads",
                    s.cards.reads.iter().map(|r| Json::from(*r)).collect::<Vec<_>>().into(),
                ),
                (
                    "writes",
                    s.cards
                        .writes
                        .iter()
                        .map(|(c, h)| obj([("v", (*c).into()), ("held", held(h, &at))]))
                        .collect::<Vec<_>>()
                        .into(),
                ),
                (
                    "store",
                    s.store_after
                        .iter()
                        .map(|(c, h)| obj([("v", (*c).into()), ("held", held(h, &at))]))
                        .collect::<Vec<_>>()
                        .into(),
                ),
                ("checks", checks_json(s.checks.iter())),
            ])
        })
        .collect();
    let all: Vec<_> = r.all_checks().collect();
    let ok = all.iter().filter(|c| c.ok).count();
    let out = obj([
        ("sheet", p.sheet.clone().into()),
        ("number", p.number.clone().into()),
        ("date", p.date.clone().into()),
        ("title", p.title.clone().into()),
        (
            "images",
            p.image.iter().map(|s| Json::from(s.clone())).collect::<Vec<_>>().into(),
        ),
        (
            "columns",
            columns.iter().map(|c| Json::from(*c)).collect::<Vec<_>>().into(),
        ),
        (
            "working",
            p.working.iter().map(|c| Json::from(*c)).collect::<Vec<_>>().into(),
        ),
        ("start", start.into()),
        ("steps", steps.into()),
        ("checks", checks_json(r.checks.iter())),
        (
            "tally",
            obj([
                ("great", (r.tally.great as usize).into()),
                ("small", (r.tally.small as usize).into()),
                ("tables", (r.tally.tables as usize).into()),
            ]),
        ),
        (
            "results",
            r.results
                .iter()
                .map(|(k, v)| obj([("name", k.clone().into()), ("held", held(&Held::Plain(v.clone()), &at))]))
                .collect::<Vec<_>>()
                .into(),
        ),
        ("statements", all.len().into()),
        ("agree", ok.into()),
        ("stopped", r.stopped.clone().map(Json::from).unwrap_or(Json::Null)),
        (
            "problems",
            problems(&a)
                .into_iter()
                .map(|(n, s, m)| {
                    obj([
                        ("line", (n + 1).into()),
                        ("severity", (s as usize).into()),
                        ("message", m.into()),
                    ])
                })
                .collect::<Vec<_>>()
                .into(),
        ),
        (
            "remarks",
            p.remarks
                .iter()
                .map(|s| Json::from(s.clone()))
                .collect::<Vec<_>>()
                .into(),
        ),
        (
            "unrun",
            p.unrun.iter().map(|s| Json::from(s.clone())).collect::<Vec<_>>().into(),
        ),
    ]);
    let mut s = String::new();
    out.write(&mut s);
    s
}
