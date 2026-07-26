# カスタムスキル一覧

> Claude Code で `/スキル名` として呼び出せるショートカットコマンドの一覧です。
> スキルは `claude/skills/` 配下にディレクトリ形式（`スキル名/SKILL.md`）で管理しています。

## スキル一覧

| スキル名 | コマンド | 説明 |
|---------|---------|------|
| new-branch | `/new-branch` | main の最新を取り込み、新しいブランチを作成。`.mainonly` がある場合は main で直接作業 |
| commit | `/commit` | 変更内容を分析し、適切なコミットメッセージで自動コミット |
| create-pr | `/create-pr` | 現在のブランチから GitHub PR を作成。タイトル・説明を自動生成 |
| review-pr | `/review-pr` | GitHub PR をレビュー。差分・コミット履歴を分析し、バグ・設計・セキュリティ・改善点を指摘 |
| summon | `/summon` | 指定した人物（実在・架空）になりきって相談に乗り、実装まで手伝うペルソナ召喚スキル |
| docs | `/docs` | README・API仕様書・ユーザー向けドキュメント・CHANGELOG を作成/更新 |
| devops | `/devops` | CI/CDパイプライン・Docker・デプロイ設定・環境構築・自動化を構築/改善 |

## 使い方

```bash
# 基本形
/スキル名 [引数]

# 例
/new-branch
/new-branch feat/user-auth
/commit
/commit スコープ:認証機能
/create-pr
/create-pr main
/review-pr 123
/summon リーナス・トーバルズ テーマ:Git設計思想
/docs README
/docs CHANGELOG 対象:v1.2.0
/devops GitHub Actions
/devops Dockerfile
```

## スキルの追加方法

手動で `claude/skills/{スキル名}/SKILL.md` を作成してください。
詳細は [Claude Code 運用ガイド](claude.md) を参照。
