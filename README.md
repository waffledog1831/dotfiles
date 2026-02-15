# dotfiles

開発環境のセットアップに使う設定ファイル群。

## 構成

```
dotfiles/
├── claude/
│   ├── CLAUDE.md        # Claude Code のカスタム指示
│   └── settings.json    # Claude Code の権限・設定
├── git/
│   └── .gitconfig       # Git のユーザー設定
├── scripts/
│   └── ubuntu.bat       # WSL (Ubuntu) 起動スクリプト
└── .gitignore
```

## セットアップ

### Git

```bash
cp git/.gitconfig ~/.gitconfig
```

### Claude Code

```bash
cp claude/CLAUDE.md ~/.claude/CLAUDE.md
cp claude/settings.json ~/.claude/settings.json
```

### WSL ショートカット

`scripts/ubuntu.bat` をダブルクリック、またはお好みの場所にコピーして使用。
