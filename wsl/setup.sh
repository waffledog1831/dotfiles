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

mkdir -p "$HOME/.config/herdr"
link_path "$WSL_DIR/herdr/config.toml" "$HOME/.config/herdr/config.toml"

# Claude Code
mkdir -p "$HOME/.claude"
link_path "$WSL_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
link_path "$WSL_DIR/claude/settings.json" "$HOME/.claude/settings.json"
link_path "$WSL_DIR/claude/skills" "$HOME/.claude/skills"
link_path "$WSL_DIR/claude/agents" "$HOME/.claude/agents"

# Codex（CODEX_HOME 指定時はそのディレクトリを使用）
CODEX_CONFIG_DIR="${CODEX_HOME:-$HOME/.codex}"
mkdir -p "$CODEX_CONFIG_DIR"
link_path "$WSL_DIR/codex/AGENTS.md" "$CODEX_CONFIG_DIR/AGENTS.md"
link_path "$WSL_DIR/codex/config.toml" "$CODEX_CONFIG_DIR/config.toml"

link_path "$WSL_DIR/codex/agents" "$CODEX_CONFIG_DIR/agents"

# Codex ユーザースキル（他のスキルは保持する）
mkdir -p "$HOME/.agents/skills"
for skill_dir in "$WSL_DIR/codex/skills/"*/; do
  skill_name="$(basename "$skill_dir")"
  link_path "${skill_dir%/}" "$HOME/.agents/skills/$skill_name"
done

echo "=== wsl config done ==="
