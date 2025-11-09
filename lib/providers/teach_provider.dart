import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/teach_api_service.dart';

class TeachProvider with ChangeNotifier {
  final TeachApiService _apiService = TeachApiService();

  String _ask = '';
  String _answer = '';
  String _selectedLanguage = 'en';
  bool _isPosting = false;
  String? _successMessage;
  String? _error;
  bool _clearAfterTeach = true;

  String get ask => _ask;
  String get answer => _answer;
  String get selectedLanguage => _selectedLanguage;
  bool get isPosting => _isPosting;
  String? get successMessage => _successMessage;
  String? get error => _error;
  bool get clearAfterTeach => _clearAfterTeach;

  TeachProvider() {
    _loadSavedLanguage();
    _loadClearAfterTeach();
  }

  Future<void> _loadSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _selectedLanguage = prefs.getString('teach_language') ?? 'en';
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading language: $e');
    }
  }

  Future<void> _loadClearAfterTeach() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _clearAfterTeach = prefs.getBool('clear_after_teach') ?? true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading preference: $e');
    }
  }

  void setAsk(String value) {
    _ask = value;
    notifyListeners();
  }

  void setAnswer(String value) {
    _answer = value;
    notifyListeners();
  }

  Future<void> setLanguage(String language) async {
    _selectedLanguage = language;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('teach_language', language);
    } catch (e) {
      debugPrint('Error saving language: $e');
    }
  }

  Future<void> toggleClearAfterTeach() async {
    _clearAfterTeach = !_clearAfterTeach;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('clear_after_teach', _clearAfterTeach);
    } catch (e) {
      debugPrint('Error saving preference: $e');
    }
  }

  Future<void> teach() async {
    if (_ask.trim().isEmpty || _answer.trim().isEmpty) {
      _error = 'Please fill in both Ask and Answer fields';
      notifyListeners();
      return;
    }

    _error = null;
    _successMessage = null;
    _isPosting = true;
    notifyListeners();

    try {
      final response = await _apiService.teach(
        _ask,
        _answer,
        _selectedLanguage,
      );

      _successMessage = response.message;
      _error = null;

      if (_clearAfterTeach) {
        _ask = '';
        _answer = '';
      }
    } catch (e) {
      _error = e.toString();
      _successMessage = null;
      debugPrint('Teach error: $e');
    } finally {
      _isPosting = false;
      notifyListeners();
    }
  }

  void clearMessages() {
    _successMessage = null;
    _error = null;
    notifyListeners();
  }
}
