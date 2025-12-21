---
description: リリース準備（CHANGELOG更新、タグ付け）
---

リリースの準備を行います。

## 入力
$ARGUMENTS
（バージョン番号: 例 v1.0.0）

## 手順

### 1. 変更履歴の収集
```bash
git log --oneline $(git describe --tags --abbrev=0)..HEAD
```

### 2. CHANGELOG.md更新
以下の形式で追記：

```markdown
## [$ARGUMENTS] - [日付]

### Added
- [新機能]

### Changed
- [変更]

### Fixed
- [バグ修正]
```

### 3. バージョン更新（該当する場合）
- package.json
- pyproject.toml
- その他バージョン管理ファイル

### 4. コミット
```bash
git add -A
git commit -m "chore: release $ARGUMENTS"
```

### 5. タグ付け
```bash
git tag -a $ARGUMENTS -m "Release $ARGUMENTS"
git push origin main --tags
```

### 6. GitHubリリース作成
```bash
gh release create $ARGUMENTS --title "$ARGUMENTS" --notes-file CHANGELOG.md
```

## 注意
- mainブランチで実行すること
- すべてのテストがパスしていることを確認

---

## 次のステップ

リリース完了です。お疲れさまでした。

次のイテレーションを開始する場合は `/init` または `/requirements` から始めてください。
