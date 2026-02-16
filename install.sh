#!/bin/bash
set -euo pipefail

# Git Bash on Windows: シンボリックリンクを有効にする（要: 開発者モード）
export MSYS=winsymlinks:nativestrict

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== dotfiles install ==="

# Git
ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
echo "linked: ~/.gitconfig"

# Claude Code
mkdir -p "$HOME/.claude"
ln -sf "$DOTFILES_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
ln -sf "$DOTFILES_DIR/claude/settings.json" "$HOME/.claude/settings.json"
ln -sf "$DOTFILES_DIR/claude/skills" "$HOME/.claude/skills"
ln -sf "$DOTFILES_DIR/claude/agents" "$HOME/.claude/agents"
echo "linked: ~/.claude/CLAUDE.md"
echo "linked: ~/.claude/settings.json"
echo "linked: ~/.claude/skills"
echo "linked: ~/.claude/agents"

# WezTerm
ln -sf "$DOTFILES_DIR/wezterm/.wezterm.lua" "$HOME/.wezterm.lua"
echo "linked: ~/.wezterm.lua"

echo "=== done ==="
