# カスタムスキル一覧

固有の運用手順を必要なときだけ読み込む構成です。両ツールで明示呼び出し専用にしています。
一般的な相談・実装・調査のたびにスキルを呼ぶ必要はありません。

| スキル名 | 用途 |
|----------|------|
| new-branch | 新規作業のブランチを作成。継続作業は現在のブランチを使用 |
| commit | 作業対象だけを日本語メッセージでコミット |
| create-pr | 作業対象をコミット・push し、PR を作成または更新 |
| review-pr | 根拠付きのレビュー。外部投稿は依頼に含まれる場合のみ |
| docs | 実装に基づくドキュメント整備 |
| devops | CI/CD・コンテナ・環境構築の改善 |

Claude Code では `/commit`、`/create-pr`、`/review-pr 123` などで呼び出します。
Codex では `$commit`、`$create-pr`、`$review-pr` などを指定し、対象を併記します。

定義はそれぞれ `common/claude/skills/<名前>/SKILL.md` と `common/codex/skills/<名前>/SKILL.md` にあります。
手順の本文はそろえ、Claude Code は `disable-model-invocation`、Codex は `agents/openai.yaml` の `allow_implicit_invocation` で自動呼び出しを無効にしています。
変更時は両方を確認し、帰属表記や専用ツールの記法を別ツールへ持ち込まないでください。
