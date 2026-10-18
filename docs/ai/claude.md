# Claude Code 運用ガイド

個人設定を `wsl/claude/` で管理し、`wsl/setup.sh` で配置します。

| 管理元 | 配置先 | 内容 |
|--------|--------|------|
| `CLAUDE.md` | `~/.claude/CLAUDE.md` | アイの口調、日本語、作業の境界 |
| `settings.json` | `~/.claude/settings.json` | モデル・権限・帰属表記・通知 |
| `skills/` | `~/.claude/skills/` | 必要時に自動選択する運用手順 |
| `agents/` | `~/.claude/agents/` | 必要時だけ使うキャラクターと役割 |

## 運用方針

常時読む指示には個人の好み、PR まで進める完了条件、作業の境界を置きます。具体的な Git / PR 手順はスキルへ分け、必要時に自動選択します。
プロジェクト固有の構成や検証方法は各リポジトリの `CLAUDE.md` に記載します。

スキルは [一覧](skills.md)、キャラクターは [キャラクター一覧](arcana.md) を参照してください。

## 権限と通知

- `permissions.defaultMode: "auto"` で Bash を含む実行内容を自動審査します。Bash の一律許可はせず、WebFetch / WebSearch は明示的に許可します。
- `.env`、`.env.*`、`secrets/` はルートと下位ディレクトリの Read / Edit を拒否します。
- 削除、force push、hard reset、git clean は確認対象です。
- 評価順序は deny → ask → allow です。コマンドの文字列ルールはあらゆる迂回を防ぐ境界ではなく、Read / Edit の拒否と自動審査だけを、Bash からの完全な機密隔離とは扱いません。
- `preferredNotifChannel: "terminal_bell"` で作業完了・承認待ちをターミナルのベルで通知します。音はターミナル側の設定に依存します。
- ファイル候補の gitignore 尊重、応答後の所要時間表示、更新チャンネルは既定値を使用します。
- 帰属表記は `settings.json` に集約し、スキル内では固定しません。

`auto` に対応する最新の Claude Code を使用してください。設定は最新の SchemaStore スキーマで確認していますが、この環境では Claude Code 本体による審査動作を検証していません。

## 設定の変更

管理元を編集し、必要に応じて Claude Code を再起動します。新しいリンクの配置は `bash wsl/setup.sh` で行います。
既存ファイルは置き換わるため必要ならバックアップします。リンク先に実ディレクトリがある場合は停止し、内容を勝手に削除しません。

## Remote Control

個人情報を含む `~/.claude.json` は管理しません。Remote Control の有効化は各マシンの Claude Code 内で設定してください。
