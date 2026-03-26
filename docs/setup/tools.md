# Windows / WSL / Dev Container ツール配置

## 基本方針

- **Windows**: GUIアプリ・IDE・ターミナル本体
- **WSL**: 日常CLI・開発の共通ツール
- **Dev Container**: プロジェクト依存のランタイム・SDK

## Windows

GUIアプリは基本ここ。

- Rancher Desktop
- WezTerm
- VS Code
- Android Studio
- Bruno
- DBeaver
- Sakura Editor
- Claude Code

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

### クラウド系

- gcloud
- terraform
- awscli

## Dev Container

プロジェクトごとの実行環境。

### 言語ランタイム

- Node.js
- pnpm / npm / yarn
- Python
- Go
- Java

### ビルドツール

- Gradle
- Maven

### テスト / ブラウザ

- Playwright
- Chromium

### DBツール

- PostgreSQL client
- MySQL client

### その他

- Linter
- Formatter
- プロジェクト固有CLI

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

### Dev Containerに入れるもの

- バージョン依存がある
- プロジェクト専用
- CIと揃えたい

例:

- node
- python
- java

## まとめ

| 環境 | 役割 | 代表ツール |
|------|------|-----------|
| Windows | 操作UI | WezTerm, VS Code, Rancher Desktop |
| WSL | 開発の母艦CLI環境 | git, ripgrep, nvim, gcloud |
| Dev Container | プロジェクト実行環境 | node, python, java, linter |
