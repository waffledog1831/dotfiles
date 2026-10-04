# dotfiles

開発環境のセットアップに使う設定ファイル群。

## 構成

```
dotfiles/
├── common/              # 共通設定（Windows / WSL 両環境）
│   ├── claude/          # Claude Code（カスタム指示・権限・スキル・エージェント）
│   ├── codex/           # Codex（カスタム指示・権限・通知）
│   ├── git/             # Git 設定
│   └── install.sh       # 共通セットアップスクリプト
├── windows/             # Windows 専用設定
│   ├── wezterm/         # WezTerm（PowerShell 7）
│   ├── sakura/          # Sakura Editor
│   └── install.sh       # Windows セットアップスクリプト
├── wsl/                 # WSL 専用設定
│   ├── bash/            # Bash（.bashrc / .bash_aliases）
│   ├── nvim/            # Neovim（LazyVim）
│   └── install.sh       # WSL セットアップスクリプト
├── docs/                # ドキュメント
└── .gitignore
```

## クイックスタート

**Windows（Git Bash）:**
```bash
bash windows/install.sh
```

**WSL（Ubuntu）:**
```bash
bash wsl/install.sh
```

各設定ファイルが `~` 以下にシンボリックリンクで配置される。共通設定（Git / Claude Code / Codex）は両環境で自動適用される。

スクリプト実行後、`~/.gitconfig.local` を作成して Git のユーザー情報（name / email）を設定すること。詳細は各セットアップガイドを参照。

> 前提条件やトラブルシューティングは各セットアップガイドを参照。

## ドキュメント

- [セットアップガイド](docs/setup/windows-setup.md) — 前提条件・インストール手順・注意点
- [Claude Code 運用ガイド](docs/claude/claude.md) — 設定ファイルの役割と運用方法
- [Codex 運用ガイド](docs/codex/codex.md) — 設定ファイルの役割と適用方法
- [カスタムスキル一覧](docs/claude/skills.md) — 利用可能なスキルとその使い方
- [冒険者ギルド「Arcana」](docs/claude/arcana.md) — エージェント一覧と使い方
