import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chat_models.dart';
import '../services/simi_api_service.dart';
import '../services/chat_storage_service.dart';

class ChatProvider with ChangeNotifier {
  final SimiApiService _apiService = SimiApiService();

  List<ChatMessage> _messages = [];
  String _selectedLanguage = 'en';
  bool _isLoading = false;
  String? _error;

  List<ChatMessage> get messages => _messages;
  String get selectedLanguage => _selectedLanguage;
  bool get isLoading => _isLoading;
  String? get error => _error;

  ChatProvider() {
    _loadMessages();
    _loadSavedLanguage();
  }

  Future<void> _loadMessages() async {
    try {
      _messages = await ChatStorageService.loadMessages();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading messages: $e');
    }
  }

  Future<void> _loadSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _selectedLanguage = prefs.getString('chat_language') ?? 'en';
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading language: $e');
    }
  }

  Future<void> setLanguage(String language) async {
    _selectedLanguage = language;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('chat_language', language);
    } catch (e) {
      debugPrint('Error saving language: $e');
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    _error = null;

    // Add user message
    final userMessage = ChatMessage(
      text: text,
      isMe: true,
      timestamp: DateTime.now(),
    );

    _messages.add(userMessage);
    notifyListeners();

    // Save to storage
    try {
      await ChatStorageService.addMessage(userMessage);
    } catch (e) {
      debugPrint('Error saving message: $e');
    }

    // Send to API
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.chat(text, _selectedLanguage);

      final simiMessage = ChatMessage(
        text: response.message,
        isMe: false,
        timestamp: DateTime.now(),
      );

      _messages.add(simiMessage);
      await ChatStorageService.addMessage(simiMessage);

      _error = null;
    } catch (e) {
      _error = e.toString();
      debugPrint('Chat error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> clearMessages() async {
    try {
      await ChatStorageService.clearMessages();
      _messages.clear();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteMessage(int index) async {
    try {
      if (index >= 0 && index < _messages.length) {
        _messages.removeAt(index);
        await ChatStorageService.saveMessages(_messages);
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
