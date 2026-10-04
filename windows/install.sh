#!/bin/bash
set -euo pipefail

# Git Bash on Windows: シンボリックリンクを有効にする（要: 開発者モード）
export MSYS=winsymlinks:nativestrict

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
WINDOWS_DIR="$DOTFILES_DIR/windows"

source "$DOTFILES_DIR/common/lib.sh"

# 共通設定を適用
bash "$DOTFILES_DIR/common/install.sh"

echo "=== windows install ==="

# Sakura Editor
SAKURA_DIR="$HOME/AppData/Roaming/sakura"
mkdir -p "$SAKURA_DIR"
link_path "$WINDOWS_DIR/sakura/sakura.ini" "$SAKURA_DIR/sakura.ini"

# WezTerm
link_path "$WINDOWS_DIR/wezterm/.wezterm.lua" "$HOME/.wezterm.lua"

# PowerShell 7 プロファイル（WezTerm OSC 7 CWD通知など）
PS_PROFILE_DIR="$HOME/Documents/PowerShell"
mkdir -p "$PS_PROFILE_DIR"
link_path "$WINDOWS_DIR/powershell/Microsoft.PowerShell_profile.ps1" "$PS_PROFILE_DIR/Microsoft.PowerShell_profile.ps1"

echo "=== windows done ==="
