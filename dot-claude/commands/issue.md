---
description: GitHub Issueの内容を確認
---

Issue #$ARGUMENTS の内容を確認します。

## 入力
$ARGUMENTS

引数はGitHub Issue番号（例: `/issue 5`）

```bash
gh issue view $ARGUMENTS
```

## 参照
@CLAUDE.md（ドメイン知識・用語集）
@docs/breakdown.md（タスク情報との対応を確認）

以下の形式で要約してください：

### 📋 Issue #$ARGUMENTS サマリー
**タイトル**: [タイトル]
**Breakdownタスク**: #X（該当する場合）
**種別**: [infra/db/api/ui/feature/test/docs]
**関連機能**: [F-XXX]
**目的**: [何を達成したいか]
**要件**: [要件リスト]
**受け入れ条件**: [条件リスト]
**編集対象**: `[ディレクトリ]`
**依存タスク**: [依存関係とその完了状況]
**ドメイン用語**: [このIssueに関連する用語があれば]

---

## 次のステップ

Issue内容を確認したら、`/research $ARGUMENTS` でコードベース調査を開始してください。
