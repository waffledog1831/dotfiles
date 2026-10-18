# カスタムスキル一覧

変更依頼は、必要なスキルを自動で選び、検証・コミット・push・PR 作成または更新まで進めます。
質問・調査・レビュー・計画のみの依頼や、ローカルのみ・コミットのみ・コミット不要・PR 不要の指定では、その範囲を守ります。

| スキル名 | 用途 |
|----------|------|
| new-branch | 新規作業のブランチを作成。継続作業は現在のブランチを使用 |
| commit | 作業対象だけを日本語メッセージでコミット |
| create-pr | 最終レビュー・シンプル化・検証・コミット・push・PR 作成または更新・CI 確認 |
| review-pr | 根拠付きのレビュー。外部投稿は依頼に含まれる場合のみ |
| simplify | 意味と振る舞いを保つシンプル化。PR の最後の編集工程でも使用 |

Claude Code では `/commit`、`/create-pr`、`/review-pr 123`、Codex では `$commit`、`$create-pr`、`$review-pr` などで明示的にも呼び出せます。
定義は `wsl/claude/skills/<名前>/SKILL.md` と `wsl/codex/skills/<名前>/SKILL.md` にあり、手順の本文をそろえます。
Claude Code は既定の自動選択、Codex は `agents/openai.yaml` の `allow_implicit_invocation: true` を使用します。
自動選択はツールの権限設定を変更しません。認証・承認・ネットワークの制約があれば停止理由を報告します。

## 設計の参考

常時読む指示は個人の好み・完了条件・作業の境界に絞り、具体的な手順は必要時に読むスキルへ置きます。
PR まで進める方針は個人設定で明示した運用方針です。マージ・デプロイ・破壊的操作は別途承認が必要です。

- [OpenAI: AGENTS.md](https://developers.openai.com/codex/guides/agents-md) — グローバル設定とリポジトリ固有の指示を分離。
- [OpenAI: Skills](https://developers.openai.com/codex/skills) — description に基づく自動選択と段階的な読み込み。
- [OpenAI: Rethinking skills and prompts](https://developers.openai.com/blog/rethinking-skills-and-prompts-for-gpt-6-astra) — 常時読む指示とスキルの肥大化を避ける。
- [Anthropic: Best practices](https://code.claude.com/docs/en/best-practices) — 短い CLAUDE.md と、結果を検証できる作業ループ。
- [Anthropic: Skills](https://code.claude.com/docs/en/skills) — 自動選択と明示呼び出しの制御。
- [Agent Skills specification](https://agentskills.io/specification) — 明確な name / description と簡潔な手順。
