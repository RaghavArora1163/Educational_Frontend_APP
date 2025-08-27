class TestSeriesModel {
  bool? success;
  List<TestSeriesData>? data;
  String? message;

  TestSeriesModel({this.success, this.data, this.message});

  TestSeriesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TestSeriesData>[];
      json['data'].forEach((v) {
        data!.add(new TestSeriesData.fromJson(v));
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

class TestSeriesData {
  String? sId;
  String? title;
  String? description;
  String? price;
  List<Categories>? categories;
  String? coverImage;
  bool? isInWishlist;
  bool? inCart;

  TestSeriesData(
      {this.sId,
        this.title,
        this.description,
        this.price,
        this.categories,
        this.coverImage,
        this.isInWishlist,
        this.inCart});

  TestSeriesData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    coverImage = json['coverImage'];
    isInWishlist = json['isInWishlist'];
    inCart = json['inCart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['coverImage'] = this.coverImage;
    data['isInWishlist'] = this.isInWishlist;
    data['inCart'] = this.inCart;
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
