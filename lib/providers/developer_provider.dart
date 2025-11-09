import 'package:flutter/foundation.dart';
import '../models/github_models.dart';
import '../services/github_api_service.dart';

class DeveloperProvider with ChangeNotifier {
  final GithubApiService _apiService = GithubApiService();

  GithubUser? _profile;
  bool _isLoading = false;
  String? _error;

  GithubUser? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadProfile({String username = 'anbuinfosec'}) async {
    _error = null;
    _isLoading = true;
    notifyListeners();

    try {
      _profile = await _apiService.getUser(username);
      _error = null;
    } catch (e) {
      _error = e.toString();
      debugPrint('GitHub error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
