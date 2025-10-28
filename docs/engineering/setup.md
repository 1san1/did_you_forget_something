# Flutter Development Environment Setup

This guide outlines how to install the Flutter toolchain, configure the local development environment, and prepare emulators for testing.

## Prerequisites
- **Operating Systems:** macOS 13+, Windows 11, or Ubuntu 22.04 LTS.
- **Hardware:** Minimum 16 GB RAM, 30 GB free storage, hardware virtualization enabled.

## Flutter Toolchain Installation
1. **Install Flutter SDK**
   - Download the latest stable channel from [flutter.dev](https://flutter.dev/docs/get-started/install).
   - Extract to a permanent location (e.g., `~/development/flutter`).
   - Add Flutter to your `PATH`:
     ```bash
     export PATH="$PATH:$HOME/development/flutter/bin"
     ```
   - Run `flutter doctor` to verify the installation and follow remediation instructions.

2. **Install Dart SDK (optional)**
   - Flutter bundles Dart, but standalone installs enable CLI usage: follow the [official Dart install guide](https://dart.dev/get-dart).

3. **Install Platform Dependencies**
   - **macOS:** Xcode (via App Store), command-line tools, CocoaPods (`sudo gem install cocoapods`).
   - **Windows:** Visual Studio Build Tools with Desktop development with C++ workload, PowerShell 5.1+.
   - **Linux:** `clang`, `cmake`, `ninja-build`, `pkg-config`, `libgtk-3-dev`, `liblzma-dev`.

4. **Configure IDEs**
   - Install Android Studio (for Android SDK manager and emulator).
   - Install VS Code or IntelliJ IDEA with Flutter/Dart plugins.

## Environment Configuration
- **Flutter Channels:** Use the stable channel by default: `flutter channel stable && flutter upgrade`.
- **Dependency Management:** Use `flutter pub get` to sync dependencies before building.
- **Environment Files:**
  - Store secrets in `.env` files; never commit them.
  - Example `.env` keys:
    ```dotenv
    API_BASE_URL=https://api.example.com
    SENTRY_DSN=your_dsn_here
    FEATURE_FLAGS=beta,experimental
    ```
- **Build Flavors:** Configure `lib/main_dev.dart`, `lib/main_staging.dart`, and `lib/main_prod.dart` for environment-specific entry points.
- **Stateful Credentials:** Use the `flutter_secure_storage` plugin for secure token storage.

## Emulator and Device Guidance
1. **Android Emulators**
   - Launch Android Studio > Virtual Device Manager.
   - Create Pixel 6 (API 34) with hardware acceleration (HAXM/Hypervisor/WSL2).
   - Enable `Use host GPU` for better performance.

2. **iOS Simulators** (macOS only)
   - Open Xcode > Settings > Platforms to download latest iOS simulators.
   - Run via `open -a Simulator` or `flutter devices`.

3. **Physical Devices**
   - Enable developer mode and USB debugging.
   - Trust connected computers and accept prompts.
   - Use `flutter run -d <device_id>` to target a specific device.

4. **Device Registration**
   - Register developer devices in Firebase/AppCenter (if applicable) for push notifications.

5. **Common Commands**
   ```bash
   flutter doctor -v              # Detailed health check
   flutter clean && flutter pub get
   flutter run -d chrome          # Run in Chrome web
   flutter emulators --launch <id>
   ```

## Troubleshooting
- Run `flutter config --enable-web` or `--enable-macos-desktop` for additional platforms.
- Delete the `DerivedData` (iOS) or `.gradle` caches (Android) to resolve build inconsistencies.
- Ensure Android licenses are accepted: `flutter doctor --android-licenses`.

