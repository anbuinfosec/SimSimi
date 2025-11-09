import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chat_models.dart';

class ChatStorageService {
  static const String _chatMessagesKey = 'chat_messages';
  static const int _maxMessages = 50;

  /// Save chat messages to SharedPreferences
  static Future<void> saveMessages(List<ChatMessage> messages) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Keep only last 50 messages
      final messagesToSave = messages.length > _maxMessages
          ? messages.sublist(messages.length - _maxMessages)
          : messages;

      // Convert messages to JSON
      final jsonList = messagesToSave.map((msg) => msg.toJson()).toList();
      final jsonString = jsonEncode(jsonList);

      await prefs.setString(_chatMessagesKey, jsonString);
    } catch (e) {
      debugPrint('Error saving messages: $e');
    }
  }

  /// Load chat messages from SharedPreferences
  static Future<List<ChatMessage>> loadMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_chatMessagesKey);

      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.map((json) => ChatMessage.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error loading messages: $e');
      return [];
    }
  }

  /// Clear all chat messages
  static Future<void> clearMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_chatMessagesKey);
    } catch (e) {
      debugPrint('Error clearing messages: $e');
    }
  }

  /// Add a single message (loads, adds, saves)
  static Future<void> addMessage(ChatMessage message) async {
    try {
      final messages = await loadMessages();
      messages.add(message);
      await saveMessages(messages);
    } catch (e) {
      debugPrint('Error adding message: $e');
    }
  }
}
