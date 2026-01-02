---
description: 新規プロジェクトの初期化
---

ultrathink 新しいプロジェクトを開始します。

## フロー

以下の流れで進めます。各ステップの詳細はClaude Codeに任せてください。

1. **ヒアリング**: プロジェクト概要、ターゲット、主要機能、技術要望を確認
2. **要件定義**: docs/requirements.md を生成
3. **設計**:
   - docs/architecture.md（システム構成、技術スタック）
   - docs/database-schema.md（ER図、テーブル定義）
   - docs/api-spec.md（エンドポイント仕様）
4. **CLAUDE.md更新**: ドメイン知識、技術スタック、開発原則を記載
5. **Issue分解**: docs/breakdown.md にタスク一覧を作成
6. **GitHub Issue作成**: 各タスクをIssueとして登録

## 完了条件

- 上記ドキュメントがすべて生成されている
- GitHub Issueが作成されている
- 「Issue #1から実装を始められます」と案内
