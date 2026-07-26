# Claude Code 運用ガイド

## 概要

このリポジトリでは Claude Code の個人設定（`~/.claude/`）をバージョン管理し、`install.sh` でシンボリックリンクを張って運用します。

## 設定ファイルの構成

```
common/claude/
├── CLAUDE.md        # カスタム指示（人格・回答スタイル）
├── settings.json    # 権限・動作設定
├── skills/          # カスタムスキル（/コマンド で呼び出し）
│   ├── new-branch/
│   ├── commit/
│   ├── create-pr/
│   ├── review-pr/
│   ├── summon/
│   ├── docs/        # ドキュメント作成/更新
│   └── devops/      # CI/CD・Docker・デプロイ・環境構築
└── agents/          # カスタムエージェント（冒険者ギルド）
```

`common/install.sh` により以下のようにリンクされます。

```
common/claude/CLAUDE.md      → ~/.claude/CLAUDE.md
common/claude/settings.json  → ~/.claude/settings.json
common/claude/skills/        → ~/.claude/skills/
common/claude/agents/        → ~/.claude/agents/
```

## CLAUDE.md の役割

Claude Code の応答スタイル・人格・会話ルールを定義するファイルです。

- 回答言語や口調の指定
- 結論ファーストなどの回答構成ルール
- コード提示のスタイル（差分中心、コピペで動く形）
- 技術回答のポリシー（具体例優先、罠の提示など）

## settings.json の役割

Claude Code のツール実行権限を定義するファイルです。

- **allow**: 承認不要で実行できる操作
- **ask**: 実行前に確認を求める操作（`git commit`, `git push`, `rm` など）
- **deny**: 常にブロックする操作（`rm -rf`, `git push --force` など）

> 評価順序: deny → ask → allow

## Skills（カスタムスキル）

`/スキル名` で呼び出せるショートカットコマンドです。
`common/claude/skills/{スキル名}/SKILL.md` に定義し、`common/install.sh` で `~/.claude/skills/` にリンクされます。

利用可能なスキルの一覧は [skills.md](skills.md) を参照。

## Agents（冒険者ギルド「Arcana」）

「冒険者ギルド」をテーマにしたマルチエージェントシステムです。
`common/claude/agents/{キャラクター名}.md` に定義し、`common/install.sh` で `~/.claude/agents/` にリンクされます。

| 冒険者 | ファイル | 役割 |
|--------|---------|------|
| 冒険者リリア | `lilia.md` | 実装・機能拡張・バグ修正・テスト・リファクタリング |
| 斥候シオン | `sion.md` | コードベース探索・調査 |
| 賢者オルドス | `ordos.md` | コードレビュー・設計助言 |
| 符術師ルカ | `luca.md` | セキュリティ診断・脆弱性監査 |

> メインセッション（アイ）が司令塔となり、`description` の呼び出しルールに基づいて自動で冒険者に委任します。ドキュメント整備は `/docs`、インフラ・CI/CD は `/devops` スキルで対応します（専任冒険者は置きません）。

詳細は [arcana.md](arcana.md) を参照。

## Remote Control（リモート操作）

ローカルの Claude Code セッションを、スマホや claude.ai/code などのブラウザからリモート操作できる機能です。

- **対応バージョン**: v2.1.51 以降
- **対応プラン**: Pro / Max / Team / Enterprise（API キーでの利用は非対応）

### 常時有効化の方法

`settings.json` には対応するキーがなく、Global config として管理されます。

1. Claude Code 内で `/config` を実行
2. 「Enable Remote Control for all sessions」を `true` に設定
3. 設定は `~/.claude.json` に保存される

> `~/.claude.json` にはメールアドレス・UUID・課金情報等が平文で含まれるため、dotfiles でのバージョン管理対象外です。**各マシンで一度ずつ設定が必要**です。

### 起動方法

| 方法 | コマンド | 説明 |
|------|---------|------|
| サーバーモード | `claude remote-control` | リモート制御専用サーバーとして起動 |
| セッション起動時 | `claude --remote-control`（`--rc`） | 起動と同時にリモート制御を有効化 |
| 既存セッション内 | `/remote-control`（`/rc`） | 起動中のセッションでその場で有効化 |

### 注意点

- Team / Enterprise プランの場合、管理者側での有効化も別途必要
- `~/.claude.json` は個人情報を含むため絶対に Git 管理しないこと

## 設定の変更手順

1. このリポジトリの `common/claude/` 配下のファイルを編集
2. シンボリックリンク経由で即座に反映される（再リンク不要）
3. 変更内容をコミット・プッシュ
