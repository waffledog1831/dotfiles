# dotfiles

Windows / WSL 用の dotfiles。構成と適用手順は README.md を参照する。

- 共通設定は common/、環境固有設定は windows/ と wsl/ に置く。
- 設定・配置先を変えたら common/install.sh と対応する運用ガイドを更新する。
- インストール処理の検証は一時ディレクトリをホームとして実行し、実際の個人設定を上書きしない。
- シェル構文、JSON / TOML の解析、繰り返しインストール時のリンクを確認する。

詳しいガイドは docs/ 配下。必要な対象だけ読む。
