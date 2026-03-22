# dotfiles

開発環境のセットアップに使う設定ファイル群。

## 構成

```
dotfiles/
├── claude/
│   ├── CLAUDE.md        # Claude Code のカスタム指示
│   ├── settings.json    # Claude Code の権限・設定
│   ├── skills/          # Claude Code のカスタムスキル
│   └── agents/          # 冒険者ギルド「Arcana」エージェント
├── git/
│   └── .gitconfig       # Git のユーザー設定
├── wezterm/
│   └── .wezterm.lua     # WezTerm の設定（PowerShell 7 / C:\project）
├── docs/                # ドキュメント
├── install.sh           # セットアップスクリプト
├── arcana-init.sh       # Arcana 書庫の初期化スクリプト
└── .gitignore
```

## クイックスタート

```bash
bash install.sh
```

各設定ファイルが `~` 以下にシンボリックリンクで配置される。

> 前提条件やトラブルシューティングは [セットアップガイド](docs/setup/setup.md) を参照。

## ドキュメント

- [セットアップガイド](docs/setup/setup.md) — 前提条件・インストール手順・注意点
- [Claude Code 運用ガイド](docs/claude/claude.md) — 設定ファイルの役割と運用方法
- [カスタムスキル一覧](docs/claude/skills.md) — 利用可能なスキルとその使い方
- [冒険者ギルド「Arcana」](docs/claude/arcana.md) — エージェント一覧とギルド拠点の使い方
