#!/bin/bash
set -euo pipefail

# Git Bash on Windows: シンボリックリンクを有効にする（要: 開発者モード）
export MSYS=winsymlinks:nativestrict

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== dotfiles install ==="

# Git
ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/git/.gitignore_global" "$HOME/.gitignore_global"
echo "linked: ~/.gitconfig"
echo "linked: ~/.gitignore_global"

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

# Sakura Editor
SAKURA_DIR="$HOME/AppData/Roaming/sakura"
mkdir -p "$SAKURA_DIR"
ln -sf "$DOTFILES_DIR/sakura/sakura.ini" "$SAKURA_DIR/sakura.ini"
echo "linked: $SAKURA_DIR/sakura.ini"

# WezTerm
ln -sf "$DOTFILES_DIR/wezterm/.wezterm.lua" "$HOME/.wezterm.lua"
echo "linked: ~/.wezterm.lua"

# Neovim (LazyVim)
NVIM_CONFIG_DIR="$HOME/AppData/Local/nvim"
mkdir -p "$NVIM_CONFIG_DIR"
ln -sf "$DOTFILES_DIR/nvim/init.lua" "$NVIM_CONFIG_DIR/init.lua"
ln -sf "$DOTFILES_DIR/nvim/lua" "$NVIM_CONFIG_DIR/lua"
echo "linked: $NVIM_CONFIG_DIR"

echo "=== done ==="
