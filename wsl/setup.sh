#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
WSL_DIR="$DOTFILES_DIR/wsl"
source "$DOTFILES_DIR/common/lib.sh"

# 設定の配置のみ。ツールの導入は wsl/install.sh を実行する。
bash "$DOTFILES_DIR/common/setup.sh"

echo "=== wsl config install ==="
link_path "$WSL_DIR/bash/.bashrc" "$HOME/.bashrc"
link_path "$WSL_DIR/bash/.bash_aliases" "$HOME/.bash_aliases"
echo "=== wsl config done ==="
