class TeachRequest {
  final String ask;
  final String ans;
  final String lc;

  TeachRequest({required this.ask, required this.ans, required this.lc});

  Map<String, dynamic> toJson() => {'ask': ask, 'ans': ans, 'lc': lc};
}

class TeachResponse {
  final bool success;
  final String message;

  TeachResponse({required this.success, required this.message});

  factory TeachResponse.fromJson(Map<String, dynamic> json) {
    return TeachResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
    );
  }
}
