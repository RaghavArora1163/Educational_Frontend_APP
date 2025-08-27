class SupportQueryModel {
  bool? success;
  SupportQueryData? data;
  String? message;

  SupportQueryModel({this.success, this.data, this.message});

  SupportQueryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    data = json['data'] != null ? SupportQueryData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class SupportQueryData {
  String? id;
  String? subject;
  String? status;
  String? createdAt;

  SupportQueryData({this.id, this.subject, this.status, this.createdAt});

  SupportQueryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    status = json['status'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject'] = subject;
    data['status'] = status;
    data['createdAt'] = createdAt;
    return data;
  }
}