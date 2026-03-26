#!/bin/bash
set -euo pipefail

# Git Bash on Windows: シンボリックリンクを有効にする（要: 開発者モード）
export MSYS=winsymlinks:nativestrict

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
WINDOWS_DIR="$DOTFILES_DIR/windows"

link_file() {
  ln -sf "$1" "$2"
  echo "linked: $2"
}

# 共通設定を適用
bash "$DOTFILES_DIR/common/install.sh"

echo "=== windows install ==="

# Sakura Editor
SAKURA_DIR="$HOME/AppData/Roaming/sakura"
mkdir -p "$SAKURA_DIR"
link_file "$WINDOWS_DIR/sakura/sakura.ini" "$SAKURA_DIR/sakura.ini"

# WezTerm
link_file "$WINDOWS_DIR/wezterm/.wezterm.lua" "$HOME/.wezterm.lua"

echo "=== windows done ==="
