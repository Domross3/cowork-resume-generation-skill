#!/usr/bin/env bash
# audit.sh — headless fallback for the resume whitespace audit loop.
# Usage:
#   ./audit.sh /abs/path/resume.html          -> prints the AUDIT-REPORT block
#   ./audit.sh --pdf /abs/path/resume.html    -> writes resume.pdf next to the HTML (no headers/footers)
# Requires any Chrome/Chromium binary. Exits 2 if none found (fall back to manual path).
set -euo pipefail

MODE="audit"
if [ "${1:-}" = "--pdf" ]; then MODE="pdf"; shift; fi
HTML="${1:?usage: audit.sh [--pdf] /abs/path/resume.html}"
HTML="$(cd "$(dirname "$HTML")" && pwd)/$(basename "$HTML")"

BIN=""
for c in chromium chromium-browser google-chrome google-chrome-stable chrome \
         "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
         "/Applications/Chromium.app/Contents/MacOS/Chromium"; do
  if command -v "$c" >/dev/null 2>&1 || [ -x "$c" ]; then BIN="$c"; break; fi
done
if [ -z "$BIN" ]; then
  echo "NO_BROWSER: no Chrome/Chromium binary found — use the manual audit path (open ?audit=1 yourself)." >&2
  exit 2
fi

if [ "$MODE" = "pdf" ]; then
  OUT="${HTML%.html}.pdf"
  "$BIN" --headless=new --disable-gpu --no-sandbox --no-pdf-header-footer \
         --print-to-pdf="$OUT" "file://$HTML" >/dev/null 2>&1
  echo "PDF written: $OUT"
  exit 0
fi

# Fresh process every run, so no cache-buster needed. virtual-time-budget lets the load handler fire.
"$BIN" --headless=new --disable-gpu --no-sandbox --virtual-time-budget=3000 \
       --dump-dom "file://$HTML?audit=1" 2>/dev/null \
  | sed -n '/AUDIT-REPORT/,/END-AUDIT/p' \
  | sed -e 's/<[^>]*>//g' -e 's/&amp;/\&/g' -e "s/&#39;/'/g" -e 's/&quot;/"/g' -e 's/&lt;/</g' -e 's/&gt;/>/g'

# Empty output means the query string was dropped or JS didn't run — retry once with old headless flag.
