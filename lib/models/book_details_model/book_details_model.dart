class BookDetailsModel {
  bool? success;
  BookDetailsData? data;
  String? message;

  BookDetailsModel({this.success, this.data, this.message});

  BookDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new BookDetailsData.fromJson(json['data']) : null;
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

class BookDetailsData {
  int? inventoryCount;
  String? sId;
  String? title;
  String? description;
  String? author;
  String? price;
  String? bookType;
  String? coverImage;
  List<Categories>? categories;
  List<Reviews>? reviews;
  Creator? creator;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isWishlisted;
  bool? isAddedToCart;
  bool? isPurchased;

  BookDetailsData(
      {this.inventoryCount,
        this.sId,
        this.title,
        this.description,
        this.author,
        this.price,
        this.bookType,
        this.coverImage,
        this.categories,
        this.reviews,
        this.creator,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.isWishlisted,
        this.isAddedToCart,
        this.isPurchased});

  BookDetailsData.fromJson(Map<String, dynamic> json) {
    inventoryCount = json['inventoryCount'];
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    author = json['author'];
    price = json['price'];
    bookType = json['bookType'];
    coverImage = json['coverImage'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    creator =
    json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isWishlisted = json['isWishlisted'];
    isAddedToCart = json['isAddedToCart'];
    isPurchased = json['isPurchased'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inventoryCount'] = this.inventoryCount;
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['author'] = this.author;
    data['price'] = this.price;
    data['bookType'] = this.bookType;
    data['coverImage'] = this.coverImage;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    if (this.creator != null) {
      data['creator'] = this.creator!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['isWishlisted'] = this.isWishlisted;
    data['isAddedToCart'] = this.isAddedToCart;
    data['isPurchased'] = this.isPurchased;
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

class Reviews {
  String? sId;
  Categories? user;
  int? rating;
  String? comment;
  String? reviewType;
  String? createdAt;

  Reviews(
      {this.sId,
        this.user,
        this.rating,
        this.comment,
        this.reviewType,
        this.createdAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? new Categories.fromJson(json['user']) : null;
    rating = json['rating'];
    comment = json['comment'];
    reviewType = json['reviewType'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['reviewType'] = this.reviewType;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Creator {
  String? sId;
  String? email;

  Creator({this.sId, this.email});

  Creator.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    return data;
  }
}
