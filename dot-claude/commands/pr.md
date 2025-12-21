---
description: PRを作成
---

Issue #$ARGUMENTS に対するPRを作成します。

## 手順

### 1. 変更確認
```bash
git status
git diff --stat
```

### 2. 未コミット変更の確認
未コミットの変更があれば、適切なメッセージでコミット

### 3. プッシュ
```bash
git push -u origin HEAD
```

### 4. PR作成
```bash
gh pr create \
  --title "feat: [機能の説明]" \
  --body "## 概要
[このPRで実装した内容]

## 変更点
- [変更1]
- [変更2]

## テスト
- [x] ユニットテスト追加
- [x] 既存テストが通ることを確認

Fixes #$ARGUMENTS"
```

### 5. 結果表示
作成されたPRのURLを表示してください。
