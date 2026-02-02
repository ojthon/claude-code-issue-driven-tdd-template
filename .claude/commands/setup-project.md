---
description: 新規プロジェクトの初期化
---

新しいプロジェクトを開始します。

## フロー

以下の流れで進めます。各ステップの詳細はClaude Codeに任せてください。

1. **ヒアリング**: プロジェクト概要、ターゲット、主要機能、技術要望を確認
2. **技術スタック選択**: 以下から選択（またはヒアリング結果から判断）
   - `nextjs-only`: Next.js + Prisma（フルスタックWeb）
   - `nextjs-fastapi`: Next.js + FastAPI（Web + Python Backend）
   - `ios-swift`: Swift 6 + SwiftUI（iOSアプリ）
3. **要件定義**: docs/requirements.md を生成
4. **設計**:
   - docs/architecture.md（システム構成、技術スタック）
   - docs/database-schema.md（ER図、テーブル定義）※iOSの場合はSwiftDataスキーマ
   - docs/api-spec.md（エンドポイント仕様）※該当する場合
5. **CLAUDE.md生成**: `project-templates/{{選択したスタック}}/CLAUDE.md` を基に、ヒアリング結果を反映して生成
6. **git hook設定**: commit前・push前の自動チェックを設定
   - 技術スタックに応じて以下から選択：
     - **Node.js単体**: husky + lint-staged
     - **Python単体**: pre-commit
     - **モノレポ（複数言語）**: pre-commit（推奨）またはlefthook
     - **iOS (Swift)**: swiftlint + swiftformat（Xcodeビルドフェーズまたはpre-commit）
   - commit前: lint、format、型チェック
   - push前: テスト実行
7. **タスク分解**: docs/breakdown.md にタスク一覧を作成

## CLAUDE.md テンプレート

選択した技術スタックに応じて、`project-templates/` 内のテンプレートを使用する。
- `project-templates/nextjs-only/CLAUDE.md` - Next.js + Prisma用
- `project-templates/nextjs-fastapi/CLAUDE.md` - Next.js + FastAPI用
- `project-templates/ios-swift/CLAUDE.md` - Swift 6 + SwiftUI用

**テンプレート使用ルール:**
- `{{プレースホルダー}}` の部分のみヒアリング結果で置き換える
- それ以外の部分（開発原則、禁止事項、Frontend Design等）は**一字一句そのまま転記**する

### 汎用テンプレート（参考）

以下は基本構造の参考。実際には上記テンプレートファイルを使用すること。

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

### PLANモード

MUST: 計画策定時は以下を遵守する
- 実装に必要なBash権限を事前に全て洗い出す
- ExitPlanMode時に `allowedPrompts` パラメータで必要な権限を宣言する
- 実行フェーズで追加の権限承認ダイアログが発生しないようにする

## 禁止事項

NEVER: 以下を行ってはならない

- テストを書く前に実装コードを変更すること
- any型の使用
- console.logの残存
- 環境変数のハードコード
- UI/UX作業で /frontend-design スキルを使用しないこと
{{技術スタック別の追加禁止事項}}

## commit/pushルール

NEVER: 以下を行ってはならない
- `--no-verify` フラグの使用
- Lint/Format/型エラーを無視したcommit/push
- エラー回避のためにpre-commit、pre-push、lint-staged、biome.json、pyproject.toml等の設定を変更すること

commit/push時にエラーが発生した場合:
1. エラーを修正
2. 修正をステージ・コミット
3. 再度push

### Lint/Format/型エラーの修正方針

1. **まず自動修正を試す**
   - Frontend: `npm run lint:fix`
   - Backend: `ruff check --fix . && ruff format .`

2. **残ったエラーは手動で対処**
   - 未使用変数 → 削除またはアンダースコアプレフィックス
   - 型エラー → 適切な型注釈を追加

3. **警告の抑制は最後の手段**
   - 正当な理由がある場合のみ `// biome-ignore` や `# noqa` を使用
   - 抑制する場合は理由をコメントで明記

## デプロイルール

CRITICAL: 本番デプロイはユーザーの明示的な指示がある場合のみ実行する

NEVER: 以下を行ってはならない
- ユーザーの明示的な指示なしに本番環境を操作すること
- 本番ブランチで直接作業すること

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

**iOS (Swift 6 + SwiftUI):**
```
| ビルド | Xcode: Cmd+B |
| テスト | `xcodebuild test -scheme {{スキーム名}} -destination 'platform=iOS Simulator,name=iPhone 15 Pro,OS=17.0'` |
| Lint | `swiftlint` |
| フォーマット | `swiftformat .` |
```

### 技術スタック別の追加禁止事項

**Next.js + Prisma:**
- クライアントコンポーネントでのDB直接アクセス

**FastAPI:**
- N+1クエリ

**iOS (Swift 6):**
- Force unwrap (!) の使用
- 暗黙的アンラップ型 (IUO) の使用（IBOutlet以外）
- `nonisolated(unsafe)` の使用
- 新規enumに`.none`ケースを定義すること
- XCTestExpectation の新規使用（async/awaitを使用）
- `@unchecked Sendable` の安易な使用
- APIキーをアプリバイナリに埋め込むこと

## 完了条件

- 上記ドキュメントがすべて生成されている（技術スタックに応じて必要なもの）
  - Webアプリ: requirements.md, architecture.md, database-schema.md, api-spec.md
  - iOSアプリ: requirements.md, architecture.md, database-schema.md（SwiftDataスキーマ）
- CLAUDE.md がテンプレートを基に生成されている
- docs/breakdown.md にタスク一覧が記載されている
- 「docs/breakdown.md のタスク1から実装を始められます」と案内
