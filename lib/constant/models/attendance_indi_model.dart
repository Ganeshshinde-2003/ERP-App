class AttendanceIndiModel {
  final bool success;
  final String message;
  final AttendanceData data;

  AttendanceIndiModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AttendanceIndiModel.fromJson(Map<String, dynamic> json) {
    return AttendanceIndiModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: AttendanceData.fromJson(json['data'] ?? const {}),
    );
  }
}

class AttendanceData {
  final List<String> absentDates;
  final List<String> presentDates;

  AttendanceData({
    required this.absentDates,
    required this.presentDates,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      absentDates: List<String>.from(json['absentDates'] ?? const []),
      presentDates: List<String>.from(json['presentDates'] ?? const []),
    );
  }
}
