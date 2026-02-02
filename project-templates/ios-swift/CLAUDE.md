# {{プロジェクト名}}

## 概要

{{プロジェクトの説明}}

## 技術スタック

- 言語: Swift 6.0+
- UI: SwiftUI (iOS 17+)
- DB: SwiftData
- グラフ: Swift Charts
- 課金: StoreKit 2
- 認証: Sign in with Apple
- 最小OS: iOS 17.0
- Lint: SwiftLint
- Format: SwiftFormat

{{バックエンドがある場合は追加}}

## コマンド

| 用途 | コマンド |
|------|---------|
| ビルド | Xcode: Cmd+B |
| テスト | `xcodebuild test -scheme {{スキーム名}} -destination 'platform=iOS Simulator,name=iPhone 15 Pro,OS=17.0'` |
| Lint | `swiftlint` |
| Format | `swiftformat .` |

{{バックエンドがある場合はコマンドを追加}}

## 開発原則

### TDD（テスト駆動開発）

MUST: すべてのコード変更で以下の順序を厳守
1. **Red** - テストを書く
2. **Red確認** - テスト失敗を確認
3. **Green** - 最小限の実装
4. **Refactor** - 整理

NEVER: テストを書く前に実装コードを変更しない

### テスト実行時の注意事項

#### 実行前（必須）
```bash
xcrun simctl shutdown all
```

#### テスト実行
```bash
# 特定テスト
xcodebuild test -scheme {{スキーム名}} \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro,OS=17.0' \
  -only-testing:{{テストターゲット名}}/テストクラス名

# 全テスト
timeout 300 xcodebuild test -scheme {{スキーム名}} \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro,OS=17.0'
```

#### トラブルシューティング
```bash
xcrun simctl erase "iPhone 15 Pro"
rm -rf ~/Library/Developer/Xcode/DerivedData/{{プロジェクト名}}-*
```

### レビュー

MUST: 実装完了後はreviewerサブエージェントでレビューを行う

### フロントエンド

MUST: UI/UXのデザイン検討・設計・実装時は /frontend-design スキルを使用する

### PLANモード

MUST: 計画策定時は以下を遵守
- 実装に必要なBash権限を事前に全て洗い出す
- ExitPlanMode時に `allowedPrompts` パラメータで必要な権限を宣言する

## Swift 6 並行処理

CRITICAL: Strict Concurrency準拠必須

### Sendable
```swift
// ❌ class MutableData: Sendable { var items: [String] = [] }
// ✅ struct UserProfile: Sendable { let id: UUID; let name: String }
```
NEVER: `@unchecked Sendable`を安易に使用しない

### Actor
```swift
// ❌ var globalCache: [String: Data] = [:]
// ✅ actor DataStore { private var cache: [String: Data] = [:] }
```

### @MainActor
```swift
// ✅ @MainActor @Observable class ProfileViewModel { var isLoading = false }
```
NEVER: バックグラウンド処理を@MainActorで実行しない

### Task
```swift
// ❌ Task { let result = try await api.fetch() }
// ✅ Task { do { let result = try await api.fetch(); await MainActor.run { self.data = result } } catch { ... } }
```

### @Sendableクロージャ
```swift
// ❌ func process(completion: @escaping () -> Void)
// ✅ func process(completion: @Sendable @escaping () -> Void)
```

### グローバル変数
```swift
// ❌ var globalConfig: Config = .default
// ✅ let globalConfig: Config = .default
// ✅ @MainActor var appState: AppState = .initial
```

### @preconcurrency
```swift
@preconcurrency import SomeThirdPartyLibrary
```
NEVER: 新規コードで使用しない（移行用のみ）

## Swift 6 テスト

### Enum `.none`ケース
```swift
// ❌ SomeType.method(MyEnum.none)  // Optional.noneと曖昧
// ✅ let value: MyEnum = .none; SomeType.method(value)
```
NEVER: 新規enumに`.none`を定義しない（`.notSet`、`.unspecified`を使用）

### SwiftDataテスト

