class SubmitResponseModel {
  bool? success;
  SubmitData? data;
  String? message;

  SubmitResponseModel({this.success, this.data, this.message});

  SubmitResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? SubmitData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
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
    final Map<String, dynamic> data = {};
    data['score'] = score;
    data['totalMarks'] = totalMarks;
    return data;
  }
}