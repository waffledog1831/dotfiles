#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
COMMON_DIR="$DOTFILES_DIR/common"

source "$COMMON_DIR/lib.sh"

echo "=== common setup ==="

# 作業用ディレクトリ
mkdir -p "$HOME/repos"

# Git
link_path "$COMMON_DIR/git/.gitconfig" "$HOME/.gitconfig"
link_path "$COMMON_DIR/git/.gitignore_global" "$HOME/.gitignore_global"
link_path "$COMMON_DIR/git/hooks" "$HOME/.git-hooks"

echo "=== common setup done ==="
