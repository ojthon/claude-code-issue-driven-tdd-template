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

### TDD（テスト駆動開発）

MUST: すべてのコード変更で以下の順序を厳守する
1. **Red** - まずテストを書く（または既存テストを修正する）
2. **Red確認** - テストを実行し、失敗することを確認する
3. **Green** - テストが通る最小限の実装を行う
4. **Refactor** - コードを整理する

NEVER: テストを書く前に実装コードを変更しない
NEVER: テストが失敗することを確認せずに実装に進まない

### テスト実行時の注意事項

CRITICAL: テストプロセス多重起動・残存問題を防ぐため、以下を**必ず**遵守すること

#### 実行前（必須）
```bash
# 残存プロセスの確認と終了（毎回実行）
pgrep -f vitest && pkill -f vitest || true
pgrep -f pytest && pkill -f pytest || true
```

#### テスト実行ルール

NEVER: 以下を行ってはならない
- `vitest`（watchモード）を単独実行すること → 必ず `vitest run` を使用
- `npm run test:watch` を実行すること
- バックグラウンドでテストを実行すること（`&`や`run_in_background`を使用しない）
- 前のテストの完了を待たずに次のテストを実行すること

MUST: 以下を遵守すること
1. **特定ファイルのみテスト**（デフォルト）
   ```bash
   npm run test -- src/path/to/specific.test.tsx
   pytest tests/test_specific.py
   ```
2. **全テスト実行時はタイムアウト付き**
   ```bash
   timeout 120 npm run test
   timeout 120 pytest
   ```
3. **テスト完了後のプロセス確認**
   ```bash
   pgrep -f vitest && pkill -f vitest || true
   pgrep -f pytest && pkill -f pytest || true
   ```

#### テスト失敗・中断時
テストが失敗または中断した場合、次のテスト実行前に必ず残存プロセスを終了：
```bash
pkill -f vitest || true
pkill -f pytest || true
sleep 1
```

### レビュー

MUST: 実装完了後はreviewerサブエージェントでレビューを行う
- 独立コンテキストでバイアスを回避する

### フロントエンド

MUST: UI/UXのデザイン検討・設計・実装時は /frontend-design スキルを使用する

## 禁止事項

NEVER: 以下を行ってはならない

- テストを書く前に実装コードを変更すること
- any型の使用
- console.logの残存
- 環境変数のハードコード
- UI/UX作業で /frontend-design スキルを使用しないこと
- N+1クエリ

## Frontend Design

MUST: このセクションの内容に従ってフロントエンドを実装する

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
@docs/breakdown.md
