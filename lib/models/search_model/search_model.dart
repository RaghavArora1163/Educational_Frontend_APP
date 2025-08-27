import 'package:online/models/std_fet_courses_model/std_fet_courses_model.dart';

class SearchModel {
  bool? success;
  SearchData? data;
  String? message;

  SearchModel({this.success, this.data, this.message});

  SearchModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? SearchData.fromJson(json['data']) : null;
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

class SearchData {
  List<SearchResult>? results;
  SearchPagination? pagination;

  SearchData({this.results, this.pagination});

  SearchData.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <SearchResult>[];
      json['results'].forEach((v) {
        results!.add(SearchResult.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? SearchPagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class SearchResult {
  String? type;
  String? id;
  String? title;
  String? description;
  String? coverImage;
  List<String>? categories;
  String? courseType;
  String? difficulty;

  SearchResult({
    this.type,
    this.id,
    this.title,
    this.description,
    this.coverImage,
    this.categories,
    this.courseType,
    this.difficulty,
  });

  SearchResult.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    coverImage = json['coverImage'];
    categories = json['categories']?.cast<String>();
    courseType = json['courseType'];
    difficulty = json['difficulty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['coverImage'] = coverImage;
    data['categories'] = categories;
    data['courseType'] = courseType;
    data['difficulty'] = difficulty;
    return data;
  }
}

class SearchPagination {
  int? page;
  int? limit;
  int? total;
  int? totalBooks;
  int? totalCourses;
  int? totalTestSeries;

  SearchPagination({
    this.page,
    this.limit,
    this.total,
    this.totalBooks,
    this.totalCourses,
    this.totalTestSeries,
  });

  SearchPagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalBooks = json['totalBooks'];
    totalCourses = json['totalCourses'];
    totalTestSeries = json['totalTestSeries'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    data['totalBooks'] = totalBooks;
    data['totalCourses'] = totalCourses;
    data['totalTestSeries'] = totalTestSeries;
    return data;
  }
}