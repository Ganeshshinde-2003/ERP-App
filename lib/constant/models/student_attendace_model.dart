class StudentDetailsSectionWise {
  bool success;
  String message;
  List<StudentData> data;

  StudentDetailsSectionWise(
      {required this.success, required this.message, required this.data});

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
  Student studentID;
  AcademicYear academicYear;
  ClassID classID;
  String sectionID;
  String status;
  String statusDate;
  String updatedBy;
  String createdAt;
  String updatedAt;

  StudentData({
    required this.id,
    required this.admissionDate,
    required this.studentID,
    required this.academicYear,
    required this.classID,
    required this.sectionID,
    required this.status,
    required this.statusDate,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) {
    return StudentData(
      id: json['_id'],
      admissionDate: json['admissionDate'],
      studentID: Student.fromJson(json['studentID']),
      academicYear: AcademicYear.fromJson(json['academicYear']),
      classID: ClassID.fromJson(json['classID']),
      sectionID: json['sectionID'],
      status: json['status'],
      statusDate: json['statusDate'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class Student {
  String id;
  String name;
  int rollNo;
  String dob;
  String countryOfBirth;
  String placeOfBirth;
  String gender;
  String fatherName;
  String city;
  String town;
  String address;
  String status;
  String userId;
  String remarks;
  String createdAt;
  String updatedAt;

  Student({
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
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'],
      name: json['name'],
      rollNo: json['rollNo'],
      dob: json['dob'],
      countryOfBirth: json['countryOfBirth'],
      placeOfBirth: json['placeOfBirth'],
      gender: json['gender'],
      fatherName: json['fatherName'],
      city: json['city'],
      town: json['town'],
      address: json['address'],
      status: json['status'],
      userId: json['userId'],
      remarks: json['remarks'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class AcademicYear {
  String id;
  String academicYear;
  String createdAt;
  String updatedAt;

  AcademicYear({
    required this.id,
    required this.academicYear,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AcademicYear.fromJson(Map<String, dynamic> json) {
    return AcademicYear(
      id: json['_id'],
      academicYear: json['academicYear'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class ClassID {
  String id;
  String className;
  String division;
  String status;
  String statusDate;
  String createdAt;
  String updatedAt;
  int strength;

  ClassID({
    required this.id,
    required this.className,
    required this.division,
    required this.status,
    required this.statusDate,
    required this.createdAt,
    required this.updatedAt,
    required this.strength,
  });

  factory ClassID.fromJson(Map<String, dynamic> json) {
    return ClassID(
      id: json['_id'],
      className: json['className'],
      division: json['division'],
      status: json['status'],
      statusDate: json['statusDate'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      strength: json['strength'],
    );
  }
}
