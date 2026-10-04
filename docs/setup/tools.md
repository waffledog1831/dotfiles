# Windows / WSL ツール配置

## 基本方針

- **Windows**: GUIアプリ・IDE・ターミナル本体
- **WSL**: 日常CLI・開発の共通ツール

## Windows

GUIアプリは基本ここ。

- Git for Windows
- Claude Code
- WezTerm
- VS Code
- Android Studio
- Bruno
- DBeaver
- Sakura Editor

## WSL

共通のCLI作業環境。
どのプロジェクトでも使うものを入れる。

### 基本ツール

- git
- ssh
- gh（apt 標準外のため別途インストール。手順は [wsl-setup.md](wsl-setup.md) を参照）
- curl
- wget
- unzip
- zip
- make

### CLIユーティリティ

- jq
- ripgrep
- fd
- tree

### 開発効率ツール

- nvim
- tmux
- Claude Code（インストール手順は [wsl-setup.md](wsl-setup.md) を参照）

### 言語ランタイム管理

複数プロジェクトで共通して使う言語は WSL 本体にバージョン管理ツールで入れる。

- **fnm**（Node.js）— `fnm install --lts` / `fnm use <version>`
- **pyenv**（Python）— `pyenv install <version>` / `pyenv global <version>`
- EAS CLI（`npm install -g eas-cli`）

> インストール手順の詳細は [wsl-setup.md](wsl-setup.md) を参照。

### クラウド系

- gcloud
- terraform
- awscli

### コンテナ

- docker（Docker Engine + compose plugin）

> Docker Desktop / Rancher Desktop のような Windows 側の GUI ランタイムは使わず、WSL に直接 Engine を入れる。
> `/mnt/c` 経由の I/O を挟まないぶん速く、GUI の起動待ちも不要。

## 判断ルール

### WSLに入れるもの

- 毎日使うCLI
- プロジェクト共通ツール
- Git操作
- ファイル操作
- 複数プロジェクトで共通して使うクラウドCLI

例:

- git
- ripgrep
- nvim
- tmux
- gcloud

## まとめ

| 環境 | 役割 | 代表ツール |
|------|------|-----------|
| Windows | 操作UI | WezTerm, VS Code, Android Studio |
| WSL | 開発の母艦CLI環境 | git, ripgrep, nvim, gcloud, docker |
