#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
COMMON_DIR="$DOTFILES_DIR/common"

source "$COMMON_DIR/lib.sh"

echo "=== common install ==="

# Git
link_path "$COMMON_DIR/git/.gitconfig" "$HOME/.gitconfig"
link_path "$COMMON_DIR/git/.gitignore_global" "$HOME/.gitignore_global"
link_path "$COMMON_DIR/git/hooks" "$HOME/.git-hooks"

# Claude Code
mkdir -p "$HOME/.claude"
link_path "$COMMON_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
link_path "$COMMON_DIR/claude/settings.json" "$HOME/.claude/settings.json"
link_path "$COMMON_DIR/claude/skills" "$HOME/.claude/skills"
link_path "$COMMON_DIR/claude/agents" "$HOME/.claude/agents"

# Codex（CODEX_HOME 指定時はそのディレクトリを使用）
CODEX_CONFIG_DIR="${CODEX_HOME:-$HOME/.codex}"
mkdir -p "$CODEX_CONFIG_DIR"
link_path "$COMMON_DIR/codex/AGENTS.md" "$CODEX_CONFIG_DIR/AGENTS.md"
link_path "$COMMON_DIR/codex/config.toml" "$CODEX_CONFIG_DIR/config.toml"

link_path "$COMMON_DIR/codex/agents" "$CODEX_CONFIG_DIR/agents"

# Codex ユーザースキル（他のスキルは保持する）
mkdir -p "$HOME/.agents/skills"
# 旧 summon リンクは、このリポジトリが配置したものだけを削除する。
OBSOLETE_SUMMON_LINK="$HOME/.agents/skills/summon"
if [ -L "$OBSOLETE_SUMMON_LINK" ] && [ "$(readlink "$OBSOLETE_SUMMON_LINK")" = "$COMMON_DIR/codex/skills/summon" ]; then
  rm "$OBSOLETE_SUMMON_LINK"
fi
for skill_dir in "$COMMON_DIR/codex/skills/"*/; do
  skill_name="$(basename "$skill_dir")"
  link_path "${skill_dir%/}" "$HOME/.agents/skills/$skill_name"
done

echo "=== common done ==="
