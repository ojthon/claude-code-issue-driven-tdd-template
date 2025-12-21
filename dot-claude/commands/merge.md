---
description: PRをマージ
---

現在のブランチのPRをマージします。

## 手順

### 1. PR状態確認
```bash
gh pr status
```

### 2. CI/CDステータス確認
```bash
gh pr checks
```
すべてのチェックがパスしていることを確認。

### 3. マージ実行
```bash
gh pr merge --squash --delete-branch
```

### 4. ローカル更新
```bash
git checkout main
git pull origin main
```

## 注意
- CIが失敗している場合はマージしない
- コンフリクトがある場合は先に解決する