CRITICAL: 並列実行を無効化（Xcodeスキーム → Test → Options → `Execute in parallel` OFF）

```swift
@MainActor
final class DataServiceTests: XCTestCase {
    private var modelContainer: ModelContainer!
    private var modelContext: ModelContext!

    override func setUp() {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        modelContainer = try! ModelContainer(for: MyModel.self, configurations: config)
        modelContext = ModelContext(modelContainer)
        modelContext.autosaveEnabled = false
    }
}
```

MUST: ソート順テストでは二次ソートキーを含める

### シミュレータ制限
```swift
#if targetEnvironment(simulator)
throw XCTSkip("シミュレータ非対応")
#endif
```
対象: アプリアイコン変更、プッシュ通知、カメラ、HealthKit、StoreKit、Face ID

### モック
```swift
// ❌ MockURLProtocol.lastRequest!
// ✅ var capturedRequest: URLRequest?; MockURLProtocol.requestHandler = { request in capturedRequest = request; ... }
```
NEVER: `nonisolated(unsafe)`を使用しない

### @MainActorテストクラス
MUST: SwiftUIビュー、`@Observable`型、`@MainActor`コードのテストに付与

### async/awaitテスト
```swift
@MainActor
final class ServiceTests: XCTestCase {
    func testAsync() async throws {
        let result = try await sut.perform()
        XCTAssertEqual(result, expected)
    }
}
```
NEVER: `XCTestExpectation`/`waitForExpectations`を新規テストで使用しない
MUST: レガシーAPI対応時は`await fulfillment(of:timeout:)`を使用

### テストフレームワーク
MUST: XCTestを使用

## Xcodeプロジェクト管理

CRITICAL: Swiftファイル作成後は必ずビルド確認
```bash
rm -rf ~/Library/Developer/Xcode/DerivedData/{{プロジェクト名}}-*
xcodebuild build -project {{プロジェクト名}}.xcodeproj -scheme {{スキーム名}} \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro,OS=17.0'
```

## 禁止事項

NEVER:
- テストを書く前に実装コードを変更
- Force unwrap (!)
- 暗黙的アンラップ型 (IUO)（IBOutlet以外）
- APIキーをアプリバイナリに埋め込む
- `nonisolated(unsafe)`
- 新規enumに`.none`ケース
- `XCTestExpectation`の新規使用
- `@unchecked Sendable`の安易な使用
- /frontend-design スキル未使用でUI/UX作業
- `print()`デバッグの残存

## commit/pushルール

NEVER:
- `--no-verify`フラグ
- Lint/Format/型エラーを無視
- エラー回避のためswiftlint/swiftformat設定を変更

### Lint/Format修正方針
```bash
# 自動修正
swiftlint --fix && swiftformat .
```
- 未使用変数 → 削除または`_`プレフィックス
- 警告抑制（`// swiftlint:disable`）は最後の手段、理由を明記

## デプロイルール

CRITICAL: App Store提出はユーザーの明示的な指示がある場合のみ

## Frontend Design

MUST: このセクションに従ってSwiftUIを実装

### Typography
- システムフォント + セマンティックスタイル（`.title`、`.headline`、`.body`）
- Dynamic Type対応必須

### Color & Theme
```swift
extension Color {
    static let appBackground = Color("AppBackground")
    static let appPrimary = Color("AppPrimary")
}
```
- Asset Catalog使用、ライト/ダークモード対応
- セマンティックカラー（`.primary`、`.secondary`）活用

### Motion
- `withAnimation`でstate駆動
- `matchedGeometryEffect`でスムーズ遷移
- 控えめで目的のあるアニメーション

### Backgrounds
- グラデーション重ね合わせ
- 幾何学パターン（ドット、ライン）

### Avoid Generic AI Aesthetics
- 紫グラデーション on 白背景
- 予測可能なレイアウト
- 個性のないデザイン

## 参照ドキュメント

@docs/requirements.md
@docs/architecture.md
@docs/database-schema.md
{{バックエンドAPIがある場合}}@docs/api-spec.md
@docs/breakdown.md
