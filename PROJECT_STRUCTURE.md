# 📁 Project Structure - Simi Chat

Complete overview of the Simi Chat Flutter application architecture.

---

## 🗂️ Directory Structure

```
sim_simi/
├── android/                    # Android platform code
│   ├── app/
│   │   ├── src/main/
│   │   │   ├── AndroidManifest.xml
│   │   │   ├── kotlin/
│   │   │   └── res/
│   │   └── build.gradle.kts
│   └── build.gradle.kts
│
├── ios/                        # iOS platform code
│   ├── Runner/
│   │   ├── AppDelegate.swift
│   │   ├── Info.plist
│   │   └── Assets.xcassets/
│   └── Runner.xcodeproj/
│
├── macos/                      # macOS platform code
│   ├── Runner/
│   │   ├── AppDelegate.swift
│   │   ├── MainFlutterWindow.swift
│   │   └── Info.plist
│   └── Runner.xcodeproj/
│
├── windows/                    # Windows platform code
│   ├── runner/
│   │   ├── main.cpp
│   │   └── resources/
│   └── CMakeLists.txt
│
├── lib/                        # Main application code
│   ├── main.dart              # App entry point
│   │
│   ├── models/                # Data models
│   │   ├── chat_models.dart
│   │   ├── teach_models.dart
│   │   ├── github_models.dart
│   │   └── language_model.dart
│   │
│   ├── services/              # API services
│   │   ├── simi_api_service.dart
│   │   ├── teach_api_service.dart
│   │   └── github_api_service.dart
│   │
│   ├── database/              # Local storage
│   │   └── chat_database.dart
│   │
│   ├── providers/             # State management
│   │   ├── chat_provider.dart
│   │   ├── teach_provider.dart
│   │   └── developer_provider.dart
│   │
│   ├── screens/               # UI screens
│   │   ├── chat_screen.dart
│   │   ├── teach_screen.dart
│   │   └── developer_screen.dart
│   │
│   └── widgets/               # Reusable widgets
│       ├── chat_bubble.dart
│       └── language_selector.dart
│
├── test/                      # Tests
│   └── widget_test.dart
│
├── pubspec.yaml              # Dependencies
├── analysis_options.yaml     # Lint rules
├── README.md                 # Main documentation
├── QUICKSTART.md            # Quick start guide
├── CHANGELOG.md             # Version history
└── API_DOCUMENTATION.md     # API docs
```

---

## 📦 Core Files Description

### Entry Point
- **`lib/main.dart`**
  - App initialization
  - Provider setup
  - Theme configuration
  - Navigation root

### Data Models
- **`lib/models/chat_models.dart`**
  - `ChatRequest`: Request model for chat API
  - `ChatResponse`: Response model from chat API
  - `ChatMessage`: Local message storage model

- **`lib/models/teach_models.dart`**
  - `TeachRequest`: Request model for teach API
  - `TeachResponse`: Response model from teach API

- **`lib/models/github_models.dart`**
  - `GithubUser`: GitHub user profile model

- **`lib/models/language_model.dart`**
  - `Language`: Language selector model (200+ languages)

### Services Layer
- **`lib/services/simi_api_service.dart`**
  - Chat API integration
  - HTTP POST to `/api/chat`
  - Error handling & timeouts

- **`lib/services/teach_api_service.dart`**
  - Teach API integration
  - HTTP POST to `/api/teach`
  - Response parsing

- **`lib/services/github_api_service.dart`**
  - GitHub API integration
  - HTTP GET to `/users/{username}`
  - Public profile fetching

### Database Layer
- **`lib/database/chat_database.dart`**
  - SQLite database setup
  - CRUD operations for messages
  - Auto-cleanup (keep last 50)

### State Management
- **`lib/providers/chat_provider.dart`**
  - Chat state management
  - Message list handling
  - Language selection
  - API call orchestration
  - Local persistence

- **`lib/providers/teach_provider.dart`**
  - Teach form state
  - Form validation
  - API submission
  - Success/error handling

