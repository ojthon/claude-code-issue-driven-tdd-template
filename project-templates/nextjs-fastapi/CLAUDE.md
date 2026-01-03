# プロジェクト名

## 概要

[プロジェクトの説明]

## 技術スタック

- Frontend: Next.js (App Router), TypeScript, CSS Modules
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

## Frontend Design

Create distinctive frontends that surprise and delight. Avoid generic "AI slop" aesthetics.

### Typography

Choose fonts that are beautiful, unique, and interesting.

**Never use:**
- Inter, Roboto, Arial, Open Sans
- System fonts (sans-serif, system-ui)

**Principles:**
- Select distinctive fonts that elevate the design
- Vary choices between generations - avoid converging on common alternatives
- Pair fonts with high contrast

### Color & Theme

Commit to a cohesive aesthetic.

**Principles:**
- Use CSS variables for consistency
- Dominant colors with sharp accents outperform timid, evenly-distributed palettes
- Draw inspiration from IDE themes, cultural aesthetics, editorial design
- Vary between light and dark themes

**Avoid:**
- Purple gradients on white backgrounds (cliched AI aesthetic)

### Motion

Use animations for effects and micro-interactions.

**Principles:**
- Prioritize CSS-only solutions for HTML
- Use Motion library for React when available
- Focus on high-impact moments: one well-orchestrated page load with staggered reveals (animation-delay) creates more delight than scattered micro-interactions

### Backgrounds

Create atmosphere and depth rather than defaulting to solid colors.

**Techniques:**
- Layer CSS gradients
- Use geometric patterns (dots, lines)
- Create contextual effects matching the overall aesthetic

### Avoid Generic AI Aesthetics

- Overused font families (Inter, Roboto, Arial)
- Cliched color schemes (purple gradients on white)
- Predictable layouts and component patterns
- Cookie-cutter design lacking context-specific character

**Think outside the box.** Make unexpected choices that feel genuinely designed for the context.

## 参照ドキュメント

@docs/requirements.md
@docs/architecture.md
@docs/database-schema.md
@docs/api-spec.md
