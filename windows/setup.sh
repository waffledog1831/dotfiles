#!/bin/bash
set -euo pipefail

# Git Bash on Windows: シンボリックリンクを有効にする（要: 開発者モード）
export MSYS=winsymlinks:nativestrict

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
WINDOWS_DIR="$DOTFILES_DIR/windows"

source "$DOTFILES_DIR/common/lib.sh"

# 共通設定を適用
bash "$DOTFILES_DIR/common/setup.sh"

echo "=== windows install ==="

# PowerShell 7 プロファイル（WezTerm OSC 7 CWD通知など）
PS_PROFILE_DIR="$HOME/Documents/PowerShell"
mkdir -p "$PS_PROFILE_DIR"
link_path "$WINDOWS_DIR/powershell/Microsoft.PowerShell_profile.ps1" "$PS_PROFILE_DIR/Microsoft.PowerShell_profile.ps1"

# WezTerm
link_path "$WINDOWS_DIR/wezterm/.wezterm.lua" "$HOME/.wezterm.lua"

TERMINAL_DIRS=(
  "$HOME/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"
  "$HOME/AppData/Local/Microsoft/Windows Terminal"
)
for terminal_dir in "${TERMINAL_DIRS[@]}"; do
  [ -d "$terminal_dir" ] || continue
  link_path "$WINDOWS_DIR/terminal/settings.json" "$terminal_dir/settings.json"
done

# Sakura Editor
SAKURA_DIR="$HOME/AppData/Roaming/sakura"
mkdir -p "$SAKURA_DIR"
link_path "$WINDOWS_DIR/sakura/sakura.ini" "$SAKURA_DIR/sakura.ini"

echo "=== windows done ==="
