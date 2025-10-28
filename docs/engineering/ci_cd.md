# Continuous Integration and Delivery Pipeline

This document outlines the recommended CI/CD stages for Flutter projects. Adapt to the capabilities of your CI provider (e.g., GitHub Actions, GitLab CI, CircleCI).

## Pipeline Overview
1. **Preparation**
   - Checkout repository and fetch submodules.
   - Install Flutter SDK (cache if supported).
   - Run `flutter doctor --verbose` to verify toolchain.
2. **Static Analysis**
   - `flutter pub get`
   - `dart format --output=none --set-exit-if-changed .`
   - `flutter analyze`
   - Optional: `dart run dart_code_metrics:metrics .` for additional linting.
3. **Unit and Widget Tests**
   - `flutter test --coverage`
   - Upload coverage to codecov/coveralls if enabled.
4. **Integration Tests**
   - Launch headless emulator or use `flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart`.
   - For web: `flutter test integration_test --platform chrome`.
5. **Build Artifacts**
   - Android: `flutter build appbundle --flavor prod` and/or `flutter build apk`.
   - iOS: `flutter build ipa --export-method app-store` (macOS runners only).
   - Web/Desktop: `flutter build web`, `flutter build macos`, etc.
6. **Quality Gates**
   - Ensure required checks (formatting, analyze, tests) pass before merging.
   - Enforce minimum coverage thresholds.
7. **Deployment**
   - Promote artifacts to release channels (Firebase App Distribution, TestFlight, Play Console) via CLI integrations.
   - Tag releases and publish changelog.

## Sample Job Matrix
| Stage | Recommended Runner | Notes |
|-------|--------------------|-------|
| Setup & Static Analysis | Linux | Fastest runners, no GUI needed |
| Unit Tests | Linux | Run in parallel shards where possible |
| Integration Tests | macOS & Windows | Required for platform-specific coverage |
| Build | macOS (for iOS) & Linux (for Android/Web) | Cache Gradle/CocoaPods directories |
| Deploy | Same as build stage | Requires credentials in secure secrets store |

## Caching Recommendations
- Flutter SDK: cache by version + channel.
- Pub packages: cache `~/.pub-cache`.
- Android build: cache `.gradle` and `~/.android`. Invalidate when `android/build.gradle` changes.
- iOS build: cache `Pods/` and `~/Library/Developer/Xcode/DerivedData` (macOS only).

## Notifications
- Configure CI to post build status to Slack/MS Teams.
- Enable email alerts for failed main-branch builds.

## Security & Compliance
- Store signing keys and API tokens in the CI secret manager.
- Rotate secrets regularly.
- Use least privilege IAM roles for deployment steps.

