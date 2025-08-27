class SubmitModel {
  bool? success;
  SubmitData? data;
  String? message;

  SubmitModel({this.success, this.data, this.message});

  SubmitModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new SubmitData.fromJson(json['data']) : null;
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

class SubmitData {
  int? score;
  int? totalMarks;

  SubmitData({this.score, this.totalMarks});

  SubmitData.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    totalMarks = json['totalMarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['score'] = this.score;
    data['totalMarks'] = this.totalMarks;
    return data;
  }
}
