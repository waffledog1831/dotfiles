# Codex 運用ガイド

## 設定ファイル

| 管理元 | 配置先 | 内容 |
|--------|--------|------|
| `common/codex/AGENTS.md` | `~/.codex/AGENTS.md` | 日本語・人格・会話ルール・行動原則 |
| `common/codex/config.toml` | `~/.codex/config.toml` | 推論レベル・承認ポリシー・サンドボックス・TUI 通知 |

`CODEX_HOME` が指定されている場合は、`~/.codex` の代わりにそのディレクトリへ配置する。

## 適用方法

Codex CLI は別途インストールし、ログインしておく。
既存の Windows / WSL セットアップからも共通設定が適用される。
設定のみを適用する場合は、リポジトリのルートで次を実行する。

```bash
bash common/install.sh
```

既存の設定ファイルはシンボリックリンクに置き換わるため、必要なら実行前にバックアップする。
`common/install.sh` は Git と Claude Code の設定も適用する。
認証情報や履歴を含む `.codex` ディレクトリ全体はリンクせず、上記の2ファイルのみを管理する。

## Claude Code からの対応

- `CLAUDE.md` の人格・日本語・技術回答方針を `AGENTS.md` に反映する。
- 通常の作業は `workspace-write` 内で実行し、追加権限が必要な場合は `on-request` で承認を求める。
- モデル名は固定せず、推論レベルを `high` に設定する。
- ターン完了・承認待ちの通知は Codex の TUI 通知で設定する。Windows 固有の音声フックは移植しない。
- Claude Code の `permissions.deny` に相当するファイル単位の制限は、この設定では強制されない。機密ファイルの扱いは `AGENTS.md` に指示として記載する。
- Claude Code のスキル・エージェントは専用記法を含むため、自動共有しない。

設定変更後は Codex を再起動する。プロジェクト固有の指示は各リポジトリの `AGENTS.md` に置く。
