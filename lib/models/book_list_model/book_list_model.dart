class BookListModel {
  bool? success;
  BookData? data;
  String? message;

  BookListModel({this.success, this.data, this.message});

  BookListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new BookData.fromJson(json['data']) : null;
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

class BookData {
  List<Books>? books;

  BookData({this.books});

  BookData.fromJson(Map<String, dynamic> json) {
    if (json['books'] != null) {
      books = <Books>[];
      json['books'].forEach((v) {
        books!.add(new Books.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.books != null) {
      data['books'] = this.books!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Books {
  String? sId;
  String? title;
  int? price;
  String? bookType;
  String? coverImage;
  List<Categories>? categories;
  bool? isInWishlist;
  bool? inCart;

  Books(
      {this.sId,
        this.title,
        this.price,
        this.bookType,
        this.coverImage,
        this.categories,
        this.isInWishlist,
        this.inCart});

  Books.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    price = json['price'];
    bookType = json['bookType'];
    coverImage = json['coverImage'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    isInWishlist = json['isInWishlist'];
    inCart = json['inCart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['bookType'] = this.bookType;
    data['coverImage'] = this.coverImage;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
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
