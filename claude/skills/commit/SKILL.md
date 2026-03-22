---
name: commit
description: 変更内容を分析し、適切なコミットメッセージで自動コミットする。
argument-hint: "[オプション: コミットメッセージの補足やスコープ指定]"
---

変更内容を分析し、コミットを作成してください。

## 補足情報

$ARGUMENTS

## 手順

### 1. 変更内容の把握

以下を並列で実行して現在の状態を把握する:

- `git status` — 変更・未追跡ファイルの一覧
- `git diff` — ステージされていない変更の詳細
- `git diff --staged` — ステージ済みの変更の詳細
- `git log --oneline -5` — 直近のコミットメッセージ（スタイル参考用）

### 2. ステージング

- 未ステージの変更がある場合、変更内容を確認して関連ファイルをステージする
- `.env`, `credentials`, `secrets/` など機密ファイルは除外する
- 関連性のない変更が混在している場合は、ユーザーに分割するか確認する

### 3. コミットメッセージの作成

変更内容を分析し、以下のルールでコミットメッセージを作成する:

#### ルール

- **英語**で書く
- **1行目**: 変更の要約（50文字以内を目安、命令形）
- **本文**（必要な場合のみ）: 変更の理由や背景を簡潔に
- 末尾に `Co-Authored-By: Claude <noreply@anthropic.com>` を付与
- 「何をしたか」ではなく「なぜしたか」にフォーカス
- add = 新規追加, update = 既存改善, fix = バグ修正, remove = 削除, refactor = リファクタ

#### メッセージ例

```
Add user authentication with JWT tokens

Co-Authored-By: Claude <noreply@anthropic.com>
```

```
Fix off-by-one error in pagination logic

The last page was returning one extra item due to
inclusive boundary check.

Co-Authored-By: Claude <noreply@anthropic.com>
```

### 4. コミット実行

- HEREDOC 形式でコミットメッセージを渡す
- コミット後に `git status` で成功を確認する
- 結果をユーザーに報告する

### 5. 結果報告

```
✅ コミット完了
━━━━━━━━━━━━━━━━━━
ハッシュ: （短縮ハッシュ）
メッセージ: （コミットメッセージ1行目）
変更: （ファイル数と追加/削除行数）
━━━━━━━━━━━━━━━━━━
```
