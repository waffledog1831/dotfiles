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
#   または dotfiles の install.sh で PATH に追加済みなら:
#   arcana-init.sh
# ============================================================

ARCANA_DIR="./arcana"

if [ -d "$ARCANA_DIR" ]; then
  echo "arcana/ は既に存在します。スキップします。"
  exit 0
fi

echo "=== Arcana 書庫を初期化します ==="

# クエスト掲示板（quests）— クエストの管理
mkdir -p "$ARCANA_DIR/quests"

# 年代記（chronicles）— クエストの記録
mkdir -p "$ARCANA_DIR/chronicles"

# 魔導書（grimoire）— ナレッジベース
mkdir -p "$ARCANA_DIR/grimoire"

# README
cat > "$ARCANA_DIR/README.md" << 'EOF'
# Arcana 書庫

冒険者ギルド「Arcana」の書庫です。このプロジェクトで行われたクエスト（作業）の管理・記録と、得られた知識を保管します。

## 構成

```
arcana/
├── quests/        # クエスト掲示板 — 進行中・完了済みクエストの管理
│   └── クエスト名.md
├── chronicles/    # 年代記 — クエストの詳細な記録（ログ）
│   └── YYYY-MM-DD_クエスト名.md
├── grimoire/      # 魔導書 — ナレッジベース（知識・手順）
│   └── テーマ.md
└── README.md
```

### quests（クエスト掲示板）

現在のクエスト状況を管理する掲示板です。

- ファイル名: `クエスト名.md`
- 内容: 依頼内容、ステータス、担当冒険者、進捗

### chronicles（年代記）

冒険者たちが遂行したクエストの詳細な記録です。

- ファイル名: `YYYY-MM-DD_クエスト名.md`
- 内容: クエストの依頼内容、編成、作業経緯、成果

### grimoire（魔導書）

クエストを通じて得られた知識やベストプラクティスです。

- ファイル名: `テーマ.md`（日付なし、継続更新）
- 内容: 技術的な知見、手順書、設定メモなど
EOF

echo ""
echo "=== Arcana 書庫の初期化が完了しました ==="
echo ""
echo "作成されたディレクトリ:"
echo "  arcana/quests/      — クエスト掲示板（クエスト管理）"
echo "  arcana/chronicles/  — 年代記（クエストの記録）"
echo "  arcana/grimoire/    — 魔導書（ナレッジベース）"
echo ""
echo "※ arcana/ はグローバル .gitignore で除外済みです。"
