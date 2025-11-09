import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/teach_models.dart';

class TeachApiService {
  static const String baseUrl = 'https://simi.anbuinfosec.live';
  static const Duration timeout = Duration(seconds: 30);

  Future<TeachResponse> teach(String ask, String ans, String lc) async {
    try {
      final request = TeachRequest(ask: ask, ans: ans, lc: lc);
      final response = await http
          .post(
            Uri.parse('$baseUrl/api/teach'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(request.toJson()),
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return TeachResponse.fromJson(data);
      } else {
        throw Exception('Failed to teach: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }
}
