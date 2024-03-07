class StudentLoginModel {
  bool success;
  String message;
  UserData data;

  StudentLoginModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory StudentLoginModel.fromJson(Map<String, dynamic> json) {
    return StudentLoginModel(
      success: json['success'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class UserData {
  String token;
  StudentUser user;
  AdmissionDetails admissionDetails;

  UserData({
    required this.token,
    required this.user,
    required this.admissionDetails,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      token: json['token'],
      user: StudentUser.fromJson(json['user']),
      admissionDetails: AdmissionDetails.fromJson(json['admissionDetails']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user.toJson(),
      'admissionDetails': admissionDetails.toJson(),
    };
  }
}

class StudentUser {
  String userId;
  String email;
  String fullName;
  String role;

  StudentUser({
    required this.userId,
    required this.email,
    required this.fullName,
    required this.role,
  });

  factory StudentUser.fromJson(Map<String, dynamic> json) {
    return StudentUser(
      userId: json['userId'],
      email: json['email'],
      fullName: json['fullName'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'fullName': fullName,
      'role': role,
    };
  }
}

class AdmissionDetails {
  String id;
  String admissionDate;
  StudentID studentID;
  String academicYear;
  ClassID classID;
  SectionID sectionID;
  String status;
  String updatedBy;

  AdmissionDetails({
    required this.id,
    required this.admissionDate,
    required this.studentID,
    required this.academicYear,
    required this.classID,
    required this.sectionID,
    required this.status,
    required this.updatedBy,
  });

  factory AdmissionDetails.fromJson(Map<String, dynamic> json) {
    return AdmissionDetails(
      id: json['_id'],
      admissionDate: json['admissionDate'],
      studentID: StudentID.fromJson(json['studentID']),
      academicYear: json['academicYear'],
      classID: ClassID.fromJson(json['classID']),
      sectionID: SectionID.fromJson(json['sectionID']),
      status: json['status'],
      updatedBy: json['updatedBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'admissionDate': admissionDate,
      'studentID': studentID.toJson(),
      'academicYear': academicYear,
      'classID': classID.toJson(),
      'sectionID': sectionID.toJson(),
      'status': status,
      'updatedBy': updatedBy,
    };
  }
}

class StudentID {
  String id;
  String name;
  String dob;
  String gender;

  StudentID({
    required this.id,
    required this.name,
    required this.dob,
    required this.gender,
  });

  factory StudentID.fromJson(Map<String, dynamic> json) {
    return StudentID(
      id: json['_id'],
      name: json['name'],
      dob: json['dob'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'dob': dob,
      'gender': gender,
    };
  }
}

class ClassID {
  String id;
  String className;
  String division;

  ClassID({
    required this.id,
    required this.className,
    required this.division,
  });

  factory ClassID.fromJson(Map<String, dynamic> json) {
    return ClassID(
      id: json['_id'],
      className: json['className'],
      division: json['division'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'className': className,
      'division': division,
    };
  }
}

class SectionID {
  String id;
  String sectionName;

  SectionID({
    required this.id,
    required this.sectionName,
  });

  factory SectionID.fromJson(Map<String, dynamic> json) {
    return SectionID(
      id: json['_id'],
      sectionName: json['sectionName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'sectionName': sectionName,
    };
  }
}
