//! The transcribed pages, compiled in by `build.rs` from `corpus/*.bab`, in
//! the order of their names (the order of the archive).

include!(concat!(env!("OUT_DIR"), "/corpus.rs"));

pub const PAGES: &[(&str, &str)] = CORPUS;

pub fn find(name: &str) -> Option<(&'static str, &'static str)> {
    let key = name.trim_start_matches("BAB/").replace('/', "").to_uppercase();
    PAGES
        .iter()
        .find(|(n, _)| n.to_uppercase() == key || n.to_uppercase().replace('-', "") == key)
        .copied()
}
