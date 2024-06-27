#!/usr/bin/env bash

set -euo pipefail

# Always run from the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Ensure pandoc is available
if ! command -v pandoc >/dev/null 2>&1; then
	echo "Error: pandoc is not installed. Install it first (e.g., brew install pandoc)." >&2
	exit 1
fi

# Create output directory
OUT_DIR="static"
mkdir -p "$OUT_DIR"

# List of markdown files to convert
FILES=(
	"introductions/grammar.md"
	"introductions/hylomorphic-deep-dive.md"
	"introductions/math.md"
	"logic-rethinking/15p-quality.md"
	"misc/misc.md"
	"short-summaries/3p-being.md"
	"short-summaries/3p-concept.md"
	"short-summaries/3p-essence.md"
	"short-summaries/3p-logic.md"
	"short-summaries/9l-system.md"
	"short-summaries/logic-analogies.md"
)

echo "Converting markdown files to HTML in '$OUT_DIR/'..."

for SRC in "${FILES[@]}"; do
	if [[ ! -f "$SRC" ]]; then
		echo "Warning: '$SRC' not found, skipping." >&2
		continue
	fi
	BASE_NAME="$(basename "${SRC%.md}")"
	OUT_FILE="$OUT_DIR/$BASE_NAME.html"
	echo "- $SRC -> $OUT_FILE"
	pandoc "$SRC" -o "$OUT_FILE"
done

echo "Done. HTML files are in '$OUT_DIR/'."

