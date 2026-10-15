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
git clone <repository-url> C:/repos/dotfiles
```

### 2. セットアップスクリプトの実行

```bash
cd C:/repos/dotfiles
bash windows/setup.sh
```

各設定ファイルが `~` 以下にシンボリックリンクで配置されます。

### 3. Git ユーザー設定

`~/.gitconfig.local` を作成し、Git のユーザー情報を設定します。

```ini
# ~/.gitconfig.local
[user]
    name = your-username
    email = your@email.com
```

> `.gitconfig.local` は Git 管理外のため、マシンごとに作成が必要です。

### 4. シンボリックリンクの注意点

Git Bash 上で `ln -s` を使う場合、デフォルトではファイルコピーになります。
ネイティブなシンボリックリンクを作成するには、以下の環境変数が必要です。

```bash
export MSYS=winsymlinks:nativestrict
```

`setup.sh` 内でこの変数を設定しているため、スクリプト経由であれば自動的にネイティブシンボリックリンクが作成されます。

## 配置される設定ファイル

| ソース | リンク先 | 説明 |
|--------|----------|------|
| `common/git/.gitconfig` | `~/.gitconfig` | Git の共通設定（ユーザー情報は別途 `~/.gitconfig.local` に設定） |
| `common/git/.gitignore_global` | `~/.gitignore_global` | Git のグローバル除外設定 |
| `common/git/hooks/` | `~/.git-hooks/` | Git のグローバルフック |
| `windows/terminal/settings.json` | Windows Terminal の `settings.json` | 配色・透過・Ubuntu / Herdr ランチャー |
| `windows/wezterm/.wezterm.lua` | `~/.wezterm.lua` | WezTerm の設定 |
| `windows/sakura/sakura.ini` | `~/AppData/Roaming/sakura/sakura.ini` | Sakura Editor の設定 |
| `windows/powershell/Microsoft.PowerShell_profile.ps1` | `~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1` | PowerShell 7 プロファイル |

## Windows Terminal

Windows Terminal を一度起動してから、Git Bash で `bash windows/setup.sh` を実行する。
Store 版と非パッケージ版の既存設定ディレクトリを検出し、`settings.json` を
リポジトリの設定へのリンクに置き換える。

既定は `~/repos` で起動する「Ubuntu / Herdr」。`Alt+L` で通常の Ubuntu と
PowerShell 7 も選べる。配色は Catppuccin Mocha、フォントは Cascadia Code 12pt、
不透明度は 90%。分割やセッション管理は Herdr で行う。

Preview 版は自動配置の対象外。

## WSL (Ubuntu) のセットアップ

WezTerm で `Alt+L` → 「Ubuntu」を選択して起動。

WSL 環境でのツールインストールや dotfiles の適用手順は [WSL セットアップガイド](wsl-setup.md) を参照。
