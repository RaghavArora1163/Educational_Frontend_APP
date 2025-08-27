class TakeTestSeriesModel {
  bool? success;
  TakeTestSeriesData? data;
  String? message;

  TakeTestSeriesModel({this.success, this.data, this.message});

  TakeTestSeriesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new TakeTestSeriesData.fromJson(json['data']) : null;
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

class TakeTestSeriesData {
  String? sId;
  String? testTitle;
  String? testDate;
  String? duration;
  int? questionCount;
  List<Questions>? questions;

  TakeTestSeriesData(
      {this.sId,
        this.testTitle,
        this.testDate,
        this.duration,
        this.questionCount,
        this.questions});

  TakeTestSeriesData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    testTitle = json['testTitle'];
    testDate = json['testDate'];
    duration = json['duration'];
    questionCount = json['questionCount'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['testTitle'] = this.testTitle;
    data['testDate'] = this.testDate;
    data['duration'] = this.duration;
    data['questionCount'] = this.questionCount;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? sId;
  String? questionText;
  List<String>? options;
  String? correctAnswer;
  int? marks;
  String? questionType;

  Questions(
      {this.sId,
        this.questionText,
        this.options,
        this.correctAnswer,
        this.marks,
        this.questionType});

  Questions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    questionText = json['questionText'];
    options = json['options'].cast<String>();
    correctAnswer = json['correctAnswer'];
    marks = json['marks'];
    questionType = json['questionType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['questionText'] = this.questionText;
    data['options'] = this.options;
    data['correctAnswer'] = this.correctAnswer;
    data['marks'] = this.marks;
    data['questionType'] = this.questionType;
    return data;
  }
}
