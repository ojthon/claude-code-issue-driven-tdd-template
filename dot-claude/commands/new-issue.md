---
description: 新しいGitHub Issueを作成
---

新しいIssueを作成します。

## 入力
$ARGUMENTS

引数は以下のいずれかの形式：
- `#番号` : docs/breakdown.md のタスク番号（例: `/new-issue #1`）
- タイトル文字列 : 新規Issueのタイトル（例: `/new-issue ログイン機能の実装`）

## 参照
@docs/breakdown.md（タスク一覧から詳細を取得）
@docs/requirements.md
@CLAUDE.md（ドメイン知識・用語集）

## 手順

### 0. breakdown.md からタスク情報を取得（#番号 指定の場合）
引数が `#番号` 形式の場合：
1. docs/breakdown.md を読み込む
2. 該当番号のタスク情報を取得：
   - タイトル
   - 種別（infra/db/api/ui/feature/test/docs）
   - 編集対象ディレクトリ
   - 依存関係
   - 概要
3. この情報を元にIssue内容を構成

### 1. 入力内容を整理
- タイトル: 簡潔で具体的に
- 目的: 何を達成したいか
- 要件: 具体的な機能・振る舞い
- 受け入れ条件: 完了の定義

### 2. requirements.mdとの整合性確認
- 該当する機能要件のIDを特定
- ユースケースとの対応を確認

### 3. Issue作成
```bash
gh issue create \
  --title "[種別] [タイトル]" \
  --body "## 概要
[このIssueで達成したいこと]

## Breakdown参照
- タスク番号: #X
- 種別: [種別]
- 編集対象: \`[ディレクトリ]\`
- 依存: [依存タスク]

## 関連する機能要件
- F-XXX: [機能名]

## 要件
- [ ] [要件1]
- [ ] [要件2]

## 受け入れ条件
- [条件1]
- [条件2]

## 技術メモ
[実装のヒントがあれば]"
```

### 4. 結果表示
作成されたGitHub Issue番号とURLを表示してください。

### 5. breakdown.md の更新（必須）
Issue作成後、docs/breakdown.md の該当タスクにGitHub Issue情報を追記：

```markdown
変更前:
- [ ] **#1** プロジェクト初期化 `infra` - 環境構築
  - 編集対象: `./`
  - 依存: なし

変更後:
- [ ] **#1** プロジェクト初期化 `infra` - 環境構築
  - 編集対象: `./`
  - 依存: なし
  - GitHub Issue: [#1](https://github.com/owner/repo/issues/1)
```

**重要**: 必ず GitHub Issue のリンクを追記してください。

---

## 次のステップ

Issue作成後、`/issue [作成したIssue番号]` でIssue内容を確認してください。
