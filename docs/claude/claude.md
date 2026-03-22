# Claude Code 運用ガイド

## 概要

このリポジトリでは Claude Code の個人設定（`~/.claude/`）をバージョン管理し、`install.sh` でシンボリックリンクを張って運用します。

## 設定ファイルの構成

```
claude/
├── CLAUDE.md        # カスタム指示（人格・回答スタイル）
├── settings.json    # 権限・動作設定
├── skills/          # カスタムスキル（/コマンド で呼び出し）
│   ├── summon/
│   ├── tdd/
│   └── review-pr/
└── agents/          # カスタムエージェント（冒険者ギルド）
```

`install.sh` により以下のようにリンクされます。

```
claude/CLAUDE.md      → ~/.claude/CLAUDE.md
claude/settings.json  → ~/.claude/settings.json
claude/skills/        → ~/.claude/skills/
claude/agents/        → ~/.claude/agents/
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
`claude/skills/{スキル名}/SKILL.md` に定義し、`install.sh` で `~/.claude/skills/` にリンクされます。

利用可能なスキルの一覧は [skills.md](skills.md) を参照。

## Agents（冒険者ギルド「Arcana」）

「冒険者ギルド」をテーマにしたマルチエージェントシステムです。
`claude/agents/{キャラクター名}.md` に定義し、`install.sh` で `~/.claude/agents/` にリンクされます。
エージェントチーム機能（`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS`）を有効化済み。

| 冒険者 | ファイル | 役割 |
|--------|---------|------|
| 受付嬢リリア | `lilia.md` | クエスト受付・パーティ編成・進捗管理 |
| 剣士ガルド | `gald.md` | コード実装（主力アタッカー） |
| 斥候シオン | `sion.md` | コードベース探索・調査 |
| 魔法使いメルル | `merle.md` | リファクタリング・最適化 |
| 僧侶セラ | `sera.md` | バグ修正・テスト・品質保証 |
| 賢者オルドス | `ordos.md` | コードレビュー・設計助言 |

詳細は [agents.md](agents.md) を参照。

## 設定の変更手順

1. このリポジトリの `claude/` 配下のファイルを編集
2. シンボリックリンク経由で即座に反映される（再リンク不要）
3. 変更内容をコミット・プッシュ
