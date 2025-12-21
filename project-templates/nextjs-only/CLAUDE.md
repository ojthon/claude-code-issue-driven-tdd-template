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

### フレームワーク・言語
- Next.js (App Router) - https://nextjs.org
- TypeScript (strict mode) - https://www.typescriptlang.org
- Tailwind CSS - https://tailwindcss.com
- Prisma - https://www.prisma.io
- PostgreSQL - https://www.postgresql.org
- React Hook Form + Zod

### Linter・フォーマッター
- Biome（ESLint + Prettierの代替、高速）

### テスト
- Vitest + React Testing Library

### インフラ
- Vercel
- Vercel Postgres / Supabase / Neon

## ディレクトリ構造

```
src/
├── app/              # App Router
│   ├── (auth)/       # 認証関連ページ
│   ├── (main)/       # メインページ
│   ├── api/          # API Routes
│   └── actions/      # Server Actions
├── components/       # UIコンポーネント
│   ├── ui/           # 汎用UI
│   └── features/     # 機能別
├── hooks/            # カスタムフック
├── lib/              # ユーティリティ
│   ├── prisma.ts     # Prismaクライアント
│   └── utils.ts      # 汎用関数
└── types/            # 型定義

prisma/
├── schema.prisma     # スキーマ定義
└── migrations/       # マイグレーション

tests/                # テスト
```

## コマンド

| 操作 | コマンド |
|------|----------|
| 開発サーバー | `npm run dev` |
| テスト | `npm test` |
| ビルド | `npm run build` |
| Lint + Format | `npx biome check --write .` |
| DB生成 | `npx prisma generate` |
| DBマイグレーション | `npx prisma migrate dev` |
| DB確認 | `npx prisma studio` |

## 開発ルール

### コーディング規約
- コンポーネントは関数コンポーネント + TypeScript
- Server ActionsでDB操作
- スタイルはTailwind CSS
- フォームはReact Hook Form + Zod

### エラーハンドリング方針
- Server Actionsはtry-catchで囲み、エラーオブジェクトを返す
- ユーザーへのエラー表示は日本語で具体的なアクションを示す
- 予期しないエラーはerror.tsxでキャッチ

### 禁止事項
- any型の使用
- console.logの本番コードへの残存
- 環境変数のハードコード
- クライアントコンポーネントでのDB直接アクセス

## 参照ドキュメント
@docs/requirements.md
@docs/architecture.md
@docs/database-schema.md
@docs/api-spec.md
