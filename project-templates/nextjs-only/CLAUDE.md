# プロジェクト名

## 概要

[プロジェクトの説明]

## 技術スタック

- Framework: Next.js 15 (App Router), TypeScript, CSS Modules
- ORM: Prisma
- DB: PostgreSQL (Vercel Postgres / Supabase / Neon)
- Test: Vitest + React Testing Library
- Lint: Biome

## コマンド

| 操作 | コマンド |
|------|----------|
| Dev | `npm run dev` |
| Test | `npm test` |
| Build | `npm run build` |
| Lint | `npx biome check --write .` |
| DB Generate | `npx prisma generate` |
| DB Migrate | `npx prisma migrate dev` |
| DB Studio | `npx prisma studio` |

## 開発原則

- TDD (Red -> Green -> Refactor)
- 実装後はreviewerサブエージェントでレビュー（独立コンテキストでバイアス回避）
- PRにはテストが含まれていること
- Server ActionsでDB操作

## 禁止事項

- any型の使用
- console.logの残存
- 環境変数のハードコード
- クライアントコンポーネントでのDB直接アクセス

## 参照ドキュメント

@docs/requirements.md
@docs/architecture.md
@docs/database-schema.md
@docs/api-spec.md
