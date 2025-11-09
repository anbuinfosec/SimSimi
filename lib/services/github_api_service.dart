import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/github_models.dart';

class GithubApiService {
  static const String baseUrl = 'https://api.github.com';
  static const Duration timeout = Duration(seconds: 30);

  Future<GithubUser> getUser(String username) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/users/$username'),
            headers: {
              'Accept': 'application/json',
              'User-Agent': 'SimiFlutterApp',
            },
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return GithubUser.fromJson(data);
      } else {
        throw Exception('Failed to fetch user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }
}
