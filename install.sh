#!/bin/sh
# vibeslop installer v2.0
# Install vibeslop product delivery skills as vendor-neutral Agent Skills
# (https://agentskills.io). Auto-discovered by Gemini CLI; for Claude Code,
# the installer can drop a .claude/skills -> .agents/skills symlink.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/or13/vibeslop/main/install.sh | bash
#   curl -fsSL https://raw.githubusercontent.com/or13/vibeslop/main/install.sh | bash -s -- --force
#
# Environment:
#   TARGET_DIR   Override target directory (default: .agents/skills)

set -e

VERSION="2.0"
BASE_URL="https://raw.githubusercontent.com/or13/vibeslop/main/.agents/skills"
FORCE=0
LINK_CLAUDE=1

SKILLS="vibeslop-plan vibeslop-design vibeslop-build vibeslop-test vibeslop-review vibeslop-launch vibeslop-analyze"

# Parse arguments
for arg in "$@"; do
  case "$arg" in
    --force)
      FORCE=1
      ;;
    --no-claude-symlink)
      LINK_CLAUDE=0
      ;;
    --help)
      echo "vibeslop installer v${VERSION}"
      echo "========================"
      echo ""
      echo "Usage: install.sh [OPTIONS]"
      echo ""
      echo "Options:"
      echo "  --force                Overwrite existing skill files without prompting"
      echo "  --no-claude-symlink    Skip creating .claude/skills -> .agents/skills"
      echo "  --help                 Show this help message"
      echo ""
      echo "Environment:"
      echo "  TARGET_DIR             Override target directory (default: .agents/skills)"
      echo ""
      echo "Skills install in the open agentskills.io layout:"
      echo "  <TARGET_DIR>/<skill-name>/SKILL.md"
      echo ""
      echo "Auto-discovered by Gemini CLI. For Claude Code, the installer creates"
      echo ".claude/skills -> .agents/skills (use --no-claude-symlink to skip)."
      exit 0
      ;;
    *)
      echo "Unknown option: $arg"
      echo "Run with --help for usage information."
      exit 2
      ;;
  esac
done

TARGET="${TARGET_DIR:-.agents/skills}"

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
echo "Installing skills:"

installed=0
skipped=0

for skill in $SKILLS; do
  skill_dir="${TARGET}/${skill}"
  skill_file="${skill_dir}/SKILL.md"

  if [ -f "$skill_file" ] && [ "$FORCE" -eq 0 ]; then
    printf "  %-24s [skipped (exists)]\n" "$skill"
    skipped=$((skipped + 1))
    continue
  fi

  if [ -f "$skill_file" ]; then
    status="overwritten"
  else
    status="installed"
  fi

  mkdir -p "$skill_dir"
  if curl -fsSL "${BASE_URL}/${skill}/SKILL.md" -o "$skill_file" 2>/dev/null; then
    printf "  %-24s [%s]\n" "$skill" "$status"
    installed=$((installed + 1))
  else
    printf "  %-24s [FAILED]\n" "$skill"
    echo "Error: Failed to download ${skill}/SKILL.md. Check your internet connection." >&2
    exit 2
  fi
done

# Optional: Claude Code .claude/skills -> .agents/skills symlink
if [ "$LINK_CLAUDE" -eq 1 ] && [ "$TARGET" = ".agents/skills" ]; then
  echo ""
  if [ -L ".claude/skills" ]; then
    echo "Claude Code symlink... .claude/skills [already a symlink, leaving alone]"
  elif [ -e ".claude/skills" ]; then
    echo "Claude Code symlink... .claude/skills [exists as directory, NOT replacing]"
  else
    mkdir -p ".claude"
    ln -s "../.agents/skills" ".claude/skills"
    echo "Claude Code symlink... .claude/skills -> ../.agents/skills [created]"
  fi
fi

echo ""
echo "Done! ${installed} files installed, ${skipped} skipped."

if [ "$installed" -gt 0 ]; then
  echo "Invoke vibeslop-plan to start your first product cycle."
fi
