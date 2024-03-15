class AssignmentData {
  String id;
  String title;
  String description;
  DateTime dueDate;
  String uploadedFileUrl;
  DateTime createdAt;

  AssignmentData({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.uploadedFileUrl,
    required this.createdAt,
  });

  factory AssignmentData.fromJson(Map<String, dynamic> json) {
    return AssignmentData(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      dueDate: DateTime.parse(json['dueDate']),
      uploadedFileUrl: json['uploadedFileUrl'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'uploadedFileUrl': uploadedFileUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class AssignmentDataModel {
  bool success;
  String message;
  List<AssignmentData> data;

  AssignmentDataModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AssignmentDataModel.fromJson(Map<String, dynamic> json) {
    return AssignmentDataModel(
      success: json['success'],
      message: json['message'],
      data: List<AssignmentData>.from(json['data']
          .map((assignmentData) => AssignmentData.fromJson(assignmentData))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': List<dynamic>.from(
          data.map((assignmentData) => assignmentData.toJson())),
    };
  }
}
