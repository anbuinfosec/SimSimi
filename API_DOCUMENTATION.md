# 📡 API Documentation - Simi Chat

This document provides detailed information about the APIs used in the Simi Chat application.

---

## 🌐 API Endpoints

### 1. Simi Chat API

**Base URL:** `https://simi.anbuinfosec.live`

#### Chat Endpoint

**POST** `/api/chat`

Send a message to Simi and receive a response.

**Headers:**
```json
{
  "Content-Type": "application/json",
  "Accept": "application/json"
}
```

**Request Body:**
```json
{
  "ask": "Hello, how are you?",
  "lc": "en"
}
```

**Parameters:**
- `ask` (string, required): The message/question to send to Simi
- `lc` (string, required): Language code (e.g., "en", "bn", "hi", "ja", "vi")

**Response (200 OK):**
```json
{
  "success": true,
  "message": "I'm doing great, thanks for asking!",
  "isUnknownResponse": false
}
```

**Response Fields:**
- `success` (boolean): Whether the request was successful
- `message` (string): Simi's response message
- `isUnknownResponse` (boolean, optional): Indicates if Simi doesn't know the answer

**Example cURL:**
```bash
curl -X POST https://simi.anbuinfosec.live/api/chat \
  -H "Content-Type: application/json" \
  -d '{"ask":"Hello","lc":"en"}'
```

---

### 2. Simi Teach API

**Base URL:** `https://simi.anbuinfosec.live`

#### Teach Endpoint

**POST** `/api/teach`

Teach Simi a new question-answer pair.

**Headers:**
```json
{
  "Content-Type": "application/json",
  "Accept": "application/json"
}
```

**Request Body:**
```json
{
  "ask": "What's your name?",
  "ans": "My name is Simi",
  "lc": "en"
}
```

**Parameters:**
- `ask` (string, required): The question Simi should learn
- `ans` (string, required): The answer Simi should give
- `lc` (string, required): Language code

**Response (200 OK):**
```json
{
  "success": true,
  "message": "You taught the answer to \"What's your name?\".\nNumber of answers: 99+"
}
```

**Response Fields:**
- `success` (boolean): Whether the teaching was successful
- `message` (string): Confirmation message with details

**Example cURL:**
```bash
curl -X POST https://simi.anbuinfosec.live/api/teach \
  -H "Content-Type: application/json" \
  -d '{"ask":"hi","ans":"hello","lc":"en"}'
```

---

### 3. GitHub API

**Base URL:** `https://api.github.com`

#### Get User Profile

**GET** `/users/{username}`

Fetch public profile information for a GitHub user.

**Headers:**
```json
{
  "Accept": "application/json",
  "User-Agent": "SimiFlutterApp"
}
```

**Parameters:**
- `username` (path parameter, required): GitHub username

**Response (200 OK):**
```json
{
  "login": "anbuinfosec",
  "id": 12345678,
  "avatar_url": "https://avatars.githubusercontent.com/u/12345678",
  "html_url": "https://github.com/anbuinfosec",
  "name": "Anbu InfoSec",
  "company": "@company",
  "blog": "https://anbuinfosec.live",
  "location": "Location",
  "email": null,
  "bio": "Developer bio here",
  "twitter_username": null,
  "public_repos": 50,
  "public_gists": 5,
  "followers": 100,
  "following": 50,
  "created_at": "2020-01-01T00:00:00Z",
  "updated_at": "2025-01-01T00:00:00Z"
}
```

**Rate Limiting:**
- Unauthenticated: 60 requests per hour
- Authenticated: 5,000 requests per hour

**Example cURL:**
```bash
curl -X GET https://api.github.com/users/anbuinfosec \
  -H "Accept: application/json" \
  -H "User-Agent: SimiApp"
```

---

## 🗺️ Language Codes

The app supports 200+ language codes. Here are the most common ones:

| Code | Language | Flag |
|------|----------|------|
| `en` | English | 🇺🇸 |
| `bn` | Bengali | 🇧🇩 |
| `hi` | Hindi | 🇮🇳 |
| `ar` | Arabic | 🇸🇦 |
| `zh` | Chinese | 🇨🇳 |
| `es` | Spanish | 🇪🇸 |
| `fr` | French | 🇫🇷 |
| `de` | German | 🇩🇪 |
| `it` | Italian | 🇮🇹 |
| `ja` | Japanese | 🇯🇵 |
| `ko` | Korean | 🇰🇷 |
| `pt` | Portuguese | 🇵🇹 |
| `ru` | Russian | 🇷🇺 |
| `th` | Thai | 🇹🇭 |
| `tr` | Turkish | 🇹🇷 |
| `vi` | Vietnamese | 🇻🇳 |

For the complete list of 200+ language codes, see `lib/models/language_model.dart`.

---

## 🔒 Error Handling

### HTTP Status Codes

| Code | Meaning | Action |
|------|---------|--------|
| 200 | Success | Request completed successfully |
| 400 | Bad Request | Check request parameters |
| 401 | Unauthorized | Authentication required (GitHub) |
| 403 | Forbidden | Rate limit exceeded or access denied |
| 404 | Not Found | Resource doesn't exist |
| 429 | Too Many Requests | Rate limit exceeded, wait before retrying |
| 500 | Server Error | Try again later |
| 503 | Service Unavailable | Service is down, try again later |

### Error Response Format

**Simi API Error:**
```json
{
  "success": false,
  "message": "Error description",
  "error": "Error details"
}
```

**GitHub API Error:**
```json
{
  "message": "Error message",
  "documentation_url": "https://docs.github.com/rest"
}
```

---

## 🔄 Request Flow in App

