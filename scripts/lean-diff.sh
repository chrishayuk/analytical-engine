#!/bin/sh
# Differential test of src/sketch.rs against the Lean model (formal/Diff.lean):
# the same decks, run by the Rust machine and by Babbage.step, compared.
#   scripts/lean-diff.sh [N]    N random decks (default 2000), with and without the trap
set -e
root=$(cd "$(dirname "$0")/.." && pwd)
dir=$(mktemp -d)
n=${1:-2000}
cargo run --quiet --manifest-path "$root/Cargo.toml" -- control lean-cases "$dir" "$n"
(cd "$root/formal" && lake build diff >/dev/null && find "$dir" -name '*.deck' -print0 | xargs -0 lake exe diff)
fail=0
total=0
for f in "$dir"/*.deck; do
  total=$((total + 1))
  if ! cmp -s "${f%.deck}.rust" "$f.lean"; then
    fail=$((fail + 1))
    if [ "$fail" -le 5 ]; then
      echo "differs: $(basename "$f" .deck)"
      diff "${f%.deck}.rust" "$f.lean" || true
    fi
  fi
done
echo "$total cases, $fail differ"
rm -rf "$dir"
[ "$fail" -eq 0 ]
