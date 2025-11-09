import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/chat_models.dart';

class SimiApiService {
  static const String baseUrl = 'https://simi.anbuinfosec.live';
  static const Duration timeout = Duration(seconds: 30);

  Future<ChatResponse> chat(String ask, String lc) async {
    try {
      final request = ChatRequest(ask: ask, lc: lc);
      final response = await http
          .post(
            Uri.parse('$baseUrl/api/chat'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(request.toJson()),
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ChatResponse.fromJson(data);
      } else {
        throw Exception('Failed to chat: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }
}