### Chat Flow
```
User Input → ChatProvider → SimiApiService → POST /api/chat
                                                    ↓
User sees response ← ChatProvider ← ChatResponse ← 200 OK
                        ↓
                   Save to SQLite
```

### Teach Flow
```
User submits form → TeachProvider → TeachApiService → POST /api/teach
                                                           ↓
Success message ← TeachProvider ← TeachResponse ← 200 OK
```

### Developer Profile Flow
```
Screen loads → DeveloperProvider → GithubApiService → GET /users/{username}
                                                            ↓
Profile displayed ← DeveloperProvider ← GithubUser ← 200 OK
                         ↓
                    Cache in memory
```

---

## ⏱️ Timeouts & Retries

### Connection Timeout
```dart
static const Duration timeout = Duration(seconds: 30);
```

All API calls have a 30-second timeout to prevent hanging.

### Retry Strategy
The app doesn't automatically retry failed requests but provides:
- Clear error messages
- Retry buttons in the UI
- Network state awareness

---

## 🧪 Testing API Calls

### Using the App
1. **Chat Test:**
   - Open Chat screen
   - Send "hi" in English
   - Expect response like "hello"

2. **Teach Test:**
   - Open Teach screen
   - Ask: "test question"
   - Answer: "test response"
   - Language: English
   - Submit and verify success message

3. **Developer Test:**
   - Open Developer screen
   - Wait for profile to load
   - Verify @anbuinfosec profile appears

### Using cURL

**Test Chat:**
```bash
curl -X POST https://simi.anbuinfosec.live/api/chat \
  -H "Content-Type: application/json" \
  -d '{"ask":"hi","lc":"en"}'
```

**Test Teach:**
```bash
curl -X POST https://simi.anbuinfosec.live/api/teach \
  -H "Content-Type: application/json" \
  -d '{"ask":"test","ans":"response","lc":"en"}'
```

**Test GitHub:**
```bash
curl https://api.github.com/users/anbuinfosec
```

---

## 📊 Rate Limits

### Simi API
- No documented rate limits
- Use responsibly
- Implement exponential backoff for errors

### GitHub API
- **Unauthenticated:** 60 requests/hour per IP
- **Authenticated:** 5,000 requests/hour (not implemented in this app)
- Rate limit headers in response:
  - `X-RateLimit-Limit`
  - `X-RateLimit-Remaining`
  - `X-RateLimit-Reset`

---

## 🔐 Security Best Practices

1. **Always use HTTPS**
   - All endpoints use secure connections
   - Certificate validation enabled

2. **No credentials in code**
   - No API keys stored
   - No authentication tokens hardcoded

3. **User input validation**
   - Client-side validation before API calls
   - Server-side validation on API

4. **Error message safety**
   - Don't expose internal errors to users
   - Log detailed errors for debugging

---

## 📝 Implementation Examples

### Chat Service in Dart
```dart
Future<ChatResponse> chat(String ask, String lc) async {
  final response = await http.post(
    Uri.parse('$baseUrl/api/chat'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode({'ask': ask, 'lc': lc}),
  ).timeout(Duration(seconds: 30));

  if (response.statusCode == 200) {
    return ChatResponse.fromJson(jsonDecode(response.body));
  }
  throw Exception('Failed to chat: ${response.statusCode}');
}
```

### Teach Service in Dart
```dart
Future<TeachResponse> teach(String ask, String ans, String lc) async {
  final response = await http.post(
    Uri.parse('$baseUrl/api/teach'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode({'ask': ask, 'ans': ans, 'lc': lc}),
  ).timeout(Duration(seconds: 30));

  if (response.statusCode == 200) {
    return TeachResponse.fromJson(jsonDecode(response.body));
  }
  throw Exception('Failed to teach: ${response.statusCode}');
}
```

### GitHub Service in Dart
```dart
Future<GithubUser> getUser(String username) async {
  final response = await http.get(
    Uri.parse('$baseUrl/users/$username'),
    headers: {
      'Accept': 'application/json',
      'User-Agent': 'SimiFlutterApp',
    },
  ).timeout(Duration(seconds: 30));

  if (response.statusCode == 200) {
    return GithubUser.fromJson(jsonDecode(response.body));
  }
  throw Exception('Failed to fetch user: ${response.statusCode}');
}
```

---

## 🔍 Debugging Tips

1. **Enable logging:**
   ```dart
   print('Request: ${request.toJson()}');
   print('Response: ${response.body}');
   ```

2. **Use network inspector:**
   - Chrome DevTools (Web)
   - Charles Proxy (Mobile)
   - Wireshark (All platforms)

3. **Check connectivity:**
   ```dart
   import 'package:connectivity_plus/connectivity_plus.dart';
   final connectivityResult = await Connectivity().checkConnectivity();
   ```

4. **Monitor rate limits:**
   ```dart
   final remaining = response.headers['x-ratelimit-remaining'];
   final reset = response.headers['x-ratelimit-reset'];
   ```

---

## 📚 Additional Resources

- **Simi API:** https://simi.anbuinfosec.live
- **GitHub API Docs:** https://docs.github.com/rest
- **Flutter HTTP:** https://pub.dev/packages/http
- **Provider Docs:** https://pub.dev/packages/provider

---

## ❓ FAQ

**Q: What happens if the API is down?**
A: The app shows error messages and allows retry. Chat history is preserved locally.

**Q: Can I use a different API endpoint?**
A: Yes, modify the `baseUrl` constants in service files.

**Q: Does the app work offline?**
A: Chat history can be viewed offline. New messages require internet connection.

**Q: Are there API costs?**
A: The Simi and GitHub APIs used here are free (with rate limits).

**Q: How do I add authentication?**
A: Modify the service classes to include auth headers. Consider using `dio` package for interceptors.

---

For more help, visit the project repository or contact the developer.
