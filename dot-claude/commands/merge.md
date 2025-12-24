---
description: PRをマージ
---

現在のブランチのPRをマージします。

## 参照
@docs/breakdown.md（進捗更新のため）

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

### 4. breakdown.md の進捗更新（必須）
マージ完了後、docs/breakdown.md を更新：

```markdown
変更前:
- [ ] **#1** プロジェクト初期化 `infra` - 環境構築
  - 編集対象: `./`
  - 依存: なし
  - GitHub Issue: [#1](https://github.com/owner/repo/issues/1)
  - PR: [#2](https://github.com/owner/repo/pull/2)

変更後:
- [x] **#1** プロジェクト初期化 `infra` - 環境構築 ✅
  - 編集対象: `./`
  - 依存: なし
  - GitHub Issue: [#1](https://github.com/owner/repo/issues/1)
  - PR: [#2](https://github.com/owner/repo/pull/2) (white_check_mark: Merged)
```

### 5. 進捗サマリーの更新
docs/breakdown.md の進捗サマリーセクションを更新：

```markdown
## 進捗サマリー

- 総タスク数: 14
- 完了: 1      ← +1
- 進行中: 0
- 未着手: 13   ← -1
```

### 6. メインディレクトリに戻る

worktreeでの作業が完了したら、メインディレクトリに戻ります：

```bash
cd /path/to/project
```

### 7. Worktreeの削除

使用したworktreeを削除：

```bash
git worktree remove .worktrees/issue_[番号]
```

**例**:
```bash
git worktree remove .worktrees/issue_5
```

## 注意
- CIが失敗している場合はマージしない
- コンフリクトがある場合は先に解決する
- Worktree削除前に未コミットの変更がないことを確認
- **並列開発時**: 複数PRが完了しても、マージは1つずつ順番に実行（同時マージはコンフリクトの原因）

---

## 次のステップ

マージ完了後（メインディレクトリで）：
- 次のタスクがある場合 → `/clear` してから `/new-issue` で次のIssueを作成
- 全タスク完了の場合 → `/release [バージョン]`
