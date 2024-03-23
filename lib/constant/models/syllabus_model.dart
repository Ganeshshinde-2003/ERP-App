class SyllabusResponse {
  bool success;
  String message;
  SyllabusData data;

  SyllabusResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SyllabusResponse.fromJson(Map<String, dynamic> json) {
    return SyllabusResponse(
      success: json['success'],
      message: json['message'],
      data: SyllabusData.fromJson(json['data']),
    );
  }
}

class SyllabusData {
  List<Syllabus> syllabus;

  SyllabusData({
    required this.syllabus,
  });

  factory SyllabusData.fromJson(Map<String, dynamic> json) {
    List<dynamic> syllabusList = json['syllabus'];
    List<Syllabus> parsedSyllabusList =
        syllabusList.map((e) => Syllabus.fromJson(e)).toList();

    return SyllabusData(syllabus: parsedSyllabusList);
  }
}

class Syllabus {
  String id;
  int chapterNo;
  String title;
  String description;
  AcademicYear academicYear;
  String additionalInformation;
  String status;

  Syllabus({
    required this.id,
    required this.chapterNo,
    required this.title,
    required this.description,
    required this.academicYear,
    required this.additionalInformation,
    required this.status,
  });

  factory Syllabus.fromJson(Map<String, dynamic> json) {
    return Syllabus(
      id: json['_id'],
      chapterNo: json['chapterNo'],
      title: json['title'],
      description: json['description'],
      academicYear: AcademicYear.fromJson(json['academicYear']),
      additionalInformation: json['additionalInformation'],
      status: json['status'],
    );
  }
}

class AcademicYear {
  String id;
  DateTime academicYear;

  AcademicYear({
    required this.id,
    required this.academicYear,
  });

  factory AcademicYear.fromJson(Map<String, dynamic> json) {
    return AcademicYear(
      id: json['_id'],
      academicYear: DateTime.parse(json['academicYear']),
    );
  }
}
