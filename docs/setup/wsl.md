# WSL セットアップガイド

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

`jq`・`tree` は apt でインストール。`ripgrep`・`fd` は apt の標準リポジトリにないため、別途追加する。

```bash
sudo apt install -y jq tree
```

**ripgrep**:

```bash
sudo apt install -y ripgrep
```

**fd**:

```bash
sudo apt install -y fd-find
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

### クラウド系

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

**awscli**:

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws/
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

## Git の初期設定

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --global init.defaultBranch main
```

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

WSL には Node.js を入れない方針（Node.js は Dev Container に入れる）のため、公式が提供するスタンドアロンインストーラーを使う。

```bash
curl -fsSL https://claude.ai/install.sh | sh
```

> Node.js が必要な場合（Dev Container 外でも使いたいとき）は [nodesource](https://github.com/nodesource/distributions) で Node.js をインストールしてから `npm install -g @anthropic-ai/claude-code` でも入れられる。

## dotfiles の適用

```bash
git clone <repository-url> ~/dotfiles
cd ~/dotfiles
bash install.sh
```

各設定ファイルが `~` 以下にシンボリックリンクで配置される。
