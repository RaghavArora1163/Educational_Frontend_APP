class TestSeriesDetailModel {
  bool? success;
  TestSeriesDetailData? data;
  String? message;

  TestSeriesDetailModel({this.success, this.data, this.message});

  TestSeriesDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new TestSeriesDetailData.fromJson(json['data']) : null;
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

class TestSeriesDetailData {
  String? sId;
  String? title;
  bool? isEnrolled;
  String? description;
  String? price;
  String? coverImage;
  Categories? categories;
  int? testCount;
  String? totalDuration;
  Creator?  creator;
  List<Tests>? tests;
  List<SimilarTestSeries>? similarTestSeries;

  TestSeriesDetailData(
      {this.sId,
        this.title,
        this.isEnrolled,
        this.description,
        this.price,
        this.coverImage,
        this.categories,
        this.testCount,
        this.totalDuration,
        this.creator,
        this.tests,
        this.similarTestSeries});

  TestSeriesDetailData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    isEnrolled = json['isEnrolled'];
    description = json['description'];
    price = json['price'];
    coverImage = json['coverImage'];
    categories = json['categories'] != null
        ? new Categories.fromJson(json['categories'])
        : null;
    testCount = json['testCount'];
    totalDuration = json['totalDuration'];
    creator = json['creator'] != null
        ? new Creator.fromJson(json['creator'])
        : null;
    if (json['tests'] != null) {
      tests = <Tests>[];
      json['tests'].forEach((v) {
        tests!.add(new Tests.fromJson(v));
      });
    }
    if (json['similarTestSeries'] != null) {
      similarTestSeries = <SimilarTestSeries>[];
      json['similarTestSeries'].forEach((v) {
        similarTestSeries!.add(new SimilarTestSeries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['isEnrolled'] = this.isEnrolled;
    data['description'] = this.description;
    data['price'] = this.price;
    data['coverImage'] = this.coverImage;
    if (this.categories != null) {
      data['categories'] = this.categories!.toJson();
    }
    data['testCount'] = this.testCount;
    data['totalDuration'] = this.totalDuration;
    data['creator'] = this.creator;
    if (this.tests != null) {
      data['tests'] = this.tests!.map((v) => v.toJson()).toList();
    }
    if (this.similarTestSeries != null) {
      data['similarTestSeries'] =
          this.similarTestSeries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Creator {
  String? id;
  String? name;

  Creator({
    this.id,
    this.name,
  });

  Creator.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    return data;
  }

}

class Categories {
  String? sId;
  String? name;

  Categories({this.sId, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class Tests {
  String? sId;
  String? testTitle;
  String? testDate;
  String? duration;
  int? questionCount;
  String? creator;

  Tests(
      {this.sId,
        this.testTitle,
        this.testDate,
        this.duration,
        this.questionCount,
        this.creator});

  Tests.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    testTitle = json['testTitle'];
    testDate = json['testDate'];
    duration = json['duration'];
    questionCount = json['questionCount'];
    creator = json['creator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['testTitle'] = this.testTitle;
    data['testDate'] = this.testDate;
    data['duration'] = this.duration;
    data['questionCount'] = this.questionCount;
    data['creator'] = this.creator;
    return data;
  }
}

class SimilarTestSeries {
  String? sId;
  String? title;
  String? price;
  String? coverImage;
  List<Categories>? categories;
  int? testCount;

  SimilarTestSeries(
      {this.sId,
        this.title,
        this.price,
        this.coverImage,
        this.categories,
        this.testCount});

  SimilarTestSeries.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    price = json['price'];
    coverImage = json['coverImage'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    testCount = json['testCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['coverImage'] = this.coverImage;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['testCount'] = this.testCount;
    return data;
  }
}
