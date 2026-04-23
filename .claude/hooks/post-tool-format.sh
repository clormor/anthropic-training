#!/usr/bin/env bash
# PostToolUse hook: auto-format files after Claude edits them.
# Reads JSON from stdin to extract the file path, then runs the
# project's configured formatter.
#
# Non-blocking: if formatting fails or no formatter is found, exits 0.
#
# Input (stdin JSON): { "tool_name": "Edit", "tool_input": { "file_path": "/path/to/file" }, ... }

INPUT=$(cat)

FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [[ -z "$FILE_PATH" ]] || [[ ! -f "$FILE_PATH" ]]; then
  exit 0
fi

EXTENSION="${FILE_PATH##*.}"
PROJECT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || echo ".")

format_js_ts() {
  if [[ -f "$PROJECT_ROOT/node_modules/.bin/prettier" ]]; then
    "$PROJECT_ROOT/node_modules/.bin/prettier" --write "$FILE_PATH" 2>/dev/null || true
  elif command -v prettier &>/dev/null; then
    prettier --write "$FILE_PATH" 2>/dev/null || true
  fi
}

format_python() {
  if command -v ruff &>/dev/null; then
    ruff format "$FILE_PATH" 2>/dev/null || true
    ruff check --fix "$FILE_PATH" 2>/dev/null || true
  elif command -v black &>/dev/null; then
    black "$FILE_PATH" 2>/dev/null || true
  fi
}

format_go() {
  if command -v gofmt &>/dev/null; then
    gofmt -w "$FILE_PATH" 2>/dev/null || true
  fi
}

format_rust() {
  if command -v rustfmt &>/dev/null; then
    rustfmt "$FILE_PATH" 2>/dev/null || true
  fi
}

case "$EXTENSION" in
  ts|tsx|js|jsx|json|css|scss|md|yaml|yml)
    format_js_ts
    ;;
  py)
    format_python
    ;;
  go)
    format_go
    ;;
  rs)
    format_rust
    ;;
esac

# Always exit 0. Formatting failure should never block Claude.
exit 0
