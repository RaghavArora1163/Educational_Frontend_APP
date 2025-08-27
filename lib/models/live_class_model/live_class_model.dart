class LiveClassModel {
  bool? success;
  LiveModelData? data;
  String? message;

  LiveClassModel({this.success, this.data, this.message});

  LiveClassModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new LiveModelData.fromJson(json['data']) : null;
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

class LiveModelData {
  String? id;
  String? title;
  String? description;
  String? startTime;
  Null? endTime;
  String? courseId;
  String? courseTitle;
  String? courseImage;
  String? status;
  String? hlsUrl;

  LiveModelData(
      {this.id,
        this.title,
        this.description,
        this.startTime,
        this.endTime,
        this.courseId,
        this.courseTitle,
        this.courseImage,
        this.status,
        this.hlsUrl});

  LiveModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    courseId = json['courseId'];
    courseTitle = json['courseTitle'];
    courseImage = json['courseImage'];
    status = json['status'];
    hlsUrl = json['hlsUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['courseId'] = this.courseId;
    data['courseTitle'] = this.courseTitle;
    data['courseImage'] = this.courseImage;
    data['status'] = this.status;
    data['hlsUrl'] = this.hlsUrl;
    return data;
  }
}
