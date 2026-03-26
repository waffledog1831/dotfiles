#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
COMMON_DIR="$DOTFILES_DIR/common"

link_file() {
  ln -sf "$1" "$2"
  echo "linked: $2"
}

link_dir() {
  local src="$1" dst="$2"
  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -d "$dst" ]; then
    echo "ERROR: $dst is a real directory, not a symlink. Remove it manually." >&2
    exit 1
  fi
  ln -s "$src" "$dst"
  echo "linked: $dst"
}

echo "=== common install ==="

# Git
link_file "$COMMON_DIR/git/.gitconfig" "$HOME/.gitconfig"
link_file "$COMMON_DIR/git/.gitignore_global" "$HOME/.gitignore_global"
link_dir  "$COMMON_DIR/git/hooks" "$HOME/.git-hooks"

# Claude Code
mkdir -p "$HOME/.claude"
link_file "$COMMON_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
link_file "$COMMON_DIR/claude/settings.json" "$HOME/.claude/settings.json"
link_dir  "$COMMON_DIR/claude/skills" "$HOME/.claude/skills"
link_dir  "$COMMON_DIR/claude/agents" "$HOME/.claude/agents"

echo "=== common done ==="
