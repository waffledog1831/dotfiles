#!/bin/bash
set -euo pipefail

# Git Bash on Windows: シンボリックリンクを有効にする（要: 開発者モード）
export MSYS=winsymlinks:nativestrict

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# ファイルのシンボリックリンクを作成（既存は上書き）
link_file() {
  ln -sf "$1" "$2"
  echo "linked: $2"
}

# ディレクトリのシンボリックリンクを作成
# 既存リンクは差し替え、実ディレクトリは誤操作防止のためエラー終了
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

echo "=== dotfiles install ==="

# Git
link_file "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/git/.gitignore_global" "$HOME/.gitignore_global"

# Claude Code
mkdir -p "$HOME/.claude"
link_file "$DOTFILES_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
link_file "$DOTFILES_DIR/claude/settings.json" "$HOME/.claude/settings.json"
link_dir  "$DOTFILES_DIR/claude/skills" "$HOME/.claude/skills"
link_dir  "$DOTFILES_DIR/claude/agents" "$HOME/.claude/agents"

# Sakura Editor
SAKURA_DIR="$HOME/AppData/Roaming/sakura"
mkdir -p "$SAKURA_DIR"
link_file "$DOTFILES_DIR/sakura/sakura.ini" "$SAKURA_DIR/sakura.ini"

# WezTerm
link_file "$DOTFILES_DIR/wezterm/.wezterm.lua" "$HOME/.wezterm.lua"

# Neovim (LazyVim)
NVIM_CONFIG_DIR="$HOME/AppData/Local/nvim"
mkdir -p "$NVIM_CONFIG_DIR"
link_file "$DOTFILES_DIR/nvim/init.lua" "$NVIM_CONFIG_DIR/init.lua"
link_dir  "$DOTFILES_DIR/nvim/lua" "$NVIM_CONFIG_DIR/lua"

echo "=== done ==="
