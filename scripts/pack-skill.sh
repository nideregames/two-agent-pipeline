#!/bin/bash
# Pack dev-pipeline-init skill into ZIP for uploading to Claude.ai
# Usage: ./scripts/pack-skill.sh

set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_DIR="$REPO_ROOT/examples/dev-pipeline"
OUTPUT="$REPO_ROOT/dist/dev-pipeline-init.zip"

mkdir -p "$REPO_ROOT/dist"
rm -f "$OUTPUT"

cd "$SKILL_DIR"
zip -r "$OUTPUT" dev-pipeline-init/ -x "*.DS_Store"

echo "✅ Packed: $OUTPUT"
echo "Upload to Claude.ai → Customize → Skills"
