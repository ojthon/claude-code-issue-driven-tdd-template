# プロジェクト名

## 概要

[プロジェクトの説明]

## 技術スタック

- Frontend: Next.js 15 (App Router), TypeScript, CSS Modules
- Backend: FastAPI, SQLAlchemy 2.x, Alembic
- DB: PostgreSQL
- Test: Vitest + React Testing Library (Frontend), pytest (Backend)
- Lint: Biome (Frontend), Ruff + Mypy (Backend)

## コマンド

| 操作 | コマンド |
|------|----------|
| Frontend Dev | `cd frontend && npm run dev` |
| Frontend Test | `cd frontend && npm test` |
| Frontend Lint | `cd frontend && npx biome check --write .` |
| Backend Dev | `cd backend && uvicorn app.main:app --reload` |
| Backend Test | `cd backend && pytest` |
| Backend Lint | `cd backend && ruff check --fix . && ruff format .` |
| Backend Type | `cd backend && mypy .` |
| Migration | `cd backend && alembic upgrade head` |

## 開発原則

- TDD (Red -> Green -> Refactor)
- 実装後はreviewerサブエージェントでレビュー（独立コンテキストでバイアス回避）
- PRにはテストが含まれていること

## 禁止事項

- any型の使用
- console.logの残存
- N+1クエリ
- 環境変数のハードコード

## 参照ドキュメント

@docs/requirements.md
@docs/architecture.md
@docs/database-schema.md
@docs/api-spec.md