- **`lib/providers/developer_provider.dart`**
  - GitHub profile state
  - Loading states
  - Error handling
  - Profile caching

### UI Screens
- **`lib/screens/chat_screen.dart`**
  - Chat interface
  - Message list (LazyColumn)
  - Input field
  - Language selector
  - Loading indicators

- **`lib/screens/teach_screen.dart`**
  - Teaching form
  - Ask/Answer fields
  - Submit button
  - Success/error feedback

- **`lib/screens/developer_screen.dart`**
  - GitHub profile display
  - Avatar, stats, info
  - Action buttons
  - Pull to refresh

### Reusable Widgets
- **`lib/widgets/chat_bubble.dart`**
  - Message bubble component
  - User/Simi styling
  - Timestamp display
  - Loading animation

- **`lib/widgets/language_selector.dart`**
  - Horizontal language picker
  - Flag + code display
  - Selection state

### Tests
- **`test/widget_test.dart`**
  - App smoke test
  - Navigation test
  - Widget tree verification

---

## 🔄 Data Flow

### Chat Flow
```
User Input (ChatScreen)
    ↓
ChatProvider.sendMessage()
    ↓
ChatDatabase.insertMessage() (user message)
    ↓
SimiApiService.chat()
    ↓
HTTP POST to API
    ↓
ChatResponse.fromJson()
    ↓
ChatDatabase.insertMessage() (Simi response)
    ↓
ChatProvider.notifyListeners()
    ↓
UI Update (ChatScreen)
```

### Teach Flow
```
User Input (TeachScreen)
    ↓
TeachProvider.teach()
    ↓
TeachApiService.teach()
    ↓
HTTP POST to API
    ↓
TeachResponse.fromJson()
    ↓
TeachProvider.setSuccessMessage()
    ↓
TeachProvider.notifyListeners()
    ↓
UI Update (Success Card)
```

### Developer Profile Flow
```
Screen Init (DeveloperScreen)
    ↓
DeveloperProvider.loadProfile()
    ↓
GithubApiService.getUser()
    ↓
HTTP GET from API
    ↓
GithubUser.fromJson()
    ↓
DeveloperProvider.setProfile()
    ↓
DeveloperProvider.notifyListeners()
    ↓
UI Update (Profile Display)
```

---

## 🎨 UI Component Hierarchy

```
SimiApp
└── MaterialApp
    └── MainScreen
        ├── NavigationBar (bottom)
        │   ├── Chat destination
        │   ├── Teach destination
        │   └── Developer destination
        │
        └── IndexedStack (body)
            │
            ├── ChatScreen (index 0)
            │   ├── AppBar
            │   ├── LanguageSelector
            │   ├── ListView (messages)
            │   │   └── ChatBubble (repeated)
            │   └── TextField (input)
            │
            ├── TeachScreen (index 1)
            │   ├── AppBar
            │   ├── LanguageSelector
            │   ├── TextField (ask)
            │   ├── TextField (answer)
            │   ├── SwitchListTile
            │   ├── FilledButton (teach)
            │   ├── Success Card
            │   └── Error Card
            │
            └── DeveloperScreen (index 2)
                ├── AppBar
                ├── RefreshIndicator
                └── SingleChildScrollView
                    ├── CircleAvatar
                    ├── Name/Login Text
                    ├── Bio Text
                    ├── Stats Row
                    │   ├── StatCard (followers)
                    │   ├── StatCard (following)
                    │   └── StatCard (repos)
                    ├── Info Card
                    ├── FilledButton (open GitHub)
                    └── OutlinedButton (copy username)
```

---

## 🔌 Dependencies Map

