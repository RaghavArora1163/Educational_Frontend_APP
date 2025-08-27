class TestProgressModel {
  bool? success;
  TestProgressData? data;
  String? message;

  TestProgressModel({this.success, this.data, this.message});

  TestProgressModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? TestProgressData.fromJson(json['data']) : null;
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

class TestProgressData {
  String? testId;
  String? testTitle;
  bool? isCompleted;
  int? score;
  int? totalMarks;
  List<ProgressQuestion>? questions;
  String? creatorName;
  Meta? meta;

  TestProgressData({
    this.testId,
    this.testTitle,
    this.isCompleted,
    this.score,
    this.totalMarks,
    this.questions,
    this.creatorName,
    this.meta,
  });

  TestProgressData.fromJson(Map<String, dynamic> json) {
    testId = json['testId'];
    testTitle = json['testTitle'];
    isCompleted = json['isCompleted'];
    score = json['score'];
    totalMarks = json['totalMarks'];
    if (json['questions'] != null) {
      questions = <ProgressQuestion>[];
      json['questions'].forEach((v) {
        questions!.add(ProgressQuestion.fromJson(v));
      });
    }
    creatorName = json['creatorName'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['testId'] = testId;
    data['testTitle'] = testTitle;
    data['isCompleted'] = isCompleted;
    data['score'] = score;
    data['totalMarks'] = totalMarks;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    data['creatorName'] = creatorName;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class ProgressQuestion {
  String? questionId;
  String? questionText;
  List<String>? options;
  String? correctAnswer;
  int? marks;
  String? questionType;
  String? studentAnswer;
  bool? isCorrect;

  ProgressQuestion({
    this.questionId,
    this.questionText,
    this.options,
    this.correctAnswer,
    this.marks,
    this.questionType,
    this.studentAnswer,
    this.isCorrect,
  });

  ProgressQuestion.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    questionText = json['questionText'];
    options = json['options']?.cast<String>();
    correctAnswer = json['correctAnswer'];
    marks = json['marks'];
    questionType = json['questionType'];
    studentAnswer = json['studentAnswer'];
    isCorrect = json['isCorrect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['questionId'] = questionId;
    data['questionText'] = questionText;
    data['options'] = options;
    data['correctAnswer'] = correctAnswer;
    data['marks'] = marks;
    data['questionType'] = questionType;
    data['studentAnswer'] = studentAnswer;
    data['isCorrect'] = isCorrect;
    return data;
  }
}

class Meta {
  String? duration;
  String? testDate;
  String? submittedAt;

  Meta({this.duration, this.testDate, this.submittedAt});

  Meta.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    testDate = json['testDate'];
    submittedAt = json['submittedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['duration'] = duration;
    data['testDate'] = testDate;
    data['submittedAt'] = submittedAt;
    return data;
  }
}
