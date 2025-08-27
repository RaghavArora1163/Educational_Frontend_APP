class StudentQuizzesModel {
  bool? success;
  List<QuizzesData>? data;
  String? message;

  StudentQuizzesModel({this.success, this.data, this.message});

  StudentQuizzesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <QuizzesData>[];
      json['data'].forEach((v) {
        data!.add(new QuizzesData.fromJson(v));
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

class QuizzesData {
  String? title;
  String? description;
  String? duration;
  String? status;
  String? id;

  QuizzesData({this.title, this.description, this.duration, this.status, this.id});

  QuizzesData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    status = json['status'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['status'] = this.status;
    data['id'] = this.id;
    return data;
  }
}
