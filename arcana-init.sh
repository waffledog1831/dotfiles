#!/bin/bash
set -euo pipefail

# ============================================================
# arcana-init.sh — 冒険者ギルド「Arcana」書庫の初期化
#
# 任意のプロジェクトディレクトリで実行すると、
# arcana/ ディレクトリ（書庫）を作成します。
#
# Usage:
#   bash /path/to/dotfiles/arcana-init.sh
# ============================================================

ARCANA_DIR="./arcana"

if [ -d "$ARCANA_DIR" ]; then
  echo "arcana/ は既に存在します。スキップします。"
  exit 0
fi

echo "=== Arcana 書庫を初期化します ==="

# ディレクトリ作成
mkdir -p "$ARCANA_DIR/quests"
mkdir -p "$ARCANA_DIR/chronicles"
mkdir -p "$ARCANA_DIR/grimoire"

# ギルドルール
cat > "$ARCANA_DIR/RULES.md" << 'EOF'
# Arcana 書庫 — ギルドルール

冒険者ギルド「Arcana」の書庫運用ルールです。

## 構成

```
arcana/
├── quests/        # クエスト掲示板 — クエストの管理
├── chronicles/    # 年代記 — クエストの詳細記録（ログ）
├── grimoire/      # 魔導書 — ナレッジベース（知識・手順）
└── RULES.md       # このファイル
```

## quests（クエスト掲示板）

クエストの進行状況を管理する。

- ファイル名: `クエスト名.md`
- ステータス: `受付済み` → `進行中` → `完了` / `保留`

### テンプレート

```markdown
# クエスト名

- **ステータス**: 受付済み / 進行中 / 完了 / 保留
- **難易度**: S / A / B / C / D
- **受付日**: YYYY-MM-DD
- **編成**: （担当冒険者）

## 依頼内容

（何をするか）

## 進捗

- [ ] タスク1
- [ ] タスク2

## 成果

（完了時に記入）
```

## chronicles（年代記）

クエストの詳細な作業記録。

- ファイル名: `YYYY-MM-DD_クエスト名.md`
- 内容: 依頼内容、編成、作業経緯、成果

## grimoire（魔導書）

クエストを通じて得た知識やベストプラクティス。

- ファイル名: `テーマ.md`（日付なし、継続更新）
- 内容: 技術的な知見、手順書、設定メモなど

## 記録のタイミング

- 作業がひと段落ついたタイミングで、記録を提案する
  - 提案例: 「今回の記録、年代記（chronicles）か魔導書（grimoire）にまとめておく？」
  - ユーザーが承認したら、内容を整理して該当フォルダに作成する
EOF

echo ""
echo "=== Arcana 書庫の初期化が完了しました ==="
echo ""
echo "作成されたディレクトリ:"
echo "  arcana/quests/      — クエスト掲示板（クエスト管理）"
echo "  arcana/chronicles/  — 年代記（クエストの記録）"
echo "  arcana/grimoire/    — 魔導書（ナレッジベース）"
echo ""
echo "ギルドルール: arcana/RULES.md"
