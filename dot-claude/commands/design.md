---
description: アーキテクチャ・DB・API設計ドキュメントを生成
---

要件定義をもとに設計ドキュメントを作成します。

## 入力
$ARGUMENTS
（技術スタックの指定、設計上の要望など）

## 参照
@docs/requirements.md

## 技術スタック選定ガイドライン

**重要**: 技術スタックを決定する際は、必ず各公式サイトで最新の安定バージョンを確認してください。AIの学習データは古い可能性があります。

### バージョン確認方法
Web検索で以下を確認してから設計してください：

| 技術 | 確認先 |
|------|--------|
| Next.js | https://nextjs.org/docs - 最新App Router版を使用 |
| React | https://react.dev - Next.jsとの互換性を確認 |
| TypeScript | https://www.typescriptlang.org - strict mode推奨 |
| Tailwind CSS | https://tailwindcss.com - 最新メジャーバージョン |
| Python | https://www.python.org - 最新の安定版 |
| FastAPI | https://fastapi.tiangolo.com - 最新版 |
| Node.js | https://nodejs.org - 最新LTS版 |
| PostgreSQL | https://www.postgresql.org - 最新の安定版 |

### 推奨ツール（2025年時点のベストプラクティス）

| 用途 | 推奨ツール | 理由 | 非推奨 |
|------|-----------|------|--------|
| JS/TS Linter + Formatter | **Biome** | 高速、設定簡単、1ツールで完結 | ESLint + Prettier（遅い、設定複雑） |
| Python Linter + Formatter | **Ruff** | 非常に高速、Black/isort/Flake8の代替 | Black + isort + Flake8（遅い、複数ツール） |
| フロントエンドテスト | **Vitest** | Jest互換、高速、ESM対応 | Jest（遅い） |
| E2Eテスト | **Playwright** | 高速、信頼性高い | Cypress（遅い） |
| ORM (Node.js) | **Prisma** or **Drizzle** | 型安全、DX良い | - |
| ORM (Python) | **SQLAlchemy 2.x** | 2.0スタイル推奨 | SQLAlchemy 1.x スタイル |

### 注意事項
- ユーザーの要望や既存プロジェクトの制約を優先
- 新規プロジェクトでは上記推奨ツールを提案
- 既存プロジェクトへの導入時は移行コストを考慮

## 生成するドキュメント

### 1. docs/architecture.md
```markdown
# アーキテクチャ設計書

## 1. システム構成図
[Mermaidで図示]

## 2. 技術スタック
### フロントエンド
### バックエンド
### インフラ

## 3. ディレクトリ構造

## 4. 主要コンポーネント
### [コンポーネント名]
- 責務:
- 依存:

## 5. データフロー

## 6. セキュリティ設計
### 認証・認可
### データ保護

## 7. エラーハンドリング方針
```

### 2. docs/database-schema.md
```markdown
# データベース設計書

## ER図
[Mermaidで図示]

## テーブル定義

### [テーブル名]
| カラム | 型 | 制約 | 説明 |
|--------|-----|------|------|

## インデックス

## マイグレーション方針
```

### 3. docs/api-spec.md
```markdown
# API仕様書

## 概要
- ベースURL:
- 認証方式:

## エンドポイント一覧
| メソッド | パス | 説明 |
|----------|------|------|

## 詳細

### [エンドポイント名]
- メソッド:
- パス:
- 認証:
- リクエスト:
- レスポンス:
- エラー:
```

## 手順
1. requirements.mdを参照
2. 技術スタックを決定
3. 各設計ドキュメントを生成
4. CLAUDE.mdを生成/更新

## CLAUDE.md更新
設計完了後、以下をCLAUDE.mdに反映：
- ドメイン知識（requirements.mdから）
- 技術スタック
- ディレクトリ構造
- コマンド
- 参照ドキュメント

---
完了したら `/clear` して開発フェーズに進みます。
