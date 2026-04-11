# WSL セットアップガイド

> Ubuntu 22.04 LTS 以降を想定。

## WSL の起動

WezTerm で `Alt+L` → 「Ubuntu」を選択。

## パッケージの更新

```bash
sudo apt update && sudo apt upgrade -y
```

## ツールのインストール

### 基本ツール

```bash
sudo apt install -y git openssh-client curl wget unzip zip make
```

### CLIユーティリティ

`jq`・`tree`・`ripgrep` は apt でインストール可能。`fd` はパッケージ名が `fd-find` のため注意。

```bash
sudo apt install -y jq tree ripgrep fd-find
# fd コマンドとして使えるようにエイリアスを設定
echo 'alias fd=fdfind' >> ~/.bashrc
source ~/.bashrc
```

### 開発効率ツール

**nvim**:

```bash
sudo apt install -y neovim
```

**tmux**:

```bash
sudo apt install -y tmux
```

### 言語ランタイム

#### fnm（Node.js）

[fnm](https://github.com/Schniz/fnm) で Node.js のバージョンを管理する。

```bash
curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.local/share/fnm" --skip-shell
```

インストール後、`.bashrc` に以下を追記して PATH を通す（`wsl/install.sh` 経由の場合は `.bashrc` シンボリックリンクで自動適用される）。

```bash
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env)"
```

LTS 版の Node.js をインストールしてデフォルトに設定する。

```bash
fnm install --lts
fnm default lts-latest
```

バージョンを切り替えるときは:

```bash
fnm install 20        # 特定バージョンをインストール
fnm use 20            # 現在のシェルで切り替え
fnm default 20        # デフォルトを変更
```

#### EAS CLI

[EAS CLI](https://docs.expo.dev/eas/) は Expo Application Services のコマンドラインツール。Node.js インストール後に npm でグローバルインストールする。

```bash
npm install -g eas-cli
```

#### pyenv（Python）

[pyenv](https://github.com/pyenv/pyenv) で Python のバージョンを管理する。まず依存パッケージをインストール。

```bash
sudo apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
  libreadline-dev libsqlite3-dev libncursesw5-dev xz-utils tk-dev \
  libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
```

pyenv 本体のインストール:

```bash
curl https://pyenv.run | bash
```

`.bashrc` に以下を追記して PATH を通す（`wsl/install.sh` 経由の場合は自動適用される）。

```bash
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
```

Python のインストールとデフォルト設定:

```bash
pyenv install 3.12.0   # インストールしたいバージョンを指定
pyenv global 3.12.0    # グローバルデフォルトに設定
```

バージョンを切り替えるときは:

```bash
pyenv install 3.11.9   # 別バージョンをインストール
pyenv global 3.11.9    # グローバルデフォルトを変更
pyenv local 3.11.9     # カレントディレクトリのみ切り替え（.python-version に保存）
```

### クラウド系

**awscli**:

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws/
```

**gcloud**:

```bash
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt update && sudo apt install -y google-cloud-cli
```

**terraform**:

```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install -y terraform
```

### gh（GitHub CLI）

apt の標準リポジトリにないため、公式リポジトリを追加してインストールする。

```bash
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
  && sudo mkdir -p -m 755 /etc/apt/keyrings \
  && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y
```

インストール後、認証する。

```bash
gh auth login
```

## Git ユーザー設定

dotfiles の適用後、`~/.gitconfig.local` を作成してユーザー情報を設定します。

```ini
# ~/.gitconfig.local
[user]
    name = your-username
    email = your@email.com
```

> `.gitconfig.local` は Git 管理外のため、マシンごとに作成が必要です。`defaultBranch` 等の共通設定は `~/.gitconfig`（dotfiles 管理）に含まれています。

## SSH 鍵の生成・GitHub への登録

```bash
# 鍵を生成（メールアドレスは自分のものに変更）
ssh-keygen -t ed25519 -C "your@email.com"

# 公開鍵を表示してコピー
cat ~/.ssh/id_ed25519.pub
```

コピーした公開鍵を GitHub の **Settings → SSH and GPG keys → New SSH key** に登録する。

接続確認:

```bash
ssh -T git@github.com
```

## Claude Code のインストール

公式が提供するスタンドアロンインストーラーを使う。

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

## dotfiles の適用

> WSL 環境でのクローン先は `~/dotfiles`（Windows 側の `C:/repos/dotfiles` とは別）。

```bash
git clone <repository-url> ~/dotfiles
cd ~/dotfiles
bash install.sh
```

各設定ファイルが `~` 以下にシンボリックリンクで配置される。

スクリプトが自動で適用するもの:

- bash（`.bashrc` / `.bash_aliases`）
- Neovim（`~/.config/nvim/`）
- Git（`.gitconfig` / `.gitignore_global` / `~/.git-hooks/`）
- Claude Code（`~/.claude/` 以下）
