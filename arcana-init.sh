#!/bin/bash
set -euo pipefail

# ============================================================
# arcana-init.sh — 冒険者ギルド「Arcana」の設立
#
# 任意のプロジェクトディレクトリで実行すると、
# arcana/（ギルド拠点）を作成します。
#
# Usage:
#   bash /path/to/dotfiles/arcana-init.sh
# ============================================================

ARCANA_DIR="./arcana"

if [ -d "$ARCANA_DIR" ]; then
  echo "arcana/ は既に存在します。スキップします。"
  exit 0
fi

echo "=== 冒険者ギルド「Arcana」を設立します ==="

# ディレクトリ作成
mkdir -p "$ARCANA_DIR/quests"
mkdir -p "$ARCANA_DIR/chronicles"
mkdir -p "$ARCANA_DIR/grimoire"

# ギルドルール
cat > "$ARCANA_DIR/RULES.md" << 'EOF'
# 冒険者ギルド「Arcana」— ギルドルール

このディレクトリは冒険者ギルド「Arcana」の拠点です。
クエストの管理、冒険の記録、得られた知識の保管を行います。

## 拠点の構成

```
arcana/                # ギルド拠点
├── quests/            # クエスト掲示板 — クエストの管理
├── chronicles/        # 年代記 — クエストの詳細記録（ログ）
├── grimoire/          # 魔導書 — ナレッジベース（知識・手順）
└── RULES.md           # ギルドルール（このファイル）
```

## quests（クエスト掲示板）

クエストの進行状況を管理する掲示板。

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

冒険者たちが遂行したクエストの詳細な記録。

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
echo "=== 冒険者ギルド「Arcana」の設立が完了しました ==="
echo ""
echo "ギルド拠点:"
echo "  arcana/quests/      — クエスト掲示板（クエスト管理）"
echo "  arcana/chronicles/  — 年代記（クエストの記録）"
echo "  arcana/grimoire/    — 魔導書（ナレッジベース）"
echo ""
echo "ギルドルール: arcana/RULES.md"
