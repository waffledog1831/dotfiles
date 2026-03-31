#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
WSL_DIR="$DOTFILES_DIR/wsl"

link_file() {
  ln -sf "$1" "$2"
  echo "linked: $2"
}

link_dir() {
  local src="$1" dst="$2"
  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -d "$dst" ]; then
    echo "ERROR: $dst is a real directory, not a symlink. Remove it manually." >&2
    exit 1
  fi
  ln -s "$src" "$dst"
  echo "linked: $dst"
}

echo "=== wsl install ==="

# パッケージ更新
echo "--- apt update ---"
sudo apt update && sudo apt upgrade -y

# 基本ツール
echo "--- basic tools ---"
sudo apt install -y git openssh-client curl wget unzip zip make

# CLI ユーティリティ
echo "--- cli utilities ---"
sudo apt install -y jq tree ripgrep fd-find

# 開発効率ツール
echo "--- dev tools ---"
sudo apt install -y neovim tmux

# fnm (Node.js)
echo "--- fnm ---"
if [ ! -f "$HOME/.local/share/fnm/fnm" ]; then
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.local/share/fnm" --skip-shell
else
  echo "fnm already installed, skipping"
fi
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env 2>/dev/null)"
fnm install --lts
fnm default lts-latest

# EAS CLI
echo "--- eas-cli ---"
npm install -g eas-cli

# pyenv (Python)
echo "--- pyenv ---"
sudo apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
  libreadline-dev libsqlite3-dev libncursesw5-dev xz-utils tk-dev \
  libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
if [ ! -d "$HOME/.pyenv" ]; then
  curl https://pyenv.run | bash
else
  echo "pyenv already installed, skipping"
fi
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
PYTHON_LTS="$(pyenv install --list | grep -E '^\s+3\.[0-9]+\.[0-9]+$' | tail -1 | tr -d ' ')"
pyenv install -s "$PYTHON_LTS"
pyenv global "$PYTHON_LTS"

# gh（GitHub CLI）
echo "--- gh ---"
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
  && sudo mkdir -p -m 755 /etc/apt/keyrings \
  && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y

# awscli
echo "--- awscli ---"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
unzip -q /tmp/awscliv2.zip -d /tmp
sudo /tmp/aws/install --update
rm -rf /tmp/awscliv2.zip /tmp/aws/

# gcloud
echo "--- gcloud ---"
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt update && sudo apt install -y google-cloud-cli

# terraform
echo "--- terraform ---"
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install -y terraform

# Claude Code
echo "--- claude code ---"
curl -fsSL https://claude.ai/install.sh | bash

# 共通設定を適用（git / claude）
bash "$DOTFILES_DIR/common/install.sh"

# bash
echo "--- bash config ---"
link_file "$WSL_DIR/bash/.bashrc" "$HOME/.bashrc"
link_file "$WSL_DIR/bash/.bash_aliases" "$HOME/.bash_aliases"

# Neovim (LazyVim)
echo "--- nvim config ---"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
mkdir -p "$NVIM_CONFIG_DIR"
link_file "$WSL_DIR/nvim/init.lua" "$NVIM_CONFIG_DIR/init.lua"
link_dir  "$WSL_DIR/nvim/lua" "$NVIM_CONFIG_DIR/lua"

echo ""
echo "=== wsl install done ==="
echo ""
echo "次に手動で実施してください:"
echo ""
echo "  1. SSH 鍵の生成と GitHub への登録"
echo "       ssh-keygen -t ed25519 -C \"your@email.com\""
echo "       cat ~/.ssh/id_ed25519.pub  # → GitHub Settings > SSH keys に登録"
echo "       ssh -T git@github.com      # 接続確認"
echo ""
echo "  2. GitHub CLI の認証"
echo "       gh auth login"
echo ""
echo "  3. gcloud の認証"
echo "       gcloud auth login"
echo ""
echo "  4. .bashrc の再読み込み"
echo "       source ~/.bashrc"
echo ""
