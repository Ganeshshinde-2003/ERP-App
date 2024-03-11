class Notice {
  final String id;
  final String title;
  final String description;
  final String noticeDate;
  final String recipients;
  final String createdAt;

  Notice({
    required this.id,
    required this.title,
    required this.description,
    required this.noticeDate,
    required this.recipients,
    required this.createdAt,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      noticeDate: json['noticeDate'] ?? '',
      recipients: json['recipients'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}

class NoticesModel {
  final bool success;
  final String message;
  final List<Notice> data;

  NoticesModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory NoticesModel.fromJson(Map<String, dynamic> json) {
    return NoticesModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => Notice.fromJson(item))
              .toList() ??
          [],
    );
  }
}
