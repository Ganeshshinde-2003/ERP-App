class StudentDetailsSectionWise {
  bool success;
  String message;
  List<StudentData> data;

  StudentDetailsSectionWise({
    required this.success,
    required this.message,
    required this.data,
  });

  factory StudentDetailsSectionWise.fromJson(Map<String, dynamic> json) {
    return StudentDetailsSectionWise(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List<dynamic>)
          .map((studentData) => StudentData.fromJson(studentData))
          .toList(),
    );
  }
}

class StudentData {
  String id;
  String admissionDate;
  StudentID studentID;
  AcademicYear academicYear;
  ClassID classID;
  String sectionID;
  String status;
  String updatedBy;
  bool attendanceStatus;

  StudentData({
    required this.id,
    required this.admissionDate,
    required this.studentID,
    required this.academicYear,
    required this.classID,
    required this.sectionID,
    required this.status,
    required this.updatedBy,
    required this.attendanceStatus,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) {
    return StudentData(
      id: json['_id'],
      admissionDate: json['admissionDate'],
      studentID: StudentID.fromJson(json['studentID']),
      academicYear: AcademicYear.fromJson(json['academicYear']),
      classID: ClassID.fromJson(json['classID']),
      sectionID: json['sectionID'],
      status: json['status'],
      updatedBy: json['updatedBy'],
      attendanceStatus: true,
    );
  }
}

class StudentID {
  String id;
  String name;
  int rollNo;
  String dob;
  String gender;
  String city;
  String address;
  String userId;

  StudentID({
    required this.id,
    required this.name,
    required this.rollNo,
    required this.dob,
    required this.gender,
    required this.city,
    required this.address,
    required this.userId,
  });

  factory StudentID.fromJson(Map<String, dynamic> json) {
    return StudentID(
      id: json['_id'],
      name: json['name'],
      rollNo: json['rollNo'],
      dob: json['dob'],
      gender: json['gender'],
      city: json['city'],
      address: json['address'],
      userId: json['userId'],
    );
  }
}

class AcademicYear {
  String id;
  String academicYear;

  AcademicYear({
    required this.id,
    required this.academicYear,
  });

  factory AcademicYear.fromJson(Map<String, dynamic> json) {
    return AcademicYear(
      id: json['_id'],
      academicYear: json['academicYear'],
    );
  }
}

class ClassID {
  String id;
  String className;
  String division;
  int strength;

  ClassID({
    required this.id,
    required this.className,
    required this.division,
    required this.strength,
  });

  factory ClassID.fromJson(Map<String, dynamic> json) {
    return ClassID(
      id: json['_id'],
      className: json['className'],
      division: json['division'],
      strength: json['strength'],
    );
  }
}
