class ExamResultSubject {
  bool success;
  String message;
  List<ExamDataBySubject> data;

  ExamResultSubject({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ExamResultSubject.fromJson(Map<String, dynamic> json) {
    return ExamResultSubject(
      success: json['success'],
      message: json['message'],
      data: List<ExamDataBySubject>.from(
        json['data'].map((x) => ExamDataBySubject.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}

class ExamDataBySubject {
  String id;
  ExamScheduleBySubject examSchedule;
  int obtainedMarks;

  ExamDataBySubject({
    required this.id,
    required this.examSchedule,
    required this.obtainedMarks,
  });

  factory ExamDataBySubject.fromJson(Map<String, dynamic> json) {
    return ExamDataBySubject(
      id: json['_id'],
      examSchedule: ExamScheduleBySubject.fromJson(json['examScheduleID']),
      obtainedMarks: json['obtainedMarks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'examScheduleID': examSchedule.toJson(),
      'obtainedMarks': obtainedMarks,
    };
  }
}

class ExamScheduleBySubject {
  String id;
  String examDate;
  ExamTypeBySubject examType;

  ExamScheduleBySubject({
    required this.id,
    required this.examDate,
    required this.examType,
  });

  factory ExamScheduleBySubject.fromJson(Map<String, dynamic> json) {
    return ExamScheduleBySubject(
      id: json['_id'],
      examDate: json['examDate'],
      examType: ExamTypeBySubject.fromJson(json['examTypeID']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'examDate': examDate,
      'examTypeID': examType.toJson(),
    };
  }
}

class ExamTypeBySubject {
  String id;
  ExamCategoryBySubject examCategory;
  int passingMarks;

  ExamTypeBySubject({
    required this.id,
    required this.examCategory,
    required this.passingMarks,
  });

  factory ExamTypeBySubject.fromJson(Map<String, dynamic> json) {
    return ExamTypeBySubject(
      id: json['_id'],
      examCategory: ExamCategoryBySubject.fromJson(json['examCatID']),
      passingMarks: json['passingMarks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'examCatID': examCategory.toJson(),
      'passingMarks': passingMarks,
    };
  }
}

class ExamCategoryBySubject {
  String id;
  String examCategory;

  ExamCategoryBySubject({
    required this.id,
    required this.examCategory,
  });

  factory ExamCategoryBySubject.fromJson(Map<String, dynamic> json) {
    return ExamCategoryBySubject(
      id: json['_id'],
      examCategory: json['examCategory'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'examCategory': examCategory,
    };
  }
}
