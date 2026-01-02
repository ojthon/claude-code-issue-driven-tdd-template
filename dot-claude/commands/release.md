---
description: リリース準備（CHANGELOG更新、タグ付け）
---

ultrathink リリース $ARGUMENTS の準備を行います。

## フロー

1. **変更履歴の収集**: 前回タグからの変更を確認
2. **CHANGELOG.md更新**: Added/Changed/Fixed形式で追記
3. **バージョン更新**: package.json等を更新（該当する場合）
4. **コミット・タグ付け**: リリースコミットとタグを作成
5. **GitHubリリース作成**: gh release create で公開

## 完了条件

- CHANGELOG.mdが更新されている
- タグがプッシュされている
- GitHubリリースが作成されている
