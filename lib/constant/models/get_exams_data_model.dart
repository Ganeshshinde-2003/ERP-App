class ExamScheduleModel {
  final bool success;
  final String message;
  final List<ExamData> data;

  ExamScheduleModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ExamScheduleModel.fromJson(Map<String, dynamic> json) {
    return ExamScheduleModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>)
          .map((e) => ExamData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class ExamData {
  final String id;
  final ExamScheduleModelID? examScheduleModelID;
  final StudentID? studentID;
  final String status;
  final String statusDate;
  final String createdAt;
  final String updatedAt;
  final int v;

  ExamData({
    required this.id,
    required this.status,
    required this.statusDate,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.examScheduleModelID,
    this.studentID,
  });

  factory ExamData.fromJson(Map<String, dynamic> json) {
    return ExamData(
      id: json['_id'] ?? '',
      examScheduleModelID: json['examScheduleModelID'] != null
          ? ExamScheduleModelID.fromJson(
              json['examScheduleModelID'] as Map<String, dynamic>)
          : null,
      studentID: json['studentID'] != null
          ? StudentID.fromJson(json['studentID'] as Map<String, dynamic>)
          : null,
      status: json['status'] ?? '',
      statusDate: json['statusDate'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'examScheduleModelID': examScheduleModelID?.toJson(),
      'studentID': studentID?.toJson(),
      'status': status,
      'statusDate': statusDate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class ExamScheduleModelID {
  final String id;
  final String examDate;
  final ExamTypeID examTypeID;
  final String classID;
  final String status;
  final String statusDate;
  final String createdAt;
  final String updatedAt;
  final int v;

  ExamScheduleModelID({
    required this.id,
    required this.examDate,
    required this.examTypeID,
    required this.classID,
    required this.status,
    required this.statusDate,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ExamScheduleModelID.fromJson(Map<String, dynamic> json) {
    return ExamScheduleModelID(
      id: json['_id'] ?? '',
      examDate: json['examDate'] ?? '',
      examTypeID:
          ExamTypeID.fromJson(json['examTypeID'] as Map<String, dynamic>),
      classID: json['classID'] ?? '',
      status: json['status'] ?? '',
      statusDate: json['statusDate'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'examDate': examDate,
      'examTypeID': examTypeID.toJson(),
      'classID': classID,
      'status': status,
      'statusDate': statusDate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class ExamTypeID {
  final String id;
  final ExamCatID examCatID;
  final String classID;
  final String subjectID;
  final int passingMarks;
  final String status;
  final String statusDate;
  final String createdAt;
  final String updatedAt;
  final int v;

  ExamTypeID({
    required this.id,
    required this.examCatID,
    required this.classID,
    required this.subjectID,
    required this.passingMarks,
    required this.status,
    required this.statusDate,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ExamTypeID.fromJson(Map<String, dynamic> json) {
    return ExamTypeID(
      id: json['_id'] ?? '',
      examCatID: ExamCatID.fromJson(json['examCatID'] as Map<String, dynamic>),
      classID: json['classID'] ?? '',
      subjectID: json['subjectID'] ?? '',
      passingMarks: json['passingMarks'] ?? 0,
      status: json['status'] ?? '',
      statusDate: json['statusDate'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'examCatID': examCatID.toJson(),
      'classID': classID,
      'subjectID': subjectID,
      'passingMarks': passingMarks,
      'status': status,
      'statusDate': statusDate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class ExamCatID {
  final String id;
  final String examCategory;
  final String status;
  final String statusDate;
  final String createdAt;
  final String updatedAt;
  final int v;

  ExamCatID({
    required this.id,
    required this.examCategory,
    required this.status,
    required this.statusDate,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ExamCatID.fromJson(Map<String, dynamic> json) {
    return ExamCatID(
      id: json['_id'] ?? '',
      examCategory: json['examCategory'] ?? '',
      status: json['status'] ?? '',
      statusDate: json['statusDate'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'examCategory': examCategory,
      'status': status,
      'statusDate': statusDate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class StudentID {
  final String id;
  final String name;
  final int rollNo;
  final String dob;
  final String countryOfBirth;
  final String placeOfBirth;
  final String gender;
  final String fatherName;
  final String city;
  final String town;
  final String address;
  final String status;
  final String userId;
  final String remarks;
  final String createdAt;
  final String updatedAt;
  final int v;
  final String profileImage;

  StudentID({
    required this.id,
    required this.name,
    required this.rollNo,
    required this.dob,
    required this.countryOfBirth,
    required this.placeOfBirth,
    required this.gender,
    required this.fatherName,
    required this.city,
    required this.town,
    required this.address,
    required this.status,
    required this.userId,
    required this.remarks,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.profileImage,
  });

  factory StudentID.fromJson(Map<String, dynamic> json) {
    return StudentID(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      rollNo: json['rollNo'] ?? 0,
      dob: json['dob'] ?? '',
      countryOfBirth: json['countryOfBirth'] ?? '',
      placeOfBirth: json['placeOfBirth'] ?? '',
      gender: json['gender'] ?? '',
      fatherName: json['fatherName'] ?? '',
      city: json['city'] ?? '',
      town: json['town'] ?? '',
      address: json['address'] ?? '',
      status: json['status'] ?? '',
      userId: json['userId'] ?? '',
      remarks: json['remarks'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
      profileImage: json['profileImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'rollNo': rollNo,
      'dob': dob,
      'countryOfBirth': countryOfBirth,
      'placeOfBirth': placeOfBirth,
      'gender': gender,
      'fatherName': fatherName,
      'city': city,
      'town': town,
      'address': address,
      'status': status,
      'userId': userId,
      'remarks': remarks,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'profileImage': profileImage,
    };
  }
}
