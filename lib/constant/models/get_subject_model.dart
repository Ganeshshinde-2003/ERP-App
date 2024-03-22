class SubjectResponse {
  bool success;
  String message;
  List<SubjectData> data;

  SubjectResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SubjectResponse.fromJson(Map<String, dynamic> json) {
    return SubjectResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List)
          .map((subject) => SubjectData.fromJson(subject))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((subject) => subject.toJson()).toList(),
    };
  }
}

class SubjectData {
  String id;
  String subjectName;

  SubjectData({
    required this.id,
    required this.subjectName,
  });

  factory SubjectData.fromJson(Map<String, dynamic> json) {
    return SubjectData(
      id: json['_id'] ?? '',
      subjectName: json['subjectName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'subjectName': subjectName,
    };
  }
}
