# dotfiles

開発環境のセットアップに使う設定ファイル群。

## 構成

```
dotfiles/
├── common/              # 共通設定（Windows / WSL 両環境）
│   ├── claude/          # Claude Code（カスタム指示・権限・スキル・エージェント）
│   ├── codex/           # Codex（カスタム指示・権限・スキル・エージェント）
│   ├── git/             # Git 設定
│   ├── lib.sh           # リンク配置の共通処理
│   └── install.sh       # 共通設定の配置
├── windows/             # Windows 専用設定
│   ├── wezterm/         # WezTerm（PowerShell 7）
│   ├── sakura/          # Sakura Editor
│   └── install.sh       # Windows セットアップスクリプト
├── wsl/                 # WSL 専用設定
│   ├── bash/            # Bash（.bashrc / .bash_aliases）
│   ├── setup.sh         # WSL ツール導入
│   └── install.sh       # WSL 設定の配置
├── docs/                # ドキュメント
│   ├── ai/              # Claude Code / Codex・キャラクター・スキル
│   └── setup/           # 環境構築
└── .gitignore
```

## クイックスタート

**Windows（Git Bash）:**
```bash
bash windows/install.sh
```

**WSL（Ubuntu、初回）:**
```bash
bash wsl/setup.sh
bash wsl/install.sh
```

設定だけを再適用する場合は `bash wsl/install.sh` を実行する。ツールの導入・更新は `wsl/setup.sh` に分離している。

各設定ファイルが `~` 以下にシンボリックリンクで配置される。共通設定（Git / Claude Code / Codex）は両環境で自動適用される。

スクリプト実行後、`~/.gitconfig.local` を作成して Git のユーザー情報（name / email）を設定すること。新しいブランチの初回 push は追跡先を自動設定し、fetch 時は削除済みのリモート追跡ブランチを整理する。詳細は各セットアップガイドを参照。

> 前提条件やトラブルシューティングは各セットアップガイドを参照。

## ドキュメント

- [セットアップガイド](docs/setup/windows-setup.md) — 前提条件・インストール手順・注意点
- [Claude Code 運用ガイド](docs/ai/claude.md) — 設定ファイルの役割と運用方法
- [Codex 運用ガイド](docs/ai/codex.md) — 設定ファイルの役割と適用方法
- [カスタムスキル一覧](docs/ai/skills.md) — 利用可能なスキルとその使い方
- [キャラクター一覧](docs/ai/arcana.md) — 必要時に呼ぶエージェントの役割
