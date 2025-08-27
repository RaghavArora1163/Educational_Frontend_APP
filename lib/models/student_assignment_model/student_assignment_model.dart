class StudentAssignmentModel {
  bool? success;
  List<AssignmentData>? data;
  String? message;

  StudentAssignmentModel({this.success, this.data, this.message});

  StudentAssignmentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AssignmentData>[];
      json['data'].forEach((v) {
        data!.add(new AssignmentData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class AssignmentData {
  String? title;
  String? description;
  String? dueDate;
  String? status;
  String? id;

  AssignmentData({this.title, this.description, this.dueDate, this.status, this.id});

  AssignmentData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    dueDate = json['dueDate'];
    status = json['status'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['dueDate'] = this.dueDate;
    data['status'] = this.status;
    data['id'] = this.id;
    return data;
  }
}
