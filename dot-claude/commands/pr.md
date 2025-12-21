---
description: PRを作成
---

Issue #$ARGUMENTS に対するPRを作成します。

## 入力
$ARGUMENTS

引数はGitHub Issue番号（例: `/pr 5`）

## 参照
@docs/breakdown.md（タスク情報を確認）

## 手順

### 1. タスク情報の確認
docs/breakdown.md から該当タスクの種別を確認

### 2. 変更確認
```bash
git status
git diff --stat
```

### 3. 未コミット変更の確認
未コミットの変更があれば、適切なメッセージでコミット

### 4. プッシュ
```bash
git push -u origin HEAD
```

### 5. PR作成

**PR命名規則**: `[種別] #[Issue番号]: [簡潔な説明]`

```bash
gh pr create \
  --title "[種別] #$ARGUMENTS: [簡潔な説明]" \
  --body "## 概要
[このPRで実装した内容]

## Breakdown参照
- タスク番号: #X
- 種別: [種別]

## 変更点
- [変更1]
- [変更2]

## テスト
- [x] ユニットテスト追加
- [x] 既存テストが通ることを確認

Fixes #$ARGUMENTS"
```

**PRタイトル例**:
- `infra #1: プロジェクト初期化`
- `api #5: ログインAPI実装`
- `ui #10: ログインフォーム作成`

### 6. 結果表示
作成されたPR番号とURLを表示してください。

### 7. breakdown.md の更新（必須）
PR作成後、docs/breakdown.md の該当タスクにPR情報を追記：

```markdown
変更前:
- [ ] **#1** プロジェクト初期化 `infra` - 環境構築
  - 編集対象: `./`
  - 依存: なし
  - GitHub Issue: [#1](https://github.com/owner/repo/issues/1)

変更後:
- [ ] **#1** プロジェクト初期化 `infra` - 環境構築
  - 編集対象: `./`
  - 依存: なし
  - GitHub Issue: [#1](https://github.com/owner/repo/issues/1)
  - PR: [#2](https://github.com/owner/repo/pull/2)
```

**重要**: 必ず PR のリンクを追記してください。

---

## 次のステップ

PR作成後、CIが通ったら `/merge` でマージに進んでください。
