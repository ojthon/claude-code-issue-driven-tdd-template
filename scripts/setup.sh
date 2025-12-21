#!/bin/bash
# setup.sh - Claude Code Issue-Driven TDD 開発環境セットアップスクリプト
#
# 使い方:
#   # プロジェクトにインストール（./.claude/）
#   cd /path/to/your-project
#   /path/to/claude-code-issue-driven-tdd-template/scripts/setup.sh [template]
#
#   # グローバルにインストール（~/.claude/）
#   /path/to/claude-code-issue-driven-tdd-template/scripts/setup.sh --global
#
# オプション:
#   --global        ~/.claude/ にインストール（テンプレートはコピーしない）
#
# テンプレート（プロジェクトインストール時のみ）:
#   nextjs-fastapi  - Next.js + FastAPI 構成（デフォルト）
#   nextjs-only     - Next.js のみの構成

set -e

# スクリプトのディレクトリを取得
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_ROOT="$(dirname "$SCRIPT_DIR")"

# 色付き出力
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# オプション解析
GLOBAL_INSTALL=false
TEMPLATE="nextjs-fastapi"

for arg in "$@"; do
    case $arg in
        --global)
            GLOBAL_INSTALL=true
            shift
            ;;
        *)
            TEMPLATE="$arg"
            shift
            ;;
    esac
done

# インストール先の決定
if [ "$GLOBAL_INSTALL" = true ]; then
    TARGET_DIR="$HOME/.claude"
    echo -e "${BLUE}🚀 Claude Code コマンドをグローバルにインストールします...${NC}"
    echo -e "${BLUE}   インストール先: ~/.claude/${NC}"
else
    TARGET_DIR=".claude"
    echo -e "${BLUE}🚀 Claude Code Issue-Driven TDD 開発環境をセットアップします...${NC}"
    echo -e "${BLUE}   インストール先: ./.claude/${NC}"
fi

echo ""

# プロジェクトインストールの場合、Gitリポジトリを確認
if [ "$GLOBAL_INSTALL" = false ]; then
    if [ ! -d ".git" ]; then
        echo -e "${YELLOW}⚠️  Gitリポジトリが見つかりません。初期化しますか？ (y/n)${NC}"
        read -r answer
        if [ "$answer" = "y" ]; then
            git init
            echo -e "${GREEN}✅ Gitリポジトリを初期化しました${NC}"
        fi
    fi
fi

# ディレクトリ作成
echo -e "${BLUE}📁 ディレクトリを作成中...${NC}"
mkdir -p "$TARGET_DIR/commands"
mkdir -p "$TARGET_DIR/agents"

if [ "$GLOBAL_INSTALL" = false ]; then
    mkdir -p docs
fi

# Slashコマンドをコピー
echo -e "${BLUE}📝 Slashコマンドをコピー中...${NC}"
cp "$TEMPLATE_ROOT/dot-claude/commands/"*.md "$TARGET_DIR/commands/"
echo -e "${GREEN}   ✅ 14個のSlashコマンドをコピーしました${NC}"

# サブエージェントをコピー
echo -e "${BLUE}🤖 サブエージェントをコピー中...${NC}"
cp "$TEMPLATE_ROOT/dot-claude/agents/"*.md "$TARGET_DIR/agents/"
echo -e "${GREEN}   ✅ reviewerサブエージェントをコピーしました${NC}"

# プロジェクトインストールの場合のみ、テンプレートとドキュメントをコピー
if [ "$GLOBAL_INSTALL" = false ]; then
    # CLAUDE.mdテンプレートをコピー
    echo -e "${BLUE}📄 CLAUDE.mdテンプレートをコピー中...${NC}"
    if [ -f "$TEMPLATE_ROOT/project-templates/$TEMPLATE/CLAUDE.md" ]; then
        cp "$TEMPLATE_ROOT/project-templates/$TEMPLATE/CLAUDE.md" ./CLAUDE.md
        echo -e "${GREEN}   ✅ $TEMPLATE テンプレートをコピーしました${NC}"
    else
        echo -e "${YELLOW}   ⚠️  テンプレート '$TEMPLATE' が見つかりません。利用可能: nextjs-fastapi, nextjs-only${NC}"
    fi

    # ドキュメントテンプレートをコピー
    echo -e "${BLUE}📚 ドキュメントテンプレートをコピー中...${NC}"
    cp "$TEMPLATE_ROOT/docs/"*.template.md docs/
    # .template を除去してリネーム
    for f in docs/*.template.md; do
        mv "$f" "${f%.template.md}.md"
    done
    echo -e "${GREEN}   ✅ 5つのドキュメントテンプレートをコピーしました${NC}"

    # .gitignore更新
    if ! grep -q ".claude/settings.local.json" .gitignore 2>/dev/null; then
        echo ".claude/settings.local.json" >> .gitignore
        echo -e "${GREEN}   ✅ .gitignoreを更新しました${NC}"
    fi
fi

echo ""
echo -e "${GREEN}🎉 セットアップ完了！${NC}"
echo ""

if [ "$GLOBAL_INSTALL" = true ]; then
    echo -e "${BLUE}インストールされたファイル:${NC}"
    echo "  ~/.claude/commands/  - 14個のSlashコマンド"
    echo "  ~/.claude/agents/    - reviewerサブエージェント"
    echo ""
    echo -e "${BLUE}次のステップ:${NC}"
    echo "  1. Claude Codeで以下を実行してプラグインをインストール:"
    echo "     /plugin marketplace add anthropics/claude-code-plugins"
    echo "     /plugin install frontend-design@anthropics"
    echo "     /plugin install security-guidance@anthropics"
    echo "  2. 任意のプロジェクトで /init を実行"
    echo ""
    echo -e "${YELLOW}注意:${NC}"
    echo "  グローバルインストールでは、CLAUDE.mdとdocs/は"
    echo "  各プロジェクトで /init → /requirements → /design の"
    echo "  流れで自動生成されます。"
else
    echo -e "${BLUE}作成されたファイル:${NC}"
    echo "  .claude/commands/    - 14個のSlashコマンド"
    echo "  .claude/agents/      - reviewerサブエージェント"
    echo "  CLAUDE.md            - プロジェクト設定（要編集）"
    echo "  docs/                - 設計ドキュメントテンプレート"
    echo ""
    echo -e "${BLUE}次のステップ:${NC}"
    echo "  1. CLAUDE.md をプロジェクトに合わせて編集"
    echo "  2. Claude Codeで以下を実行してプラグインをインストール:"
    echo "     /plugin marketplace add anthropics/claude-code-plugins"
    echo "     /plugin install frontend-design@anthropics"
    echo "     /plugin install security-guidance@anthropics"
    echo "  3. /init でプロジェクトを開始"
fi

echo ""
echo -e "${BLUE}開発フロー:${NC}"
echo "  企画・設計: /init → /requirements → /design → /breakdown → /clear"
echo "  開発:       /new-issue #1 → /issue → /research → /plan"
echo "              → Issueにコメント保存 → ブランチ作成 → /clear"
echo "              /test ⇄ /impl → reviewerでレビュー → /pr → /merge → /clear"
echo "  リリース:   /release v1.0.0"
echo ""
echo -e "${BLUE}命名規則:${NC}"
echo "  ブランチ: [種別]/issue_[番号]  例: infra/issue_1"
echo "  PR:       [種別] #[番号]: [説明]  例: infra #1: 初期化"
