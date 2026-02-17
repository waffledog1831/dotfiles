# カスタムスキル一覧

> Claude Code で `/スキル名` として呼び出せるショートカットコマンドの一覧です。
> スキルは `claude/skills/` 配下にディレクトリ形式（`スキル名/SKILL.md`）で管理しています。

## スキル一覧

| スキル名 | コマンド | 説明 |
|---------|---------|------|
| summon | `/summon` | 指定した人物（実在・架空）になりきって相談に乗り、実装まで手伝うペルソナ召喚スキル |
| create-skill | `/create-skill` | ユーザーの要望に基づいて新しいカスタムスキル（SKILL.md）を作成する |
| tdd | `/tdd` | TDD（テスト駆動開発）で機能を実装する。Red → Green → Refactor のサイクルを厳守 |
| review-pr | `/review-pr` | GitHub PR をレビューする。差分・コミット履歴を分析し、バグ・設計・セキュリティ・改善点を指摘 |

## 使い方

```bash
# 基本形
/スキル名 [引数]

# 例
/summon リーナス・トーバルズ テーマ:Git設計思想
/create-skill PRマージ前のチェックリストを出すスキル
/tdd ユーザー登録のバリデーション
/review-pr 123
```

## スキルの追加方法

`/create-skill` を使うか、手動で `claude/skills/{スキル名}/SKILL.md` を作成してください。
詳細は [Claude Code 運用ガイド](claude.md) を参照。
