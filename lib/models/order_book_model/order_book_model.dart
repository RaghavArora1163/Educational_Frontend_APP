// lib/models/order_book_model/order_book_model.dart
class OrderBookModel {
  bool? success;
  OrderBookData? data;
  String? message;

  OrderBookModel({this.success, this.data, this.message});

  OrderBookModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? OrderBookData.fromJson(json['data']) : null;
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

class OrderBookData {
  String? orderId;
  String? paymentId;
  String? razorpayOrderId;
  int? amount;
  String? currency;

  OrderBookData({
    this.orderId,
    this.paymentId,
    this.razorpayOrderId,
    this.amount,
    this.currency,
  });

  OrderBookData.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    paymentId = json['paymentId'];
    razorpayOrderId = json['razorpayOrderId'];
    amount = json['amount'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['paymentId'] = paymentId;
    data['razorpayOrderId'] = razorpayOrderId;
    data['amount'] = amount;
    data['currency'] = currency;
    return data;
  }
}