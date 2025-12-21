# プロジェクト名

## 概要
[プロジェクトの説明]

## ドメイン知識

### 用語集
| 用語 | 説明 |
|------|------|
| [用語1] | [説明] |
| [用語2] | [説明] |

### ビジネスルール
- [ルール1]
- [ルール2]

## 技術スタック

**注意**: バージョンは公式サイトで最新の安定版を確認してください。

### フロントエンド
- Next.js (App Router) - https://nextjs.org
- TypeScript (strict mode) - https://www.typescriptlang.org
- Tailwind CSS - https://tailwindcss.com
- React Hook Form + Zod

### バックエンド
- FastAPI - https://fastapi.tiangolo.com
- Python (最新安定版) - https://www.python.org
- SQLAlchemy 2.x + Alembic
- PostgreSQL - https://www.postgresql.org

### Linter・フォーマッター
- フロントエンド: Biome（ESLint + Prettierの代替、高速）
- バックエンド: Ruff（Black + isort + Flake8の代替、高速）

### テスト
- フロントエンド: Vitest + React Testing Library
- バックエンド: pytest

### インフラ
- Vercel (フロントエンド)
- Cloud Run (バックエンド)
- Cloud SQL (PostgreSQL)

## ディレクトリ構造

```
frontend/
├── src/
│   ├── app/           # App Router
│   ├── components/    # UIコンポーネント
│   │   ├── ui/        # 汎用UI
│   │   └── features/  # 機能別
│   ├── hooks/         # カスタムフック
│   ├── lib/           # ユーティリティ
│   └── types/         # 型定義
└── tests/             # テスト

backend/
├── app/
│   ├── api/           # エンドポイント
│   ├── models/        # SQLAlchemyモデル
│   ├── schemas/       # Pydanticスキーマ
│   ├── services/      # ビジネスロジック
│   └── core/          # 設定、依存性
└── tests/             # テスト
```

## コマンド

### フロントエンド
| 操作 | コマンド |
|------|----------|
| 開発サーバー | `cd frontend && npm run dev` |
| テスト | `cd frontend && npm test` |
| ビルド | `cd frontend && npm run build` |
| Lint + Format | `cd frontend && npx biome check --write .` |

### バックエンド
| 操作 | コマンド |
|------|----------|
| 開発サーバー | `cd backend && uvicorn app.main:app --reload` |
| テスト | `cd backend && pytest` |
| マイグレーション | `cd backend && alembic upgrade head` |
| Lint + Format | `cd backend && ruff check --fix . && ruff format .` |

## 開発ルール

### コーディング規約

#### フロントエンド
- コンポーネントは関数コンポーネント + TypeScript
- スタイルはTailwind CSS
- 状態管理は原則React Hook Form + useReducer

#### バックエンド
- 型ヒント必須
- Pydanticでバリデーション
- サービス層でビジネスロジック

### エラーハンドリング方針

#### フロントエンド
- API呼び出しはtry-catchで囲む
- ユーザーへのエラー表示は日本語で具体的に
- 予期しないエラーはエラーバウンダリでキャッチ

#### バックエンド
- HTTPExceptionで適切なステータスコードを返す
- バリデーションエラーは422で詳細を含める
- 予期しないエラーは500 + ログ出力

#### 外部サービス連携
- タイムアウト: 10秒
- リトライ: 3回（指数バックオフ）
- サーキットブレーカー: 5回失敗で開放

### 禁止事項
- any型の使用（TypeScript）
- console.logの本番コードへの残存
- 環境変数のハードコード
- N+1クエリ

## 参照ドキュメント
@docs/requirements.md
@docs/architecture.md
@docs/database-schema.md
@docs/api-spec.md
