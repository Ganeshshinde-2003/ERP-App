class ResourceModel {
  late bool success;
  late String message;
  late List<ResourceData> data;

  ResourceModel({
    required this.success,
    required this.message,
    required this.data,
  });

  ResourceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ResourceData>[];
      json['data'].forEach((v) {
        data.add(ResourceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }
}

class ResourceData {
  late String id;
  late String title;
  late String description;
  late String uploadedFileUrl;

  ResourceData({
    required this.id,
    required this.title,
    required this.description,
    required this.uploadedFileUrl,
  });

  ResourceData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    uploadedFileUrl = json['uploadedFileUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['uploadedFileUrl'] = uploadedFileUrl;
    return data;
  }
}
