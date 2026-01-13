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
4. **CLAUDE.md生成**: 下記テンプレートを基に、ヒアリング結果を反映して生成
5. **タスク分解**: docs/breakdown.md にタスク一覧を作成

## CLAUDE.md テンプレート

以下のテンプレートをそのままコピーしてCLAUDE.mdを生成する。
- `{{プレースホルダー}}` の部分のみヒアリング結果で置き換える
- それ以外の部分（開発原則、禁止事項、Frontend Design等）は**一字一句そのまま転記**する

```markdown
# {{プロジェクト名}}

## 概要

{{プロジェクトの説明}}

## 技術スタック

{{ヒアリングで決定した技術スタック}}

## コマンド

{{技術スタックに応じたコマンド表}}

## 開発原則

### TDD（テスト駆動開発）

MUST: すべてのコード変更で以下の順序を厳守する
1. **Red** - まずテストを書く（または既存テストを修正する）
2. **Red確認** - テストを実行し、失敗することを確認する
3. **Green** - テストが通る最小限の実装を行う
4. **Refactor** - コードを整理する

NEVER: テストを書く前に実装コードを変更しない
NEVER: テストが失敗することを確認せずに実装に進まない

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
{{技術スタック別の追加禁止事項}}

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
```

### 技術スタック別のコマンド例

**Next.js + Prisma:**
```
| Dev | `npm run dev` |
| Test | `npm test` |
| Build | `npm run build` |
| Lint | `npx biome check --write .` |
| DB Generate | `npx prisma generate` |
| DB Migrate | `npx prisma migrate dev` |
```

**Next.js + FastAPI:**
```
| Frontend Dev | `cd frontend && npm run dev` |
| Frontend Test | `cd frontend && npm test` |
| Backend Dev | `cd backend && uvicorn app.main:app --reload` |
| Backend Test | `cd backend && pytest` |
| Migration | `cd backend && alembic upgrade head` |
```

### 技術スタック別の追加禁止事項

**Next.js + Prisma:**
- クライアントコンポーネントでのDB直接アクセス

**FastAPI:**
- N+1クエリ

## 完了条件

- 上記ドキュメントがすべて生成されている
- docs/breakdown.md にタスク一覧が記載されている
- 「docs/breakdown.md のタスク1から実装を始められます」と案内
