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
bash windows/install.sh
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
| `common/claude/CLAUDE.md` | `~/.claude/CLAUDE.md` | Claude Code のカスタム指示 |
| `common/claude/settings.json` | `~/.claude/settings.json` | Claude Code の権限・設定 |
| `common/claude/skills/` | `~/.claude/skills/` | Claude Code カスタムスキル |
| `common/claude/agents/` | `~/.claude/agents/` | Claude Code エージェント定義 |
| `common/git/.gitconfig` | `~/.gitconfig` | Git のユーザー設定 |
| `common/git/.gitignore_global` | `~/.gitignore_global` | Git のグローバル除外設定 |
| `common/git/hooks/` | `~/.git-hooks/` | Git のグローバルフック |
| `windows/wezterm/.wezterm.lua` | `~/.wezterm.lua` | WezTerm の設定 |
| `windows/sakura/sakura.ini` | `~/AppData/Roaming/sakura/sakura.ini` | Sakura Editor の設定 |
| `windows/powershell/Microsoft.PowerShell_profile.ps1` | `~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1` | PowerShell 7 プロファイル |

## WSL (Ubuntu) のセットアップ

WezTerm で `Alt+L` → 「Ubuntu」を選択して起動。

WSL 環境でのツールインストールや dotfiles の適用手順は [WSL セットアップガイド](wsl-setup.md) を参照。
