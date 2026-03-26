# セットアップガイド

## 前提条件（Windows）

- **Git Bash**（MSYS2）がインストールされていること
- **開発者モード** が ON であること（シンボリックリンク作成に必要）
  - 設定 → システム → 開発者向け → 開発者モード: ON
- **PowerShell 7** がインストールされていること（WezTerm のデフォルトシェル）
  ```
  winget install Microsoft.PowerShell
  ```

## インストール手順

### 1. リポジトリのクローン

```bash
git clone <repository-url> C:/project/dotfiles
```

### 2. セットアップスクリプトの実行

```bash
cd C:/project/dotfiles
bash install.sh
```

各設定ファイルが `~` 以下にシンボリックリンクで配置されます。

### 3. シンボリックリンクの注意点

Git Bash 上で `ln -s` を使う場合、デフォルトではファイルコピーになります。
ネイティブなシンボリックリンクを作成するには、以下の環境変数が必要です。

```bash
export MSYS=winsymlinks:nativestrict
```

`install.sh` 内でこの変数を設定しているため、スクリプト経由であれば自動的にネイティブシンボリックリンクが作成されます。

## 配置される設定ファイル

| ソース | リンク先 | 説明 |
|--------|----------|------|
| `claude/CLAUDE.md` | `~/.claude/CLAUDE.md` | Claude Code のカスタム指示 |
| `claude/settings.json` | `~/.claude/settings.json` | Claude Code の権限・設定 |
| `git/.gitconfig` | `~/.gitconfig` | Git のユーザー設定 |
| `wezterm/.wezterm.lua` | `~/.wezterm.lua` | WezTerm の設定 |

## WSL (Ubuntu) のセットアップ

WezTerm で `Ctrl+Shift+L` → 「Ubuntu」を選択して起動。

WSL 環境でのツールインストールや dotfiles の適用手順は [WSL セットアップガイド](wsl-setup.md) を参照。
