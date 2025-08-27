class PaymentModel {
  bool? success;
  PaymentData? data;
  String? message;

  PaymentModel({this.success, this.data, this.message});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new PaymentData.fromJson(json['data']) : null;
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

class PaymentData {
  bool? isEnrolled;

  PaymentData({this.isEnrolled});

  PaymentData.fromJson(Map<String, dynamic> json) {
    isEnrolled = json['isEnrolled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isEnrolled'] = this.isEnrolled;
    return data;
  }
}
