import 'package:online/models/std_fet_courses_model/std_fet_courses_model.dart';

class OrdersModel {
  bool? success;
  OrdersData? data;
  String? message;

  OrdersModel({this.success, this.data, this.message});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? OrdersData.fromJson(json['data']) : null;
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

class OrdersData {
  List<Orders>? orders;
  Pagination? pagination;

  OrdersData({this.orders, this.pagination});

  OrdersData.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Orders {
  String? orderId;
  String? orderStatus;
  int? totalAmount;
  String? createdAt;
  List<OrderItems>? orderItems;

  Orders({
    this.orderId,
    this.orderStatus,
    this.totalAmount,
    this.createdAt,
    this.orderItems,
  });

  Orders.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderStatus = json['orderStatus'];
    totalAmount = json['totalAmount'];
    createdAt = json['createdAt'];
    if (json['orderItems'] != null) {
      orderItems = <OrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['orderStatus'] = orderStatus;
    data['totalAmount'] = totalAmount;
    data['createdAt'] = createdAt;
    if (orderItems != null) {
      data['orderItems'] = orderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItems {
  String? bookId;
  String? bookName;
  String? bookImage;
  String? creatorName;
  String? bookType;
  int? quantity;
  int? price;
  bool? isPurchased;

  OrderItems({
    this.bookId,
    this.bookName,
    this.bookImage,
    this.creatorName,
    this.bookType,
    this.quantity,
    this.price,
    this.isPurchased,
  });

  OrderItems.fromJson(Map<String, dynamic> json) {
    bookId = json['bookId'];
    bookName = json['bookName'];
    bookImage = json['bookImage'];
    creatorName = json['creatorName'];
    bookType = json['bookType'];
    quantity = json['quantity'];
    price = json['price'];
    isPurchased = json['isPurchased'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookId'] = bookId;
    data['bookName'] = bookName;
    data['bookImage'] = bookImage;
    data['creatorName'] = creatorName;
    data['bookType'] = bookType;
    data['quantity'] = quantity;
    data['price'] = price;
    data['isPurchased'] = isPurchased;
    return data;
  }
}

class Pagination {
  int? page;
  int? limit;
  int? total;
  int? totalPages;

  Pagination({this.page, this.limit, this.total, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    data['totalPages'] = totalPages;
    return data;
  }
}