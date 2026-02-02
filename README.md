# claude-code-issue-driven-tdd-template

Claude Codeの自律性を活かしたIssue駆動・TDD開発テンプレート。

---

## クイックスタート

### グローバルインストール（推奨）

```bash
git clone https://github.com/YOUR_USERNAME/claude-code-issue-driven-tdd-template.git
cd claude-code-issue-driven-tdd-template

# ~/.claude/ にインストール
./scripts/setup.sh --global

# 任意のプロジェクトで開発開始
cd ~/your-project
claude
/setup-project
```

### プロジェクト単位でインストール

```bash
cd your-project
/path/to/claude-code-issue-driven-tdd-template/scripts/setup.sh [nextjs-fastapi|nextjs-only]
```

---

## 構成

```
claude-code-issue-driven-tdd-template/
├── dot-claude/
│   ├── commands/
│   │   └── setup-project.md   # プロジェクト初期化
│   └── agents/
│       └── reviewer.md        # コードレビュー（独立コンテキスト）
├── project-templates/
│   ├── nextjs-fastapi/        # Next.js + FastAPI
│   └── nextjs-only/           # Next.js のみ
├── docs/                      # ドキュメントテンプレート
└── scripts/
    └── setup.sh
```

---

## 開発フロー

```
【初期フェーズ】
/setup-project
  → ヒアリング → 要件定義 → 設計 → Issue分解 → GitHub Issue作成
  → 「Issue #1から実装を始められます」

【実装フェーズ】通常会話で自律実行
「Issue #1を実装して」
  → 調査 → TDD実装 → reviewerでレビュー → PR作成
  → ユーザーがマージ

「Issue #2を実装して」
  → ...繰り返し...
```

---

## コマンド一覧

| コマンド | 説明 |
|----------|------|
| `/setup-project` | 新規プロジェクト初期化（ヒアリング→設計→Issue作成） |

### エージェント

| 呼び出し方 | 説明 |
|------------|------|
| `reviewerでレビューして` | 独立コンテキストでコードレビュー（修正禁止） |

---

## 設計思想

### 最小限の指示、最大限の自律性

- **コマンドはフローを示すだけ**。手順の詳細はClaude Codeに任せる
- **実装フェーズはコマンド不要**。通常会話で「Issue #Xを実装して」と依頼
- **原則はCLAUDE.mdに記載**。TDD、レビュー、禁止事項など

### 独立コンテキストでのレビュー

`reviewer`エージェントは独立したコンテキストで動作するため、実装時のバイアスを回避できる。

---

## CLAUDE.mdテンプレート

| テンプレート | 構成 |
|-------------|------|
| `nextjs-fastapi` | Next.js 15 + FastAPI + PostgreSQL |
| `nextjs-only` | Next.js 15 + Prisma + PostgreSQL |

### 含まれる内容

- 技術スタック
- コマンド一覧
- 開発原則（TDD、レビュー）
- 禁止事項
- 参照ドキュメント

---

## ライセンス

MIT License
