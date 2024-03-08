class StudentSectionTimeTable {
  bool success;
  String message;
  Map<String, List<ClassSchedule>> data;

  StudentSectionTimeTable({
    required this.success,
    required this.message,
    required this.data,
  });

  factory StudentSectionTimeTable.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> jsonData = json['data'];
    Map<String, List<ClassSchedule>> dataMap = {};

    jsonData.forEach((key, value) {
      List<ClassSchedule> scheduleList = (value as List)
          .map((scheduleJson) => ClassSchedule.fromJson(scheduleJson))
          .toList();
      dataMap[key] = scheduleList;
    });

    return StudentSectionTimeTable(
      success: json['success'],
      message: json['message'],
      data: dataMap,
    );
  }
}

class ClassSchedule {
  String id;
  SessionID sessionID;
  TeacherID teacherID;
  String startTime;
  String endTime;
  int duration;
  String status;
  int day;

  ClassSchedule({
    required this.id,
    required this.sessionID,
    required this.teacherID,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.status,
    required this.day,
  });

  factory ClassSchedule.fromJson(Map<String, dynamic> json) {
    return ClassSchedule(
      id: json['_id'],
      sessionID: SessionID.fromJson(json['sessionID']),
      teacherID: TeacherID.fromJson(json['teacherID']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      duration: json['duration'],
      status: json['status'],
      day: json['day'],
    );
  }
}

class SessionID {
  String id;
  String sessionName;
  ClassId classId;
  SubjectId subjectId;
  SectionId sectionId;

  SessionID({
    required this.id,
    required this.sessionName,
    required this.classId,
    required this.subjectId,
    required this.sectionId,
  });

  factory SessionID.fromJson(Map<String, dynamic> json) {
    return SessionID(
      id: json['_id'],
      sessionName: json['sessionName'],
      classId: ClassId.fromJson(json['classId']),
      subjectId: SubjectId.fromJson(json['subjectId']),
      sectionId: SectionId.fromJson(json['sectionId']),
    );
  }
}

class ClassId {
  String id;
  String className;

  ClassId({
    required this.id,
    required this.className,
  });

  factory ClassId.fromJson(Map<String, dynamic> json) {
    return ClassId(
      id: json['_id'],
      className: json['className'],
    );
  }
}

class SubjectId {
  String id;
  String subjectName;

  SubjectId({
    required this.id,
    required this.subjectName,
  });

  factory SubjectId.fromJson(Map<String, dynamic> json) {
    return SubjectId(
      id: json['_id'],
      subjectName: json['subjectName'],
    );
  }
}

class SectionId {
  String id;
  String sectionName;

  SectionId({
    required this.id,
    required this.sectionName,
  });

  factory SectionId.fromJson(Map<String, dynamic> json) {
    return SectionId(
      id: json['_id'],
      sectionName: json['sectionName'],
    );
  }
}

class TeacherID {
  String id;
  String employeeName;
  int empNumber;

  TeacherID({
    required this.id,
    required this.employeeName,
    required this.empNumber,
  });

  factory TeacherID.fromJson(Map<String, dynamic> json) {
    return TeacherID(
      id: json['_id'],
      employeeName: json['employeeName'],
      empNumber: json['empNumber'],
    );
  }
}
