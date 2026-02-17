# プロジェクトダッシュボード

> このファイルはプロジェクトの現在の状態を記録し、AI アシスタントが文脈を把握して次のタスクを判断するためのものです。
> プロジェクトの進行に合わせて定期的に更新してください。

## プロジェクト概要

- **プロジェクト名**: dotfiles
- **目的**: Windows 開発環境の設定ファイル管理（Claude Code / Git / WezTerm / Sakura Editor）
- **リポジトリ**: （リポジトリ URL を記入）
- **ブランチ戦略**: main ブランチで開発中

## 現在のステータス

| 項目 | 状態 |
|------|------|
| フェーズ | 運用中 |
| 安定度 | 安定 — 基本構成が完成 |
| ブロッカー | なし |

## 直近のコミット履歴

<!-- 最新5件を記録。新しいコミットがあれば上から追加し、古いものを削除する -->

| 日時 | コミット | 内容 |
|------|---------|------|
| 2026-02-17 | `39e6628` | Add tdd and review-pr skills, enable model invocation for create-skill |
| 2026-02-17 | `3a2dc44` | Add Alt+W keybinding to close current pane |
| 2026-02-17 | `f10105b` | Migrate skills to SKILL.md directory format with YAML frontmatter |
| 2026-02-17 | `7f6f685` | Add summon and create-skill skills with symlink setup |
| 2026-02-16 | `b149737` | Remove tmux configuration in favor of WezTerm |

## 完了済みのマイルストーン

- [x] Git 設定（`.gitconfig`）
- [x] WezTerm 設定（`.wezterm.lua`）
- [x] Claude Code 設定（`CLAUDE.md` / `settings.json`）
- [x] インストールスクリプト（`install.sh`）
- [x] README 整備
- [x] Skills 機能の追加（summon, create-skill, tdd, review-pr）
- [x] Sakura Editor 設定（`sakura.ini`）
- [x] ドキュメント体系の整備（CLAUDE.md / docs/）

## 進行中のタスク

<!-- 現在取り組んでいるタスクを記載 -->

- （現在進行中のタスクなし）

## 次にやること（候補）

<!-- 優先度の高い順に並べる。完了したら「完了済みのマイルストーン」に移動する -->

- [ ] プロジェクトダッシュボードの運用開始
- [ ] （ここにタスクを追加）

## 技術的な課題・メモ

<!-- 開発中に気づいた課題、注意点、検討事項を記録する -->

- `MSYS=winsymlinks:nativestrict` を設定しないと Git Bash の `ln -s` がコピーになる
- 開発者モード ON が必要（シンボリックリンク作成の権限）

## ファイル構成

<!-- プロジェクト構成が変わったら更新する -->

```
dotfiles/
├── claude/
│   ├── CLAUDE.md        # Claude Code のカスタム指示
│   ├── settings.json    # Claude Code の権限・設定
│   ├── skills/          # Claude Code のカスタムスキル
│   └── agents/          # Claude Code のカスタムエージェント
├── git/
│   └── .gitconfig       # Git のユーザー設定
├── sakura/
│   └── sakura.ini       # Sakura Editor の設定
├── wezterm/
│   └── .wezterm.lua     # WezTerm の設定
├── docs/
│   ├── setup/setup.md           # 環境セットアップガイド
│   ├── claude/claude.md         # Claude Code 運用ガイド
│   ├── claude/skills.md         # カスタムスキル一覧
│   └── dashboard/dashboard.md   # プロジェクトダッシュボード（本ファイル）
├── install.sh           # セットアップスクリプト
├── CLAUDE.md            # Claude Code エントリポイント
├── README.md            # プロジェクト概要
└── .gitignore
```

---

## 更新ガイドライン

このダッシュボードは以下のタイミングで更新してください：

1. **コミット後** — 「直近のコミット履歴」を更新（最新5件を維持）
2. **タスク着手時** — 「進行中のタスク」に追加
3. **タスク完了時** — 「完了済みのマイルストーン」に移動、「次にやること」から削除
4. **構成変更時** — 「ファイル構成」を更新
5. **問題発見時** — 「技術的な課題・メモ」に記録
