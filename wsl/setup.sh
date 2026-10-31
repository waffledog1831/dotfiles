#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
WSL_DIR="$DOTFILES_DIR/wsl"
source "$DOTFILES_DIR/common/lib.sh"

# 設定の配置のみ。ツールの導入は wsl/install.sh を実行する。
bash "$DOTFILES_DIR/common/setup.sh"

echo "=== wsl setup ==="

link_path "$WSL_DIR/bash/.bashrc" "$HOME/.bashrc"
link_path "$WSL_DIR/bash/.bash_aliases" "$HOME/.bash_aliases"

mkdir -p "$HOME/.config/herdr"
link_path "$WSL_DIR/herdr/config.toml" "$HOME/.config/herdr/config.toml"

# Claude Code
mkdir -p "$HOME/.claude"
link_path "$WSL_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
link_path "$WSL_DIR/claude/settings.json" "$HOME/.claude/settings.json"
link_path "$WSL_DIR/claude/skills" "$HOME/.claude/skills"

# Codex（CODEX_HOME 指定時はそのディレクトリを使用）
CODEX_CONFIG_DIR="${CODEX_HOME:-$HOME/.codex}"
mkdir -p "$CODEX_CONFIG_DIR"
link_path "$WSL_DIR/codex/AGENTS.md" "$CODEX_CONFIG_DIR/AGENTS.md"
link_path "$WSL_DIR/codex/config.toml" "$CODEX_CONFIG_DIR/config.toml"

# Codex ユーザースキル（他のスキルは保持する）
mkdir -p "$HOME/.agents/skills"
for retired_skill in commit new-branch review-pr; do
  skill_link="$HOME/.agents/skills/$retired_skill"
  if [ -L "$skill_link" ] && [ "$(readlink "$skill_link")" = "$WSL_DIR/codex/skills/$retired_skill" ]; then
    rm "$skill_link"
  fi
done
for skill_dir in "$WSL_DIR/codex/skills/"*/; do
  skill_name="$(basename "$skill_dir")"
  link_path "${skill_dir%/}" "$HOME/.agents/skills/$skill_name"
done

echo "=== wsl setup done ==="
