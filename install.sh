#!/bin/sh
# vibeslop installer v1.0
# Install vibeslop product delivery skills for Claude Code
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/or13/vibeslop/main/install.sh | bash
#   curl -fsSL https://raw.githubusercontent.com/or13/vibeslop/main/install.sh | bash -s -- --force
#
# Environment:
#   TARGET_DIR   Override target directory (default: .claude/commands/)

set -e

VERSION="1.0"
BASE_URL="https://raw.githubusercontent.com/or13/vibeslop/main/commands"
FORCE=0

SKILLS="vibeslop.plan.md vibeslop.design.md vibeslop.build.md vibeslop.test.md vibeslop.review.md vibeslop.launch.md vibeslop.analyze.md"

# Parse arguments
for arg in "$@"; do
  case "$arg" in
    --force)
      FORCE=1
      ;;
    --help)
      echo "vibeslop installer v${VERSION}"
      echo "========================"
      echo ""
      echo "Usage: install.sh [OPTIONS]"
      echo ""
      echo "Options:"
      echo "  --force    Overwrite existing skill files without prompting"
      echo "  --help     Show this help message"
      echo ""
      echo "Environment:"
      echo "  TARGET_DIR   Override target directory (default: .claude/commands/)"
      exit 0
      ;;
    *)
      echo "Unknown option: $arg"
      echo "Run with --help for usage information."
      exit 2
      ;;
  esac
done

TARGET="${TARGET_DIR:-.claude/commands}"

echo "vibeslop installer v${VERSION}"
echo "========================"

# Check target directory
if [ -d "$TARGET" ]; then
  echo "Checking target directory... ${TARGET} [exists]"
else
  mkdir -p "$TARGET"
  echo "Checking target directory... ${TARGET} [created]"
fi

# Check speckit
if [ -d ".specify" ]; then
  echo "Checking speckit... [found]"
else
  echo "Checking speckit... [WARNING: not found — install speckit for full functionality]"
fi

echo ""
echo "Installing skill files:"

installed=0
skipped=0

for file in $SKILLS; do
  if [ -f "${TARGET}/${file}" ] && [ "$FORCE" -eq 0 ]; then
    printf "  %-24s [skipped (exists)]\n" "$file"
    skipped=$((skipped + 1))
  else
    if [ -f "${TARGET}/${file}" ]; then
      status="overwritten"
    else
      status="installed"
    fi
    if curl -fsSL "${BASE_URL}/${file}" -o "${TARGET}/${file}" 2>/dev/null; then
      printf "  %-24s [%s]\n" "$file" "$status"
      installed=$((installed + 1))
    else
      printf "  %-24s [FAILED]\n" "$file"
      echo "Error: Failed to download ${file}. Check your internet connection." >&2
      exit 2
    fi
  fi
done

echo ""
echo "Done! ${installed} files installed, ${skipped} skipped."

if [ "$installed" -gt 0 ]; then
  echo "Run /vibeslop.plan to start your first product cycle."
fi
