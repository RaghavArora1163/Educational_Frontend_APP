class StdFetCoursesModel {
  bool? success;
  StudentFeaturesData? data;
  String? message;

  StdFetCoursesModel({this.success, this.data, this.message});

  StdFetCoursesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new StudentFeaturesData.fromJson(json['data']) : null;
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

class StudentFeaturesData {
  List<Courses>? courses;
  Pagination? pagination;

  StudentFeaturesData({this.courses, this.pagination});

  StudentFeaturesData.fromJson(Map<String, dynamic> json) {
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Courses {
  String? sId;
  String? title;
  String? description;
  List<Categories>? categories;
  String? difficulty;
  String? courseImage;
  String? courseType;
  int? coursePrice;
  bool? isInWishlist;
  bool? inCart;

  Courses(
      {this.sId,
        this.title,
        this.description,
        this.categories,
        this.difficulty,
        this.courseImage,
        this.courseType,
        this.coursePrice,
        this.isInWishlist,
        this.inCart
      });

  Courses.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    difficulty = json['difficulty'];
    courseImage = json['courseImage'];
    courseType = json['courseType'];
    coursePrice = json['coursePrice'];
    isInWishlist = json['isInWishlist'];
    inCart = json['inCart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['difficulty'] = this.difficulty;
    data['courseImage'] = this.courseImage;
    data['courseType'] = this.courseType;
    data['coursePrice'] = this.coursePrice;
    data['isInWishlist'] = this.isInWishlist;
    data['inCart'] = this.inCart;
    return data;
  }
}

class Categories {
  String? sId;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Categories(
      {this.sId,
        this.name,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Categories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Pagination {
  int? page;
  int? limit;
  int? total;

  Pagination({this.page, this.limit, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['total'] = this.total;
    return data;
  }
}
