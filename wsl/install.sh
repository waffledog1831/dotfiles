#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
WSL_DIR="$DOTFILES_DIR/wsl"

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

# 共通設定を適用
bash "$DOTFILES_DIR/common/install.sh"

echo "=== wsl install ==="

# Neovim (LazyVim)
NVIM_CONFIG_DIR="$HOME/.config/nvim"
mkdir -p "$NVIM_CONFIG_DIR"
link_file "$WSL_DIR/nvim/init.lua" "$NVIM_CONFIG_DIR/init.lua"
link_dir  "$WSL_DIR/nvim/lua" "$NVIM_CONFIG_DIR/lua"

echo "=== wsl done ==="
