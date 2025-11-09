# 🚀 Quick Start Guide - Simi Chat

This guide will help you build and run the Simi Chat app on all supported platforms.

---

## ✅ Prerequisites Check

Before starting, make sure you have:

```bash
# Check Flutter installation
flutter doctor

# Check Dart version
dart --version

# Update Flutter to latest
flutter upgrade
```

---

## 📱 Platform-Specific Setup

### Android

**Requirements:**
- Android Studio or VS Code with Flutter/Dart extensions
- Android SDK (API 21+)
- Java JDK 11+

**Build & Run:**
```bash
# Debug mode
flutter run -d android

# Release APK
flutter build apk --release

# APK location: build/app/outputs/flutter-apk/app-release.apk
```

**Install APK on device:**
```bash
flutter install
```

---

### iOS

**Requirements:**
- macOS
- Xcode 14+
- CocoaPods
- iOS Simulator or physical iOS device

**Setup:**
```bash
# Install CocoaPods dependencies
cd ios
pod install
cd ..
```

**Build & Run:**
```bash
# Debug mode
flutter run -d ios

# Release build
flutter build ios --release

# Open in Xcode
open ios/Runner.xcworkspace
```

---

### macOS

**Requirements:**
- macOS 10.14+
- Xcode Command Line Tools

**Enable macOS support:**
```bash
flutter config --enable-macos-desktop
```

**Build & Run:**
```bash
# Debug mode
flutter run -d macos

# Release build
flutter build macos --release

# App location: build/macos/Build/Products/Release/sim_simi.app
```

---

### Windows

**Requirements:**
- Windows 10 1809+
- Visual Studio 2022 with C++ Desktop Development

**Enable Windows support:**
```bash
flutter config --enable-windows-desktop
```

**Build & Run:**
```bash
# Debug mode
flutter run -d windows

# Release build
flutter build windows --release

# App location: build\windows\runner\Release\
```

---

### Linux

**Requirements:**
- Linux (Ubuntu 20.04+ recommended)
- Required packages:
  ```bash
  sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
  ```

**Enable Linux support:**
```bash
flutter config --enable-linux-desktop
```

**Build & Run:**
```bash
# Debug mode
flutter run -d linux

# Release build
flutter build linux --release

# App location: build/linux/x64/release/bundle/
```

---

### Web (Bonus)

**Build & Run:**
```bash
# Enable web support
flutter config --enable-web

# Run in Chrome
flutter run -d chrome

# Build for web
flutter build web --release

# Output: build/web/
```

---

## 🔧 Development Commands

### Hot Reload
While the app is running, press:
- `r` - Hot reload
- `R` - Hot restart
- `q` - Quit

### Debugging
```bash
# Run with verbose logging
flutter run -v

# Run specific device
flutter devices
flutter run -d <device-id>
```

### Clean Build
```bash
# Clean build cache
flutter clean

# Get dependencies
flutter pub get

# Rebuild
flutter run
```

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# View coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

## 📊 Code Analysis

```bash
# Analyze code
flutter analyze

# Format code
dart format .

# Fix common issues
dart fix --apply
```

---

## 🎯 Build Variants

### Debug Build
- Fast compilation
- Includes debug symbols
- Hot reload enabled
```bash
flutter run
```

### Profile Build
- Optimized performance
- Profiling tools enabled
```bash
flutter run --profile
```

### Release Build
- Maximum optimization
- Smallest size
- No debug info
```bash
flutter build <platform> --release
```

---

## 🌐 Environment Setup

### API Configuration

If you need to change API endpoints, edit:

**Simi API:**
`lib/services/simi_api_service.dart`
```dart
static const String baseUrl = 'https://simi.anbuinfosec.live';
```

**GitHub API:**
`lib/services/github_api_service.dart`
```dart
static const String baseUrl = 'https://api.github.com';
```

---

## 🚨 Troubleshooting

### Common Issues

**1. Dependencies not resolving**
```bash
flutter clean
flutter pub get
```

**2. Build errors**
```bash
flutter clean
flutter pub cache repair
flutter pub get
```

**3. Android build fails**
```bash
cd android
./gradlew clean
cd ..
flutter run
```

**4. iOS pod install fails**
```bash
cd ios
pod deintegrate
pod install
cd ..
```

**5. macOS permission errors**
```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -license accept
```

---

## 📦 App Size Optimization

### Reduce APK size (Android)
```bash
# Build app bundles
flutter build appbundle --release

# Split APKs by ABI
flutter build apk --split-per-abi
```

### Analyze size
```bash
flutter build apk --analyze-size
flutter build ios --analyze-size
```

---

## 🎨 Customization

### Change App Name

**Android:** `android/app/src/main/AndroidManifest.xml`
```xml
<application android:label="Your App Name">
```

**iOS:** `ios/Runner/Info.plist`
```xml
<key>CFBundleName</key>
<string>Your App Name</string>
```

**macOS:** `macos/Runner/Configs/AppInfo.xcconfig`
```
PRODUCT_NAME = Your App Name
```

### Change Package Name

Use the `change_app_package_name` package:
```bash
flutter pub global activate change_app_package_name
flutter pub global run change_app_package_name:main com.yourcompany.yourapp
```

---

## 🔑 Key Features to Test

1. **Chat Screen**
   - Send messages to Simi
   - Change language
   - Scroll through messages
   - Clear chat history

2. **Teach Screen**
   - Add question/answer pairs
   - Change language
   - Toggle clear after teach

3. **Developer Screen**
   - View GitHub profile
   - Open profile in browser
   - Copy username
   - Pull to refresh

---

## 📱 Deployment

### Android (Google Play)
1. Generate keystore
2. Configure `android/key.properties`
3. Build app bundle: `flutter build appbundle --release`
4. Upload to Play Console

### iOS (App Store)
1. Configure signing in Xcode
2. Build archive: `flutter build ios --release`
3. Open Xcode and archive
4. Submit to App Store Connect

### macOS (Mac App Store)
1. Configure signing and entitlements
2. Build: `flutter build macos --release`
3. Create package and submit

### Windows (Microsoft Store)
1. Create MSIX package
2. Build: `flutter build windows --release`
3. Package with MSIX tool
4. Submit to Partner Center

---

## 🎉 Success!

Your Simi Chat app should now be running! 

For issues or questions, check:
- GitHub Issues
- Flutter Documentation: https://docs.flutter.dev
- API Documentation: https://simi.anbuinfosec.live

Happy coding! 🚀
