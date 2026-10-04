# WSL セットアップガイド

Ubuntu 22.04 LTS 以降を想定。WezTerm で `Alt+L` →「Ubuntu」を選択します。
Windows 側のリポジトリとは別に、WSL のホームへクローンしてください。

## 初回セットアップ

```bash
git clone <repository-url> ~/dotfiles
cd ~/dotfiles
bash wsl/install.sh
bash wsl/setup.sh
```

`install.sh` はツール導入、`setup.sh` は設定の配置だけを行います。
設定を再適用するときは `bash wsl/setup.sh` のみを実行してください。
`install.sh` は最初に `apt update` と `apt upgrade -y` を実行し、設定済みの APT リポジトリで提供される更新を適用します。

## 導入するツール

- 基本: Git、OpenSSH、CA 証明書、curl、wget、unzip、zip、make、GnuPG、lsb-release
- CLI: jq、tree、ripgrep、fd-find、tmux
- Node.js: fnm と Node.js LTS、EAS CLI
- Python: pyenv と導入時点の最新安定版、およびビルド依存パッケージ
- クラウド: gh、AWS CLI、gcloud、Terraform
- コンテナ: Docker Engine と Compose plugin
- AI: Claude Code。Codex CLI のインストールとログインは別途必要

導入済みの fnm / pyenv は再ダウンロードしません。セットアップを再実行するとツール更新や Node.js / Python の既定バージョンの設定が行われます。

## Git の認証とユーザー情報

GitHub CLI でログインし、HTTPS を選択します。

```bash
gh auth login
```

`~/.gitconfig.local` を作成してください。このファイルはマシンごとに管理します。

```ini
[user]
    name = your-username
    email = your@email.com
```

共通設定により、新規ブランチの初回 `git push` で追跡先を設定し、fetch 時に削除済みのリモート追跡ブランチを整理します。

## ランタイムの切り替え

`.bashrc` はインストール済みの fnm / pyenv を初期化します。fd-find は `fd` の別名で利用できます。

```bash
fnm install --lts
fnm use --lts
pyenv install <version>
pyenv local <version>
```

プロジェクト単位のバージョンは fnm / pyenv の設定で管理します。

## Docker

APT のリポジトリ設定は公式手順に合わせて `/etc/apt/sources.list.d/docker.sources` の deb822 形式を使用します。
以前このリポジトリが作成した `docker.list` は内容が一致する場合だけ置き換えます。独自の内容がある場合は停止するので、バックアップしたうえで手動で移行してください。

Docker のサービスを有効化し、実行ユーザーを docker グループへ追加します。
導入後は Windows 側の PowerShell で `wsl --shutdown` を実行し、WSL を起動し直してください。

参照: [Docker の公式導入手順](https://docs.docker.com/engine/install/ubuntu/)

## 配置される設定

- Bash: `~/.bashrc`、`~/.bash_aliases`
- Git: `~/.gitconfig`、`~/.gitignore_global`、`~/.git-hooks/`
- Claude Code: `~/.claude/` の設定・スキル・エージェント
- Codex: `~/.codex/` の設定・役割と `~/.agents/skills/` のスキル

既存ファイルはシンボリックリンクに置き換わります。必要ならバックアップしてください。
配置先に実ディレクトリがある場合は内容を削除せず停止します。
