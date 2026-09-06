#!/usr/bin/env bash
# Wraps the map (authored as a fragment for the Claude artifact host) into a
# standalone document and stages it for GitHub Pages.
set -euo pipefail

SRC="five-exits-one-road.html"
OUT="_site"

[ -f "$SRC" ] || { echo "missing $SRC" >&2; exit 1; }

rm -rf "$OUT"
mkdir -p "$OUT"

{
  cat <<'HEAD'
<!doctype html>
<html lang="en">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="color-scheme" content="light dark">
<meta name="robots" content="noindex, nofollow">
<style>html{color-scheme:light dark}body{margin:0}img{max-width:100%}[hidden]{display:none!important}</style>
HEAD
  cat "$SRC"
  printf '\n</html>\n'
} > "$OUT/index.html"

cp "$SRC" "$OUT/$SRC"
echo "built $OUT/index.html ($(wc -c < "$OUT/index.html") bytes)"
