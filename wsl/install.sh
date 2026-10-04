#!/bin/bash
set -euo pipefail

echo "=== wsl tools setup ==="

# パッケージ更新
echo "--- apt update ---"
sudo apt update

# 基本ツール
echo "--- basic tools ---"
sudo apt install -y git openssh-client ca-certificates curl wget unzip zip make gnupg lsb-release jq tree ripgrep fd-find tmux

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
PYTHON_VERSION="$(pyenv install --list | grep -E '^\s+3\.[0-9]+\.[0-9]+$' | tail -1 | tr -d ' ')"
pyenv install -s "$PYTHON_VERSION"
pyenv global "$PYTHON_VERSION"

# gh（GitHub CLI）
echo "--- gh ---"
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null
sudo chmod a+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
sudo apt update
sudo apt install -y gh

# awscli
echo "--- awscli ---"
AWS_INSTALL_DIR="$(mktemp -d)"
trap 'rm -rf "$AWS_INSTALL_DIR"' EXIT
curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$AWS_INSTALL_DIR/awscliv2.zip"
unzip -q "$AWS_INSTALL_DIR/awscliv2.zip" -d "$AWS_INSTALL_DIR"
sudo "$AWS_INSTALL_DIR/aws/install" --update

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

# Docker（公式の deb822 形式）
echo "--- docker ---"
DOCKER_ARCH="$(dpkg --print-architecture)"
DOCKER_CODENAME="$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")"
DOCKER_LEGACY_SOURCE="/etc/apt/sources.list.d/docker.list"
if [ -e "$DOCKER_LEGACY_SOURCE" ]; then
  expected_source="deb [arch=$DOCKER_ARCH signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $DOCKER_CODENAME stable"
  if [ "$(cat "$DOCKER_LEGACY_SOURCE")" != "$expected_source" ]; then
    echo "ERROR: $DOCKER_LEGACY_SOURCE has custom contents. Migrate it manually before running setup." >&2
    exit 1
  fi
fi
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
sudo tee /etc/apt/sources.list.d/docker.sources >/dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $DOCKER_CODENAME
Components: stable
Architectures: $DOCKER_ARCH
Signed-By: /etc/apt/keyrings/docker.asc
EOF
if [ -e "$DOCKER_LEGACY_SOURCE" ]; then
  sudo rm "$DOCKER_LEGACY_SOURCE"
fi
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"

# Claude Code
echo "--- claude code ---"
curl -fsSL https://claude.ai/install.sh | bash

echo "=== wsl tools setup done ==="
echo "次に bash wsl/setup.sh で設定を適用し、Windows 側で wsl --shutdown を実行してください。"
