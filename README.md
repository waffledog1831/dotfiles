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
├── tmux/
│   └── .tmux.conf       # tmux の設定（WSL 用）
├── wezterm/
│   └── .wezterm.lua     # WezTerm の設定（PowerShell 7 / C:\project）
├── scripts/
│   └── ubuntu.bat       # WSL (Ubuntu) 起動スクリプト
├── install.sh           # セットアップスクリプト
└── .gitignore
```

## セットアップ

### 前提条件（Windows）

- シンボリックリンクの作成に **開発者モード** が必要
  - 設定 → システム → 開発者向け → 開発者モード: ON
- **PowerShell 7** のインストール（WezTerm のデフォルトシェル）
  ```
  winget install Microsoft.PowerShell
  ```

### インストール

```bash
bash install.sh
```

各設定ファイルが `~` 以下にシンボリックリンクで配置される。

### WSL ショートカット

`scripts/ubuntu.bat` をダブルクリック、またはお好みの場所にコピーして使用。
