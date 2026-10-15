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

# 移動前の管理対象リンクだけを解除し、個人設定や認証情報は保持する。
for name in CLAUDE.md settings.json skills agents; do
  unlink_path_if_target "$DOTFILES_DIR/common/claude/$name" "$HOME/.claude/$name"
done
CODEX_CONFIG_DIR="${CODEX_HOME:-$HOME/.codex}"
for name in AGENTS.md config.toml agents; do
  unlink_path_if_target "$DOTFILES_DIR/common/codex/$name" "$CODEX_CONFIG_DIR/$name"
done
for skill_link in "$HOME/.agents/skills/"*; do
  skill_name="$(basename "$skill_link")"
  unlink_path_if_target "$DOTFILES_DIR/common/codex/skills/$skill_name" "$skill_link"
done

# PowerShell 7 プロファイル（WezTerm OSC 7 CWD通知など）
PS_PROFILE_DIR="$HOME/Documents/PowerShell"
mkdir -p "$PS_PROFILE_DIR"
link_path "$WINDOWS_DIR/powershell/Microsoft.PowerShell_profile.ps1" "$PS_PROFILE_DIR/Microsoft.PowerShell_profile.ps1"

# WezTerm
link_path "$WINDOWS_DIR/wezterm/.wezterm.lua" "$HOME/.wezterm.lua"

# Sakura Editor
SAKURA_DIR="$HOME/AppData/Roaming/sakura"
mkdir -p "$SAKURA_DIR"
link_path "$WINDOWS_DIR/sakura/sakura.ini" "$SAKURA_DIR/sakura.ini"

echo "=== windows done ==="
