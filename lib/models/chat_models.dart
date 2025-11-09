class ChatRequest {
  final String ask;
  final String lc;

  ChatRequest({required this.ask, required this.lc});

  Map<String, dynamic> toJson() => {'ask': ask, 'lc': lc};
}

class ChatResponse {
  final bool success;
  final String message;
  final bool? isUnknownResponse;

  ChatResponse({
    required this.success,
    required this.message,
    this.isUnknownResponse,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      isUnknownResponse: json['isUnknownResponse'] as bool?,
    );
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isMe': isMe,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json['text'] as String,
      isMe: json['isMe'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  // Keep the old toMap/fromMap for compatibility (can be removed if not needed)
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'isMe': isMe ? 1 : 0,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      text: map['text'] as String,
      isMe: map['isMe'] == 1,
      timestamp: DateTime.parse(map['timestamp'] as String),
    );
  }
}
