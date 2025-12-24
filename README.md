# claude-code-issue-driven-tdd-template

A transparent, command-driven development workflow for Claude Code. Issue-driven + TDD with 12 Slash commands + 1 subagent. Understand every step, customize everything.

---

## クイックスタート

### グローバルインストール（推奨）

```bash
# リポジトリをクローン
git clone https://github.com/YOUR_USERNAME/claude-code-issue-driven-tdd-template.git
cd claude-code-issue-driven-tdd-template

# ~/.claude/ にインストール
./scripts/setup.sh --global

# 任意のプロジェクトで開発開始
cd ~/your-project
claude
/init
```

### プロジェクト単位でインストール

```bash
# プロジェクトディレクトリで実行
cd your-project
/path/to/claude-code-issue-driven-tdd-template/scripts/setup.sh

# テンプレート指定（オプション）
/path/to/scripts/setup.sh nextjs-only
```

### 公式プラグインのインストール

```bash
claude
/plugin marketplace add anthropics/claude-code-plugins
/plugin install frontend-design@anthropics
/plugin install security-guidance@anthropics
```

---

## 構成

```
claude-code-issue-driven-tdd-template/
├── dot-claude/              # → .claude/ にコピー
│   ├── commands/            # 12個のSlashコマンド
│   └── agents/              # reviewerサブエージェント
├── project-templates/       # → プロジェクトルートに配置
│   ├── nextjs-fastapi/      # Next.js + FastAPI 構成
│   └── nextjs-only/         # Next.js のみ構成
├── docs/                    # ドキュメントテンプレート
└── scripts/
    └── setup.sh             # セットアップスクリプト
```

---

## コマンド一覧

### 企画・設計フェーズ

| コマンド | 説明 |
|----------|------|
| `/init` | プロジェクト初期化・ヒアリング |
| `/requirements` | 要件定義ドキュメント生成 |
| `/design` | アーキテクチャ・DB・API設計 |
| `/breakdown` | 設計からIssueへのブレイクダウン |

### 開発フェーズ

| コマンド | 説明 |
|----------|------|
| `/new-issue` | GitHub Issue作成 |
| `/issue [番号]` | Issue内容確認 |
| `/research [番号]` | 実装のためのコードベース調査 |
| `/plan [内容]` | 実装計画・テストケース設計 |
| `/test [対象]` | テスト作成（TDD Red） |
| `/impl [対象]` | 実装（TDD Green→Refactor） |
| `/pr [Issue番号]` | PR作成 |
| `/merge` | PRマージ |

### リリースフェーズ

| コマンド | 説明 |
|----------|------|
| `/release [バージョン]` | CHANGELOG更新・タグ付け・リリース |

### サブエージェント

| 呼び出し方 | 説明 |
|------------|------|
| `reviewerでレビューして` | コードレビュー専門。CLAUDE.md・設計ドキュメント準拠・品質・セキュリティ・パフォーマンス観点で分析 |

---

## 開発フロー

```
企画・設計（メインディレクトリ）:
  /init → /requirements → /design → /breakdown → /clear

開発（繰り返し・並列可能）:
  準備:   /new-issue #1（→breakdown更新）→ /issue → /research
  計画:   → /plan（→Issueコメント保存、worktree作成）

  ─── 新ターミナルでworktreeに移動 → claude → /clear ───

  実装:   /test ⇄ /impl（TDDサイクル）⚠️ /clear しない
  完了:   → reviewerでレビュー ⇄ 修正（ループ）
          → /pr（→breakdown更新）→ /merge（→breakdown更新、worktree削除）

リリース（メインディレクトリ）:
  /release v1.0.0
```

### 並列開発（git worktree）

複数のIssueを同時に開発できます：

```bash
# メインディレクトリで各Issueのworktreeを作成
/plan  # → .worktrees/issue_1 を作成
/plan  # → .worktrees/issue_2 を作成

# 各worktreeで別々のターミナル・Claude Codeセッションを起動
Terminal 1: cd .worktrees/issue_1 && claude
Terminal 2: cd .worktrees/issue_2 && claude
```

**利点**:
- 各エージェントが独立したブランチで作業
- ブランチ切り替えの競合が発生しない
- breakdown.md は各タスクの担当セクションのみ編集

**注意**: `.gitignore` に `.worktrees/` を追加してください。

### ブランチ・PR命名規則
- **ブランチ**: `[種別]-issue_[番号]` （例: `infra-issue_1`, `api-issue_5`）
- **PRタイトル**: `[種別] #[番号]: [説明]` （例: `infra #1: プロジェクト初期化`）
- **Worktree**: `.worktrees/issue_[番号]`

---

## CLAUDE.mdテンプレート

プロジェクト固有の設定を記述するファイルです。以下のテンプレートから選択できます：

| テンプレート | 構成 |
|-------------|------|
| `nextjs-fastapi` | Next.js 15 + FastAPI + PostgreSQL（デフォルト） |
| `nextjs-only` | Next.js 15 + Prisma + PostgreSQL |

### CLAUDE.mdに含まれる内容

- **ドメイン知識**: 用語集、ビジネスルール
- **技術スタック**: フレームワーク、テスト、インフラ
- **ディレクトリ構造**: ファイル配置ルール
- **コマンド**: 開発・テスト・ビルドコマンド
- **開発ルール**: コーディング規約、エラーハンドリング方針、禁止事項
- **参照ドキュメント**: `@docs/xxx.md` 形式で設計ドキュメントを参照

---

## setup.sh オプション

```bash
# グローバルインストール
./scripts/setup.sh --global

# プロジェクトインストール（デフォルト: nextjs-fastapi）
./scripts/setup.sh

# テンプレート指定
./scripts/setup.sh nextjs-only
```

| オプション | インストール先 | コピーされるもの |
|-----------|---------------|-----------------|
| `--global` | `~/.claude/` | commands/, agents/ |
| なし | `./.claude/` | commands/, agents/, CLAUDE.md, docs/ |

---

## なぜ自作コマンドか

公式プラグイン（`feature-dev`等）もありますが、このテンプレートは自作コマンドを採用しています。

| 観点 | 公式プラグイン | このテンプレート |
|------|---------------|-----------------|
| セットアップ | 1コマンド | setup.sh実行 |
| 透明性 | ブラックボックス | 全ステップが明確 |
| カスタマイズ | 困難 | 自由に編集可能 |
| TDD対応 | なし | Red→Green→Refactor |
| Issue連携 | なし | GitHub Issue駆動 |

---

## ライセンス

MIT License