```
Core Flutter
├── flutter (SDK)
├── material.dart (UI)
└── cupertino_icons (iOS icons)

State Management
└── provider (^6.1.1)
    └── Used by: All providers

Networking
└── http (^1.2.0)
    └── Used by: All services

Local Storage
├── shared_preferences (^2.2.2)
│   └── Used by: Providers (settings)
├── sqflite (^2.3.2)
│   └── Used by: ChatDatabase
├── path_provider (^2.1.2)
│   └── Used by: Database path
└── path (^1.9.0)
    └── Used by: Database setup

UI Enhancement
├── cached_network_image (^3.3.1)
│   └── Used by: DeveloperScreen (avatar)
├── intl (^0.19.0)
│   └── Used by: Date formatting
└── url_launcher (^6.2.4)
    └── Used by: Open URLs

Testing
└── flutter_test (SDK)
    └── Used by: All tests
```

---

## 🏗️ Architecture Patterns

### 1. **Presentation Layer** (Screens & Widgets)
- Displays UI
- Handles user input
- Observes state changes

### 2. **State Management Layer** (Providers)
- Business logic
- State management
- Orchestrates data flow

### 3. **Service Layer** (API Services)
- API communication
- Request/response handling
- Error handling

### 4. **Data Layer** (Models & Database)
- Data structures
- Local persistence
- Data transformation

---

## 📊 Class Relationships

```
ChatScreen
    └── depends on → ChatProvider
        ├── depends on → SimiApiService
        │   └── depends on → ChatRequest/Response
        └── depends on → ChatDatabase
            └── depends on → ChatMessage

TeachScreen
    └── depends on → TeachProvider
        └── depends on → TeachApiService
            └── depends on → TeachRequest/Response

DeveloperScreen
    └── depends on → DeveloperProvider
        └── depends on → GithubApiService
            └── depends on → GithubUser

All Screens
    └── use → LanguageSelector
        └── depends on → Language model
```

---

## 🎯 Key Design Decisions

### State Management: Provider
- **Why:** Simple, official, performant
- **Alternative:** Riverpod, Bloc, GetX

### Database: SQLite (sqflite)
- **Why:** Reliable, cross-platform, fast
- **Alternative:** Hive, Isar, ObjectBox

### HTTP Client: http package
- **Why:** Simple, official, sufficient
- **Alternative:** Dio (for interceptors)

### Navigation: MaterialApp Navigator
- **Why:** Simple bottom nav, no complex routing
- **Alternative:** go_router, auto_route

---

## 🔒 Security Considerations

1. **No secrets in code**
   - No API keys hardcoded
   - No tokens stored

2. **HTTPS only**
   - All API calls use secure connections

3. **Input validation**
   - Form validation before API calls

4. **Local storage**
   - No sensitive data stored
   - Only chat history and preferences

---

## 🚀 Performance Optimizations

1. **Lazy loading**
   - ListView.builder for messages
   - Only render visible items

2. **Image caching**
   - cached_network_image for avatars

3. **Database optimization**
   - Limit to last 50 messages
   - Indexed queries

4. **State optimization**
   - Selective widget rebuilds with Consumer
   - ChangeNotifier for minimal updates

---

## 📱 Platform-Specific Code

### Android
- `android/app/src/main/AndroidManifest.xml`
  - Internet permissions
  - App label

### iOS
- `ios/Runner/Info.plist`
  - App name
  - Permissions

### macOS
- `macos/Runner/Configs/AppInfo.xcconfig`
  - App configuration

### Windows
- `windows/runner/main.cpp`
  - Entry point

---

## 🧩 Extension Points

Easy areas to extend:

1. **Add new screen**
   - Create in `lib/screens/`
   - Add to `MainScreen._screens`
   - Add NavigationDestination

2. **Add new provider**
   - Create in `lib/providers/`
   - Register in `main.dart`

3. **Add new API**
   - Create service in `lib/services/`
   - Create models in `lib/models/`

4. **Add new widget**
   - Create in `lib/widgets/`
   - Import where needed

---

## 📚 Further Reading

- [Flutter Architecture](https://docs.flutter.dev/development/data-and-backend/state-mgmt/intro)
- [Provider Pattern](https://pub.dev/packages/provider)
- [Material Design 3](https://m3.material.io/)
- [SQLite in Flutter](https://pub.dev/packages/sqflite)

---

**This structure provides a solid foundation for a production-ready, maintainable Flutter application.**
