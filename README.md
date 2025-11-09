# Simi Chat - Flutter Multi-Platform App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

A modern, production-ready chat application built with Flutter that lets you chat with Simi AI, teach new responses, and view developer information.

**Supports:** Android • iOS • macOS • Windows • Linux

</div>

---

## 🌟 Features

### 💬 Chat with Simi
- Real-time AI chat powered by Simi API
- Support for 200+ languages with flag indicators
- Persistent chat history (last 50 messages stored locally)
- Beautiful Material 3 UI with chat bubbles
- Typing indicators and smooth animations
- Auto-scroll to latest messages
- Dark mode support

### 📚 Teach Simi
- Teach new question-answer pairs to Simi
- Multi-language support for teaching
- Character counters on input fields
- Success/error feedback with detailed messages
- Optional auto-clear fields after teaching
- Form validation

### 👨‍💻 Developer Profile
- View GitHub profile for @anbuinfosec
- Display avatar, bio, and statistics
- Stats: Followers, Following, Public Repos
- Additional info: Company, Location, Blog
- Direct links to GitHub profile
- Pull-to-refresh support
- Copy username to clipboard

---

## 📱 Screenshots

<div align="center">
<table>
  <tr>
    <td><b>Chat Screen</b></td>
    <td><b>Teach Screen</b></td>
    <td><b>Developer Screen</b></td>
  </tr>
  <tr>
    <td>Chat with Simi in 200+ languages</td>
    <td>Teach new responses</td>
    <td>View developer info</td>
  </tr>
</table>
</div>

---

## 🏗️ Architecture

### Clean Architecture Layers

```
lib/
├── models/              # Data models
│   ├── chat_models.dart
│   ├── teach_models.dart
│   ├── github_models.dart
│   └── language_model.dart
├── services/            # API services
│   ├── simi_api_service.dart
│   ├── teach_api_service.dart
│   └── github_api_service.dart
├── database/            # Local storage
│   └── chat_database.dart
├── providers/           # State management
│   ├── chat_provider.dart
│   ├── teach_provider.dart
│   └── developer_provider.dart
├── screens/             # UI screens
│   ├── chat_screen.dart
│   ├── teach_screen.dart
│   └── developer_screen.dart
├── widgets/             # Reusable widgets
│   ├── chat_bubble.dart
│   └── language_selector.dart
└── main.dart            # App entry point
```

### State Management
- **Provider** pattern for reactive state management
- Separate providers for each feature (Chat, Teach, Developer)
- Local state persistence using SharedPreferences
- Offline-first chat history with SQLite

### API Integration
- **Simi Chat API**: `https://simi.anbuinfosec.live/api/chat`
- **Simi Teach API**: `https://simi.anbuinfosec.live/api/teach`
- **GitHub API**: `https://api.github.com/users/{username}`

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.9.2)
- Dart SDK (>=3.9.2)
- Android Studio / Xcode / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/anbuinfosec/sim_simi.git
   cd sim_simi
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**

   **Android:**
   ```bash
   flutter run -d android
   ```

   **iOS:**
   ```bash
   flutter run -d ios
   ```

   **macOS:**
   ```bash
   flutter run -d macos
   ```

   **Windows:**
   ```bash
   flutter run -d windows
   ```

   **Linux:**
   ```bash
   flutter run -d linux
   ```

4. **Build for release**

   **Android APK:**
   ```bash
   flutter build apk --release
   ```

   **iOS:**
   ```bash
   flutter build ios --release
   ```

   **macOS:**
   ```bash
   flutter build macos --release
   ```

   **Windows:**
   ```bash
   flutter build windows --release
   ```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1              # State management
  http: ^1.2.0                  # HTTP requests
  shared_preferences: ^2.2.2    # Local storage
  sqflite: ^2.3.2              # SQLite database
  path_provider: ^2.1.2         # File system paths
  cached_network_image: ^3.3.1  # Image caching
  intl: ^0.19.0                # Date formatting
  url_launcher: ^6.2.4          # Open URLs
  cupertino_icons: ^1.0.8       # iOS icons
```

---

## 🎨 Design System

### Material 3
- Dynamic color schemes
- Adaptive light/dark themes
- Responsive layouts for all screen sizes
- Accessibility-friendly (screen reader support)

### Color Palette
- **Primary:** Blue (customizable via theme)
- **Surface variants:** Automatic based on brightness
- **Semantic colors:** Error, success, warning states

### Typography
- Material Design type scale
- Dynamic font scaling
- Readable font sizes (minimum 12sp)

---

## 🌐 Language Support

The app supports **200+ languages** including:

🇺🇸 English • 🇧🇩 Bengali • 🇮🇳 Hindi • 🇸🇦 Arabic • 🇨🇳 Chinese • 🇪🇸 Spanish • 🇫🇷 French • 🇩🇪 German • 🇮🇹 Italian • 🇯🇵 Japanese • 🇰🇷 Korean • 🇵🇹 Portuguese • 🇷🇺 Russian • 🇹🇭 Thai • 🇹🇷 Turkish • 🇻🇳 Vietnamese

...and 180+ more!

---

## 🔧 Configuration

### API Endpoints

Update base URLs in service files if needed:

**lib/services/simi_api_service.dart:**
```dart
static const String baseUrl = 'https://simi.anbuinfosec.live';
```

**lib/services/github_api_service.dart:**
```dart
static const String baseUrl = 'https://api.github.com';
```

### Database

Chat messages are stored locally using SQLite. The database automatically maintains only the last 50 messages.

**Location:**
- Android: `/data/data/com.anbuinfosec.simi.sim_simi/databases/chat.db`
- iOS: `Library/Application Support/chat.db`
- macOS: `~/Library/Containers/.../Data/Library/Application Support/chat.db`

---

## 🧪 Testing

### Run Tests
```bash
flutter test
```

### Coverage
```bash
flutter test --coverage
```

### Analyze Code
```bash
flutter analyze
```

---

## 🔒 Security & Privacy

- ✅ All API calls use HTTPS/TLS
- ✅ No sensitive data stored
- ✅ No third-party analytics
- ✅ Complies with data protection standards
- ✅ Local-first data storage
- ✅ No authentication required

---

## 📱 Platform-Specific Features

### Android
- Material Design 3
- Adaptive icons
- Edge-to-edge display
- Minimum SDK: 21 (Android 5.0)

### iOS
- Cupertino widgets where appropriate
- Safe area handling
- iOS 12.0+ support

### macOS
- Native window chrome
- Menu bar integration
- macOS 10.14+ support

### Windows
- Modern Fluent Design
- Windows 10+ support

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## 👨‍💻 Developer

**Anbu InfoSec**
- GitHub: [@anbuinfosec](https://github.com/anbuinfosec)
- API: https://simi.anbuinfosec.live

---

## 🐛 Known Issues

- None currently. Please report issues on GitHub!

---

## 🗺️ Roadmap

- [ ] Add voice input for chat
- [ ] Export chat history
- [ ] Custom themes
- [ ] Message search
- [ ] Share messages
- [ ] Multiple chat sessions
- [ ] Cloud sync (optional)

---

## 📞 Support

For issues, questions, or suggestions:
- 📧 Open an issue on GitHub
- 💬 Start a discussion
- 🌐 Visit: https://simi.anbuinfosec.live

---

<div align="center">

Made with ❤️ using Flutter

**[⬆ Back to Top](#simi-chat---flutter-multi-platform-app)**

</div>
