class MasterDataCache {
  bool success;
  String message;
  Data data;

  MasterDataCache({
    required this.success,
    required this.message,
    required this.data,
  });

  factory MasterDataCache.fromJson(Map<String, dynamic> json) {
    return MasterDataCache(
      success: json['success'],
      message: json['message'],
      data: Data.fromJson(json['data']),
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

class Data {
  List<Class> classes;
  List<Section> sections;
  List<Subject> subjects;

  Data({
    required this.classes,
    required this.sections,
    required this.subjects,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      classes: (json['classes'] as List)
          .map((classJson) => Class.fromJson(classJson))
          .toList(),
      sections: (json['sections'] as List)
          .map((sectionJson) => Section.fromJson(sectionJson))
          .toList(),
      subjects: (json['subjects'] as List)
          .map((subjectJson) => Subject.fromJson(subjectJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'classes': classes.map((classItem) => classItem.toJson()).toList(),
      'sections': sections.map((sectionItem) => sectionItem.toJson()).toList(),
      'subjects': subjects.map((subjectItem) => subjectItem.toJson()).toList(),
    };
  }
}

class Class {
  String id;
  String className;

  Class({
    required this.id,
    required this.className,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['_id'],
      className: json['className'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'className': className,
    };
  }
}

class Section {
  String id;
  String classId;
  String sectionName;

  Section({
    required this.id,
    required this.classId,
    required this.sectionName,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['_id'],
      classId: json['classId'],
      sectionName: json['sectionName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'classId': classId,
      'sectionName': sectionName,
    };
  }
}

class Subject {
  String id;
  String classId;
  String subjectName;

  Subject({
    required this.id,
    required this.classId,
    required this.subjectName,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['_id'],
      classId: json['classId'],
      subjectName: json['subjectName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'classId': classId,
      'subjectName': subjectName,
    };
  }
}
