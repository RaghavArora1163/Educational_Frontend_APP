class StudentResourcesModel {
  bool? success;
  ResourcesData? data;
  String? message;

  StudentResourcesModel({this.success, this.data, this.message});

  StudentResourcesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new ResourcesData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class ResourcesData {
  String? courseTitle;
  int? totalResources;
  List<Resources>? resources;
  String? status;

  ResourcesData({this.courseTitle, this.totalResources, this.resources, this.status});

  ResourcesData.fromJson(Map<String, dynamic> json) {
    courseTitle = json['courseTitle'];
    totalResources = json['totalResources'];
    if (json['resources'] != null) {
      resources = <Resources>[];
      json['resources'].forEach((v) {
        resources!.add(new Resources.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseTitle'] = this.courseTitle;
    data['totalResources'] = this.totalResources;
    if (this.resources != null) {
      data['resources'] = this.resources!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Resources {
  String? moduleTitle;
  String? lectureTitle;
  List<String>? resources;
  int? resourceCount;

  Resources(
      {this.moduleTitle,
        this.lectureTitle,
        this.resources,
        this.resourceCount});

  Resources.fromJson(Map<String, dynamic> json) {
    moduleTitle = json['moduleTitle'];
    lectureTitle = json['lectureTitle'];
    resources = json['resources'].cast<String>();
    resourceCount = json['resourceCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['moduleTitle'] = this.moduleTitle;
    data['lectureTitle'] = this.lectureTitle;
    data['resources'] = this.resources;
    data['resourceCount'] = this.resourceCount;
    return data;
  }
}
